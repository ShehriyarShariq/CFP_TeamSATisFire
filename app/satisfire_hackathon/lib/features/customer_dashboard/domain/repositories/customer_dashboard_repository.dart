import 'package:dartz/dartz.dart';
import 'package:satisfire_hackathon/core/error/failures.dart';
import 'package:satisfire_hackathon/features/all_categories/data/models/category.dart';
import 'package:satisfire_hackathon/features/service_details/data/models/service.dart';

abstract class CustomerDashboardRepository {
  Future<Either<Failure, List<Category>>> getLimitedCategories();
  Future<Either<Failure, List<Service>>> getQueriedServices(
      String queryType, String queryTerm);
  Future<Either<Failure, bool>> endCurrentSession(String bookingID);
  Future<Either<Failure, List<Service>>> getPopularServices();
  Future<Either<Failure, bool>> logoutCurrentUser();
}
