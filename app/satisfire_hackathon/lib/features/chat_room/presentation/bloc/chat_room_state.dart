part of 'chat_room_bloc.dart';

abstract class ChatRoomState extends Equatable {
  const ChatRoomState([List props = const <dynamic>[]]);

  @override
  List<Object> get props => [];
}

class Initial extends ChatRoomState {}

class Update extends ChatRoomState {}

class Error extends ChatRoomState {}
