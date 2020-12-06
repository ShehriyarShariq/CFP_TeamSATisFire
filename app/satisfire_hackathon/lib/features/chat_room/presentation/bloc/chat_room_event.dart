part of 'chat_room_bloc.dart';

abstract class ChatRoomEvent extends Equatable {
  const ChatRoomEvent([List props = const <dynamic>[]]);

  @override
  List<Object> get props => [];
}

class UpdateChatRoom extends ChatRoomEvent {}
