import 'dart:async';

import 'package:flutter/material.dart';
import 'package:satisfire_hackathon/core/firebase/firebase.dart';
import 'package:satisfire_hackathon/features/chat_room/data/models/message.dart';
import 'package:satisfire_hackathon/features/chats/data/models/chat_room.dart';
import 'package:satisfire_hackathon/features/chats/presentation/bloc/chats_bloc.dart';

import '../../../../injection_container.dart';

class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  ChatsBloc _bloc;

  Map<String, ChatRoom> chatRoomsMap = {};

  Map<String, StreamSubscription> streams = {};

  @override
  void initState() {
    super.initState();

    _bloc = sl<ChatsBloc>();
  }

  @override
  void dispose() {
    streams.values.toList().forEach((stream) {
      stream?.cancel();
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  List<ChatRoom> sortChatRoomsByTime() {
    List<ChatRoom> chatRooms = [];
    chatRooms.sort((b, a) => a.recentMessage.timestamp.millisecondsSinceEpoch
        .compareTo(b.recentMessage.timestamp.millisecondsSinceEpoch));
    return chatRooms;
  }

  void attachListenerToChatStream(String chatID, context) async {
    if (!streams.containsKey(chatID)) {
      streams[chatID] = FirebaseInit.dbRef
          .child("chats/rooms/$chatID/recentMessage")
          .onValue
          .listen((event) {
        if (event.snapshot.value != null) {
          Message updatedRecentMessage =
              Message.fromJson(Map<String, dynamic>.from(event.snapshot.value));

          if (chatRoomsMap[chatID].recentMessage != updatedRecentMessage) {
            chatRoomsMap[chatID].recentMessage = updatedRecentMessage;
            _bloc.add(UpdateChatRoom());
          }
        }
      });
    }
  }
}
