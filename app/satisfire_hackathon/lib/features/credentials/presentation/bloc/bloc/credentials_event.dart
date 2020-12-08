part of 'credentials_bloc.dart';

abstract class CredentialsEvent extends Equatable {
  const CredentialsEvent([List props = const <dynamic>[]]);

  @override
  List<Object> get props => [];
}

class LoginWithCredentialsEvent extends CredentialsEvent {
  final Function func;

  LoginWithCredentialsEvent({this.func}) : super([func]);
}

class RegisterUserEvent extends CredentialsEvent {
  final Function func;

  RegisterUserEvent({this.func}) : super([func]);
}

class SendCodeEvent extends CredentialsEvent {}

class CodeSentEvent extends CredentialsEvent {}

class VerifyingCodeEvent extends CredentialsEvent {}

class CodeVerifiedEvent extends CredentialsEvent {}
