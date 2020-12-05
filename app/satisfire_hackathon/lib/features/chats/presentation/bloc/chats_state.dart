part of 'chats_bloc.dart';

abstract class ChatsState extends Equatable {
  const ChatsState([List props = const <dynamic>[]]);

  @override
  List<Object> get props => [];
}

class Initial extends ChatsState {}

class Loading extends ChatsState {}

class Loaded extends ChatsState {
  final List<ChatRoom> chats;

  Loaded({this.chats}) : super([chats]);
}

class Update extends ChatsState {}

class Error extends ChatsState {}
