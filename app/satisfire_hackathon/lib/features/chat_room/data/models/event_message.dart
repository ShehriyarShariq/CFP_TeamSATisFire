import 'package:ntp/ntp.dart';
import 'package:satisfire_hackathon/core/util/constants.dart';
import 'package:satisfire_hackathon/features/chat_room/data/models/message.dart';

class EventMessage extends Message {
  final DateTime eventTimestamp;
  final String eventType;
  final bool eventStatus;

  EventMessage({
    String id,
    String sender,
    String message,
    String type,
    DateTime timestamp,
    this.eventTimestamp,
    this.eventType,
    this.eventStatus,
  }) : super(
          id: id,
          sender: sender,
          message: message,
          type: type,
          timestamp: timestamp,
        );

  factory EventMessage.fromJson(Map<String, dynamic> json) => EventMessage(
        id: json.containsKey("id") ? json["id"] : null,
        sender: json["sentBy"],
        message: json["message"],
        type: json.containsKey("type") ? json["type"] : null,
        timestamp: DateTime.fromMillisecondsSinceEpoch(json["timestamp"]),
        eventType: json['eventType'],
        eventTimestamp:
            DateTime.fromMillisecondsSinceEpoch(json["eventTimestamp"]),
        eventStatus: json['eventStatus'],
      );

  Map<String, dynamic> toJson({bool isRecentMessage = false}) {
    return {
      "sentBy": super.sender,
      "message": super.message,
      "type": super.type,
      "timestamp": DateTime.now().millisecondsSinceEpoch,
      "eventType": eventType,
      "eventTimestamp": eventTimestamp.millisecondsSinceEpoch,
      "eventStatus": Constants.EVENT_STATUS_NONE,
    };
  }
}
