import 'package:equatable/equatable.dart';
import 'package:ntp/ntp.dart';
import 'package:satisfire_hackathon/core/firebase/firebase.dart';

class Message extends Equatable {
  final String id, sender, message, type;
  final List<String> readBy;
  final DateTime timestamp;

  Message(
      {this.id,
      this.sender,
      this.message,
      this.type,
      this.readBy,
      this.timestamp});

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json.containsKey("id") ? json["id"] : null,
        sender: json["sentBy"],
        message: json["message"],
        type: json.containsKey("type") ? json["type"] : null,
        readBy: (Map<String, bool>.from(json["readBy"])).keys.toList(),
        timestamp: DateTime.fromMillisecondsSinceEpoch(json["timestamp"]),
      );

  Future<Map<String, dynamic>> toJson({bool isRecentMessage = false}) async {
    Map<String, dynamic> json = {
      "sentBy": sender,
      "message": message,
      "type": type,
      "timestamp": (await NTP.now()).millisecondsSinceEpoch
    };

    if (isRecentMessage)
      json["readBy"] = {
        "${FirebaseInit.auth.currentUser.uid}": true,
      };

    return json;
  }

  @override
  List<Object> get props => [sender, message, readBy, timestamp];
}
