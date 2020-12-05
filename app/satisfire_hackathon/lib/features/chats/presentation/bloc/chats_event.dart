part of 'chats_bloc.dart';

abstract class ChatsEvent extends Equatable {
  const ChatsEvent([List props = const <dynamic>[]]);

  @override
  List<Object> get props => [];
}

class GetAllUserChats extends ChatsEvent {
  final Function func;

  GetAllUserChats({this.func}) : super([func]);
}

class UpdateChatRoom extends ChatsEvent {}
