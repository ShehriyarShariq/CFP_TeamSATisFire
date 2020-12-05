import 'package:equatable/equatable.dart';
import 'package:satisfire_hackathon/features/chat_room/data/models/message.dart';

class ChatRoom extends Equatable {
  final String chatID;
  final List<String> members;
  Message recentMessage;

  ChatRoom({this.chatID, this.members, this.recentMessage});

  factory ChatRoom.fromJson(Map<String, dynamic> json) => ChatRoom(
        chatID: json["id"],
        members: Map<String, String>.from(json["members"]).keys.toList(),
        recentMessage:
            Message.fromJson(Map<String, dynamic>.from(json["recentMessage"])),
      );

  @override
  List<Object> get props => [members, recentMessage];
}
