import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
            .startAt("member")
            .endAt("member\uf8ff")
            .once()
            .then((snapshot) async {
          if (snapshot.value == null) return Right(chats);

          await Future.forEach(snapshot.value, (chatRoom) async {
            Map<String, dynamic> chatRoomJson =
                Map<String, dynamic>.from(chatRoom);
            chatRoomJson["id"] = chatRoom.key;
            ChatRoom chatRoomObj = ChatRoom.fromJson(chatRoomJson);

            String otherMemberID = chatRoomObj.members
                .where(
                    (element) => element == FirebaseInit.auth.currentUser.uid)
                .first;

            String otherMemberType =
                Map<String, String>.from(chatRoomJson["members"])[otherMemberID]
                    .replaceAll("member_", "");

            String otherMemberName = await FirebaseInit.dbRef
                .child("$otherMemberType/$otherMemberID/name")
                .once()
                .then((snapshot) => snapshot.value ?? "Error 404");

            chatRoomObj.name = otherMemberName;

            chats[chatRoom.key] = chatRoomObj;
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
