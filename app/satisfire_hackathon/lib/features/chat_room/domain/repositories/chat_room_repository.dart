import 'package:dartz/dartz.dart';
import 'package:satisfire_hackathon/core/error/failures.dart';
import 'package:satisfire_hackathon/features/chat_room/data/models/event_message.dart';
import 'package:satisfire_hackathon/features/chat_room/data/models/message.dart';

abstract class ChatRoomRepository {
  // For text and event messages
  Future<Either<Failure, bool>> sendMessage(String chatID, Message message);

  // By Customer
  // Respond to the event message created by provider - Accept or Decline
  Future<Either<Failure, bool>> respondToEvent(
      String chatID, String messageID, bool isAccept);
}
