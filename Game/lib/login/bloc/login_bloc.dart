import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginEvent) {
      yield* _mapLoginEventToState(event);
    }
  }

  Stream<LoginState> _mapLoginEventToState(LoginEvent event) async* {
    User _user = await signInWithGoogle();
    if (_user == null) {
      yield (LoginFailure("Unexpected Error occurred..."));
    } else {
      yield (LoginSuccess(_user));
    }
  }

  Future<User> signInWithGoogle() async {
    final _auth = FirebaseAuth.instance;
    final _googleSignIn = GoogleSignIn();

    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User user = authResult.user;
    return user;
  }
}
