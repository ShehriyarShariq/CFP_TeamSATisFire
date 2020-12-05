import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:satisfire_hackathon/features/chat_room/data/models/message.dart';
import 'package:satisfire_hackathon/features/chats/data/models/chat_room.dart';

part 'chats_event.dart';
part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  ChatsBloc() : super(Initial());

  @override
  Stream<ChatsState> mapEventToState(
    ChatsEvent event,
  ) async* {
    if (event is GetAllUserChats) {
      yield Loading();
      final failureOrChats = await event.func();
      yield failureOrChats.fold(
          (failure) => Error(), (chats) => Loaded(chats: chats));
    } else if (event is UpdateChatRoom) {
      yield Update();
    }
  }
}
