import 'package:dartz/dartz.dart';
import 'package:satisfire_hackathon/core/error/failures.dart';
import 'package:satisfire_hackathon/core/firebase/firebase.dart';
import 'package:satisfire_hackathon/core/network/network_info.dart';
import 'package:satisfire_hackathon/features/notifications/data/models/notification.dart';
import 'package:satisfire_hackathon/features/notifications/domain/notifications_repository.dart';

class NotificationsRepositoryImpl extends NotificationsRepository {
  final NetworkInfo networkInfo;

  NotificationsRepositoryImpl({this.networkInfo});

  @override
  Future<Either<Failure, List<Notification>>> getAllNotifications() async {
    if (await networkInfo.isConnected) {
      try {
        List<Notification> notifications = [];

        await FirebaseInit.dbRef
            .child("notifications/${FirebaseInit.auth.currentUser.uid}")
            .orderByChild("timestamp")
            .once()
            .then((snapshot) {
          if (snapshot.value != null) {
            List<dynamic>.from(snapshot.value)
                .reversed
                .toList()
                .forEach((notification) {
              notifications.add(Notification.fromJson(
                  Map<String, String>.from(notification)));
            });
          }
        });

        return Right(notifications);
      } catch (e) {
        print("Exception in getAllNotifications(): " + e);
        return Left(DbLoadFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
