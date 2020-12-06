import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:satisfire_hackathon/core/error/failures.dart';
import 'package:satisfire_hackathon/features/service_details/data/models/service.dart';

abstract class CreateEditServiceRepository {
  Future<Either<Failure, bool>> saveService(Service service, List<File> images);
}
