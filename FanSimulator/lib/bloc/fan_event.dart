part of 'fan_bloc.dart';

abstract class FanEvent extends Equatable {
  const FanEvent();

  @override
  List<Object> get props => [];
}

class FanOnEvent extends FanEvent {
  FanOnEvent();

  @override
  List<Object> get props => [];
}

class FanOffEvent extends FanEvent {
  FanOffEvent();

  @override
  List<Object> get props => [];
}
