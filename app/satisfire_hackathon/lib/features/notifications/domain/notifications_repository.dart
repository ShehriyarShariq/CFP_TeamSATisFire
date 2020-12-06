import 'package:dartz/dartz.dart';
import 'package:satisfire_hackathon/core/error/failures.dart';
import 'package:satisfire_hackathon/features/notifications/data/models/notification.dart';

abstract class NotificationsRepository {
  Future<Either<Failure, List<Notification>>> getAllNotifications();
}