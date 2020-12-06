import 'package:firebase_core/firebase_core.dart';
import 'package:satisfire_hackathon/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:satisfire_hackathon/core/firebase/firebase.dart';
import 'package:satisfire_hackathon/core/network/network_info.dart';
import 'package:satisfire_hackathon/core/util/constants.dart';
import 'package:satisfire_hackathon/features/chats/data/models/chat_room.dart';
import 'package:satisfire_hackathon/features/service_details/data/models/review.dart';
import 'package:satisfire_hackathon/features/service_details/domain/repositories/service_details_repository.dart';

class ServiceDetailsRepositoryImpl extends ServiceDetailsRepository {
  final NetworkInfo networkInfo;

  ServiceDetailsRepositoryImpl({this.networkInfo});

  @override
  Future<Either<Failure, int>> getServiceRating(String serviceID) async {
    if (await networkInfo.isConnected) {
      try {
        int rating = -1;

        await FirebaseInit.dbRef
            .child("service_ranking/$serviceID")
            .once()
            .then((snapshot) {
          if (snapshot.value != null) {
            int totalCount = 0;
            int totalScore = 0;
            Map<String, int>.from(snapshot.value).forEach((key, value) {
              totalScore += Constants.RATING_MAP[key] * value;
              totalCount += value;
            });
            rating = (totalScore / totalCount).round();
          }
        });

        return Right(rating);
      } catch (e) {
        print("Exception in getServiceRating(): " + e);
        return Left(DbLoadFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Review>>> getServiceReviews(
      String serviceID) async {
    if (await networkInfo.isConnected) {
      try {
        List<Review> serviceReviews = [];

        await FirebaseInit.dbRef
            .child("service_reviews/$serviceID")
            .once()
            .then((snapshot) {
          if (snapshot.value != null) {
            Map<String, dynamic>.from(snapshot.value)
                .forEach((bookingID, booking) {
              serviceReviews
                  .add(Review.fromJson(Map<String, String>.from(booking)));
            });
          }
        });

        return Right(serviceReviews);
      } catch (e) {
        print("Exception in getServiceReviews(): " + e);
        return Left(DbLoadFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> makeChatRoom(String providerID) async {
    if (await networkInfo.isConnected) {
      try {
        String chatID = FirebaseInit.auth.currentUser.uid + "_" + providerID;
        if (FirebaseInit.auth.currentUser.uid.compareTo(providerID) > 0) {
          chatID = providerID + "_" + FirebaseInit.auth.currentUser.uid;
        }

        ChatRoom newChatRoom = new ChatRoom(
            members: [FirebaseInit.auth.currentUser.uid, providerID]);

        await FirebaseInit.dbRef
            .child("chats/rooms/$chatID")
            .update(await newChatRoom.toJson());

        return Right(true);
      } catch (e) {
        print("Exception in makeChatRoom(): " + e);
        return Left(DbLoadFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
