import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:game/utils/const.dart';
import 'package:game/utils/utils.dart';
import 'package:game/widgets/appbar_widget.dart';

class HomePage extends StatefulWidget {
  final User user;

  HomePage(this.user);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ElevatedBtnWidget> _buttons = List();
  List<Icon> _icons = List();
  List<bool> _userSelection = List();

  List<int> _user1Positions = List();
  List<int> _user2Positions = List();

  //  check if it's user 1's turn or not...
  bool _isUser1Turn = true;
  String resultVal = "";
  int _user;

  bool _resultVisibility = false;

  final _databaseReference =
      FirebaseDatabase(app: Firebase.app(), databaseURL: ConstUtils.dbURL)
          .reference();

  @override
  void initState() {
    super.initState();
    _user = 1;
    resetTicTacToe();

    _databaseReference.onChildChanged.listen((event) {
      final _dataSnapShot = event.snapshot;
      int position = _dataSnapShot.value[ConstUtils.position];
      int user = _dataSnapShot.value[ConstUtils.user];
      if (user == 1) {
        _user1Positions.add(position);
      } else {
        _user2Positions.add(position);
      }

      if (isWon(_user1Positions)) {
        showResult('User 1 won');
      } else if (isWon(_user2Positions)) {
        showResult('User 2 won');
      } else if ((_user1Positions.length + _user2Positions.length) == 9) {
        showResult('Draw');
      }
    });
  }

  showResult(String result) {
    setState(() {
      _resultVisibility = true;
      resultVal = result;
    });
  }

  bool isWon(List<int> positions) {
    if ((positions.contains(0) &&
            positions.contains(1) &&
            positions.contains(2)) ||
        (positions.contains(3) &&
            positions.contains(4) &&
            positions.contains(5)) ||
        (positions.contains(6) &&
            positions.contains(7) &&
            positions.contains(8))) {
      return true;
    } else if ((positions.contains(0) &&
            positions.contains(3) &&
            positions.contains(6)) ||
        (positions.contains(1) &&
            positions.contains(4) &&
            positions.contains(7)) ||
        (positions.contains(2) &&
            positions.contains(5) &&
            positions.contains(8))) {
      return true;
    } else if ((positions.contains(0) &&
            positions.contains(4) &&
            positions.contains(8)) ||
        (positions.contains(2) &&
            positions.contains(4) &&
            positions.contains(6))) {
      return true;
    } else {
      return false;
    }
  }

  bool checkEquality(int val1, int val2) {
    return val1 == val2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          action: IconButton(
        icon: Icon(Icons.refresh),
        onPressed: () {
          resetTicTacToe();
        },
      )),
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              height: Utils.getDeviceSize(context).height * 0.1,
              alignment: Alignment.center,
              child: Text(
                "User $_user Turn",
                style: TextStyle(fontSize: 24),
              ),
            ),
            GridView.builder(
              padding: EdgeInsets.all(4),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              addAutomaticKeepAlives: true,
              itemBuilder: (context, index) {
                return Container(
                    margin: EdgeInsets.all(4),
                    child: _buttons.elementAt(index));
              },
              itemCount: 9,
              shrinkWrap: true,
            ),
            Visibility(
              visible: _resultVisibility,
              child: Container(
                height: Utils.getDeviceSize(context).height * 0.1,
                child: Text(resultVal),
              ),
            )
          ],
        ),
      ),
    );
  }

  void resetTicTacToe() {
    resetUsers();

    setState(() {
      _resultVisibility = false;
      resultVal = "";
      _user1Positions.clear();
      _user2Positions.clear();
      _icons.clear();
      _userSelection.clear();
      _buttons.clear();

      for (int i = 0; i < 9; i++) {
        _icons.add(Icon(null));
        _userSelection.add(false);
        _buttons.add(
          ElevatedBtnWidget(
            null,
            () {
              toggleUserTurn(i);
            },
          ),
        );
      }
    });
  }

  void toggleUserTurn(int index) {
    addDatatoFirebase(index);
    setState(() {
      if (_isUser1Turn) {
        _user = 2;
        _buttons[index] = ElevatedBtnWidget(
          Icon(Icons.circle, size: 36),
          null,
        );
      } else {
        _user = 1;
        _buttons[index] = ElevatedBtnWidget(
          Icon(
            Icons.close,
            size: 36,
          ),
          null,
        );
      }
      _isUser1Turn = !_isUser1Turn;
    });
  }

  void addDatatoFirebase(int position) {
    _databaseReference
        .child(position.toString())
        .set({ConstUtils.position: position, ConstUtils.user: _user});
  }

  void resetUsers() {
    for (int i = 0; i < 9; i++) {
      _databaseReference.child(i.toString()).set({ConstUtils.user: 0});
    }
  }
}

class ElevatedBtnWidget extends StatelessWidget {
  final VoidCallback onClickAction;
  final Icon icon;

  ElevatedBtnWidget(this.icon, this.onClickAction);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClickAction,
      child: icon,
    );
  }
}
