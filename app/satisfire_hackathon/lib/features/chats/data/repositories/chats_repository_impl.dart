import 'package:dartz/dartz.dart';
import 'package:satisfire_hackathon/core/error/failures.dart';
import 'package:satisfire_hackathon/core/firebase/firebase.dart';
import 'package:satisfire_hackathon/core/network/network_info.dart';
import 'package:satisfire_hackathon/features/chats/data/models/chat_room.dart';
import 'package:satisfire_hackathon/features/chats/domain/repositories/chats_repository.dart';

class ChatsRepositoryImpl extends ChatsRepository {
  final NetworkInfo networkInfo;

  ChatsRepositoryImpl({this.networkInfo});

  @override
  Future<Either<Failure, Map<String, ChatRoom>>> getUserChats() async {
    if (await networkInfo.isConnected) {
      try {
        Map<String, ChatRoom> chats = {};

        await FirebaseInit.dbRef
            .child("chats/rooms")
            .orderByChild("members/${FirebaseInit.auth.currentUser.uid}")
            .equalTo("member")
            .once()
            .then((snapshot) async {
          if (snapshot.value == null) return Right(chats);

          await Future.forEach(snapshot.value, (chatRoom) {
            Map<String, dynamic> chatRoomJson =
                Map<String, dynamic>.from(chatRoom);
            chatRoomJson["id"] = chatRoom.key;
            chats[chatRoom.key] = ChatRoom.fromJson(chatRoomJson);
          });
        });

        return Right(chats);
      } catch (e) {
        print("Exception at getUserChats(): " + e);
        return Left(DbLoadFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
