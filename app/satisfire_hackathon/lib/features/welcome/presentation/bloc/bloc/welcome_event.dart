part of 'welcome_bloc.dart';

abstract class WelcomeEvent extends Equatable {
  const WelcomeEvent([List props = const <dynamic>[]]);

  @override
  List<Object> get props => [];
}

class CheckCurrentUserEvent extends WelcomeEvent {
  final Function func;

  CheckCurrentUserEvent({this.func}) : super([func]);
}
