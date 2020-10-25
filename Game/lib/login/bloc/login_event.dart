part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable{}

class LoginClickedEvent extends LoginEvent{

  LoginClickedEvent();

  @override
  List<Object> get props => [];
}

