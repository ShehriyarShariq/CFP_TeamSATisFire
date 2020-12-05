import 'package:equatable/equatable.dart';
import 'package:ntp/ntp.dart';

class Message extends Equatable {
  final String sender, message;
  final List<String> readBy;
  final DateTime timestamp;

  Message({this.sender, this.message, this.readBy, this.timestamp});

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        sender: json["sentBy"],
        message: json["message"],
        readBy: (Map<String, bool>.from(json["readBy"])).keys.toList(),
        timestamp: DateTime.fromMillisecondsSinceEpoch(json["timestamp"]),
      );

  Future<Map<String, dynamic>> toJson() async {
    return {
      "sentBy": sender,
      "message": message,
      "timestamp": (await NTP.now()).millisecondsSinceEpoch
    };
  }

  @override
  List<Object> get props => [sender, message, readBy, timestamp];
}
