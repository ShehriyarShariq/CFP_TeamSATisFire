import 'package:dartz/dartz.dart';
import 'package:satisfire_hackathon/core/error/failures.dart';

abstract class WelcomeRepository {
  Future<Either<Failure, Map<String, bool>>> checkCurrentUser();
  Future<bool> getIsNewUser();
  Future<void> setIsNewUser();
}
