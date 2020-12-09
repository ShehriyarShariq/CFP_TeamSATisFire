import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ntp/ntp.dart';
import 'package:satisfire_hackathon/core/firebase/firebase.dart';
import 'package:satisfire_hackathon/core/ui/no_glow_scroll_behavior.dart';
import 'package:satisfire_hackathon/core/util/constants.dart';
import 'package:satisfire_hackathon/features/chat_room/data/models/message.dart';
import 'package:satisfire_hackathon/features/chat_room/domain/repositories/chat_room_repository.dart';
import 'package:satisfire_hackathon/features/chat_room/presentation/bloc/chat_room_bloc.dart';
import 'package:satisfire_hackathon/injection_container.dart';

class ChatRoomScreen extends StatefulWidget {
  final String chatID;
  final Map<String, String> members;
  final String providerName;

  const ChatRoomScreen({Key key, this.chatID, this.members, this.providerName})
      : super(key: key);

  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  ChatRoomBloc _bloc;
  TextEditingController _messageInpController = new TextEditingController();

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
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark,
    );

    subscribeToMessagesStream(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF292C55),
        title: Text(
          widget.providerName,
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF292C55).withOpacity(0.65),
                Color(0xFFA440A6).withOpacity(0.65)
              ],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 7,
                left: 15,
                right: 15,
                bottom: 62,
                child: BlocBuilder(
                  cubit: _bloc,
                  builder: (context, state) {
                    if (state is Update) {
                      print("Updated");
                    }

                    List<Message> messagesList = messages.values.toList();

                    return ScrollConfiguration(
                      behavior: NoGlowScrollBehavior(),
                      child: ListView.builder(
                        itemCount: messagesList.length,
                        itemBuilder: (context, index) => Row(
                          mainAxisAlignment: messagesList[index].sender ==
                                  FirebaseInit.auth.currentUser.uid
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              margin: const EdgeInsets.only(bottom: 7),
                              decoration: BoxDecoration(
                                color: messagesList[index].sender ==
                                        FirebaseInit.auth.currentUser.uid
                                    ? Color(0xFFF8D1D8)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Text(
                                messagesList[index].message,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: 50,
                  margin: const EdgeInsets.only(
                      left: 15, right: 15, bottom: 10, top: 2),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Color(0xFFE2E2E2),
                          ),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: _messageInpController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Your message",
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Material(
                        color: Color(0xFF292C55),
                        borderRadius: BorderRadius.circular(25),
                        child: InkWell(
                          onTap: () async {
                            if (_messageInpController.text.trim().isNotEmpty) {
                              sl<ChatRoomRepository>().sendMessage(
                                  widget.chatID,
                                  Message(
                                      sender: FirebaseInit.auth.currentUser.uid,
                                      message:
                                          _messageInpController.text.trim(),
                                      type: Constants.MESSAGE_TYPE_TEXT));
                              _messageInpController.text = "";
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                            }
                          },
                          borderRadius: BorderRadius.circular(25),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.transparent,
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void subscribeToMessagesStream(context) async {
    if (messageOnAddedStreamSubscription == null) {
      messageOnAddedStreamSubscription = FirebaseInit.dbRef
          .child("chats/messages/${widget.chatID}")
          .onChildAdded
          .listen((event) {
        if (event.snapshot.value != null) {
          event.snapshot.value['id'] = event.snapshot.key;
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
