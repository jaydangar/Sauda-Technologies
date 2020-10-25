import 'dart:math';

import 'package:FanSimulator/bloc/fan_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fan Simulator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Fan Simulator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  String _btnText = "ON";
  bool _fanStatus = false;
  Color _btnColor = Colors.green;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.repeat();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FanBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              RotationTransition(
                turns: Tween(begin: 0.0, end: 2 * pi).animate(_controller),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: Image(image: AssetImage('assets/images/fan.png')),
                ),
              ),
              BlocBuilder<FanBloc, FanState>(
                builder: (context, state) {
                  if (state is FanOnState) {
                    _btnText = state.btnText;
                    _btnColor = state.btnColor;
                    _fanStatus = state.fanStatus;
                  } else if (state is FanOffState) {
                    _btnText = state.btnText;
                    _btnColor = state.btnColor;
                    _fanStatus = state.fanStatus;
                  }
                  return Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: RaisedButton(
                      color: _btnColor,
                      child: Text(_btnText),
                      onPressed: () =>
                          _fanStatus ? stopAnimation(context) : startAnimation(context),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void startAnimation(BuildContext context) {
    BlocProvider.of<FanBloc>(context).add(FanOnEvent());
    _controller.forward();
  }

  void stopAnimation(BuildContext context) {
    BlocProvider.of<FanBloc>(context).add(FanOffEvent());
    _controller.stop();
  }
}
