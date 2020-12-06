import 'package:dartz/dartz.dart';
import 'package:satisfire_hackathon/core/error/failures.dart';
import 'package:satisfire_hackathon/features/service_details/data/models/service.dart';

abstract class CategoryServicesRepository {
  Future<Either<Failure, List<Service>>> getAllCategoryServices(
      String categoryID);
}
