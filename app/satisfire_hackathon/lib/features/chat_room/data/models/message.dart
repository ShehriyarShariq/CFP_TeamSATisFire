import 'package:equatable/equatable.dart';
import 'package:ntp/ntp.dart';
import 'package:satisfire_hackathon/core/firebase/firebase.dart';

class Message extends Equatable {
  final String id, sender, message, type;
  final DateTime timestamp;

  Message({this.id, this.sender, this.message, this.type, this.timestamp});

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json.containsKey("id") ? json["id"] : null,
        sender: json["sentBy"],
        message: json["message"],
        type: json.containsKey("type") ? json["type"] : null,
        timestamp: DateTime.fromMillisecondsSinceEpoch(json["timestamp"]),
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      "sentBy": sender,
      "message": message,
      "type": type,
      "timestamp": DateTime.now().millisecondsSinceEpoch
    };

    return json;
  }

  @override
  List<Object> get props => [sender, message, timestamp];
}
