import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ntp/ntp.dart';
import 'package:satisfire_hackathon/core/firebase/firebase.dart';
import 'package:satisfire_hackathon/features/chat_room/data/models/message.dart';

class ChatRoom extends Equatable {
  final String chatID;
  String name;
  final List<String> members;
  Message recentMessage;

  ChatRoom({this.chatID, this.name, this.members, this.recentMessage});

  factory ChatRoom.fromJson(Map<String, dynamic> json) => ChatRoom(
        chatID: json["id"],
        name: json["name"],
        members: Map<String, String>.from(json["members"]).keys.toList(),
        recentMessage:
            Message.fromJson(Map<String, dynamic>.from(json["recentMessage"])),
      );

  Future<Map<String, dynamic>> toJson() async {
    return Future.value({
      'members': Map.fromIterable(
        members,
        key: (id) => id,
        value: (e) =>
            "member_" +
            (e == FirebaseInit.auth.currentUser.uid ? "customer" : "provider"),
      ),
      'recentMessage': {
        'message': 'New conversation...',
        'sentBy': FirebaseInit.auth.currentUser.uid,
        'timestamp': (await NTP.now()).millisecondsSinceEpoch,
      }
    });
  }

  @override
  List<Object> get props => [members, recentMessage];
}
