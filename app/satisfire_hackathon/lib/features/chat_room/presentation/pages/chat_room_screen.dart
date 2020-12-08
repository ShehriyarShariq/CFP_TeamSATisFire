import 'dart:async';

import 'package:flutter/material.dart';
import 'package:satisfire_hackathon/core/firebase/firebase.dart';
import 'package:satisfire_hackathon/features/chat_room/data/models/message.dart';
import 'package:satisfire_hackathon/features/chat_room/presentation/bloc/chat_room_bloc.dart';
import 'package:satisfire_hackathon/injection_container.dart';

class ChatRoomScreen extends StatefulWidget {
  final String chatID;

  const ChatRoomScreen({Key key, this.chatID}) : super(key: key);

  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  ChatRoomBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = sl<ChatRoomBloc>();
  }

  Map<String, Message> messages = {};

  StreamSubscription messageOnAddedStreamSubscription,
      messageOnChangedStreamSubscription;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  void subscribeToMessagesStream(context) async {
    if (messageOnAddedStreamSubscription == null) {
      messageOnAddedStreamSubscription = FirebaseInit.dbRef
          .child("chats/messages/${widget.chatID}")
          .onChildAdded
          .listen((event) {
        if (event.snapshot.value != null) {
          Message message =
              Message.fromJson(Map<String, dynamic>.from(event.snapshot.value));

          messages[message.id] = message;

          _bloc.add(UpdateChatRoom());
        }
      });
    }

    if (messageOnChangedStreamSubscription == null) {
      messageOnChangedStreamSubscription = FirebaseInit.dbRef
          .child("chats/messages/${widget.chatID}")
          .onChildChanged
          .listen((event) {
        if (event.snapshot.value != null) {
          Message message =
              Message.fromJson(Map<String, dynamic>.from(event.snapshot.value));

          messages[message.id] = message;

          _bloc.add(UpdateChatRoom());
        }
      });
    }
  }
}
