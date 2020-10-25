part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable {}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSuccess extends LoginState {
  final User user;

  LoginSuccess(this.user);

  @override
  List<Object> get props => [this.user];
}

class LoginFailure extends LoginState {
  final String loginError;

  LoginFailure(this.loginError);

  @override
  List<Object> get props => [this.loginError];
}
