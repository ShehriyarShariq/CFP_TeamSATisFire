part of 'welcome_bloc.dart';

abstract class WelcomeState extends Equatable {
  const WelcomeState([List props = const <dynamic>[]]);

  @override
  List<Object> get props => [];
}

class Initial extends WelcomeState {}

class Success extends WelcomeState {
  final Map<String, bool> map;

  Success({this.map}) : super([map]);
}

class Error extends WelcomeState {}
