part of 'fan_bloc.dart';

abstract class FanState extends Equatable {
  const FanState();

  @override
  List<Object> get props => [];
}

class FanInitial extends FanState {}

class FanOnState extends FanState {

  final bool fanStatus = true;
  final String btnText = "OFF";
  final Color btnColor = Colors.red;

  FanOnState();

  @override
  List<Object> get props => [this.fanStatus,this.btnText,this.btnColor];
}

class FanOffState extends FanState {

  final bool fanStatus = false;
  final String btnText = "ON";
  final Color btnColor = Colors.green;
  FanOffState();

  @override
  List<Object> get props => [this.fanStatus,this.btnText,this.btnColor];
}
