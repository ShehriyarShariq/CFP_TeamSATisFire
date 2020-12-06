import 'package:dartz/dartz.dart';
import 'package:satisfire_hackathon/core/error/failures.dart';
import 'package:satisfire_hackathon/features/service_details/data/models/review.dart';

abstract class ServiceDetailsRepository {
  Future<Either<Failure, List<Review>>> getServiceReviews(String serviceID);
  Future<Either<Failure, int>> getServiceRating(String serviceID);
  Future<Either<Failure, bool>> makeChatRoom(String providerID);
}
