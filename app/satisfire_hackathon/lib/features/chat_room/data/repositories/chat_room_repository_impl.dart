import 'package:satisfire_hackathon/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:satisfire_hackathon/core/firebase/firebase.dart';
import 'package:satisfire_hackathon/core/network/network_info.dart';
import 'package:satisfire_hackathon/core/util/constants.dart';
import 'package:satisfire_hackathon/features/chat_room/data/models/event_message.dart';
import 'package:satisfire_hackathon/features/chat_room/data/models/message.dart';
import 'package:satisfire_hackathon/features/chat_room/domain/repositories/chat_room_repository.dart';

class ChatRoomRepositoryImpl extends ChatRoomRepository {
  final NetworkInfo networkInfo;

  ChatRoomRepositoryImpl({this.networkInfo});

  @override
  Future<Either<Failure, bool>> respondToEvent(
      String chatID, String messageID, bool isAccept) async {
    if (await networkInfo.isConnected != null) {
      try {
        await FirebaseInit.dbRef
            .child("chats/messages/$chatID/$messageID/eventStatus")
            .set(isAccept
                ? Constants.EVENT_STATUS_ACCEPTED
                : Constants.EVENT_STATUS_DECLINED);

        return Right(true);
      } catch (e) {
        print("Exception in respondToEvent(): " + e.toString());
        return Left(ProcessFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> sendMessage(
      String chatID, Message message) async {
    if (await networkInfo.isConnected != null) {
      try {
        await FirebaseInit.dbRef
            .child("chats/rooms/$chatID/recentMessage")
            .set(message.toJson(isRecentMessage: true));

        await FirebaseInit.dbRef.child("chats/rooms/$chatID").push().set(
            message.type == Constants.MESSAGE_TYPE_EVENT
                ? (message as EventMessage).toJson()
                : message.toJson());

        return Right(true);
      } catch (e) {
        print("Exception in sendMessage(): " + e.toString());
        return Left(ProcessFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
