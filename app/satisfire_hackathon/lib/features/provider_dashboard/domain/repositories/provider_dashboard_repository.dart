import 'package:dartz/dartz.dart';
import 'package:satisfire_hackathon/core/error/failures.dart';

abstract class ProviderDashboardRepository {
  Future<Either<Failure, bool>> logoutCurrentUser();
}
