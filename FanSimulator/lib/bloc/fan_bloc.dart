import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'fan_event.dart';
part 'fan_state.dart';

class FanBloc extends Bloc<FanEvent, FanState> {
  FanBloc() : super(FanInitial());

  @override
  Stream<FanState> mapEventToState(
    FanEvent event,
  ) async* {
    if(event is FanOnEvent){
      yield FanOnState();
    }
    else if(event is FanOffEvent){
      yield FanOffState();
    }
  }
}
