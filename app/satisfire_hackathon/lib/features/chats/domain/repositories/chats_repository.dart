import 'package:dartz/dartz.dart';
import 'package:satisfire_hackathon/core/error/failures.dart';
import 'package:satisfire_hackathon/features/chats/data/models/chat_room.dart';

abstract class ChatsRepository {
  Future<Either<Failure, Map<String, ChatRoom>>> getUserChats();
}
