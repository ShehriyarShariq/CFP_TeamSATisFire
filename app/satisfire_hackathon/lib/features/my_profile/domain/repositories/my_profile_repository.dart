import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:satisfire_hackathon/core/error/failures.dart';

abstract class MyProfileRepository {
  Future<Either<Failure, bool>> uploadProfileImage(File image);
  Future<Either<Failure, bool>> updateData(String type, String data);
}
