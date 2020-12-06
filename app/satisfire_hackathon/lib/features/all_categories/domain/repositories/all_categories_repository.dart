import 'package:dartz/dartz.dart';
import 'package:satisfire_hackathon/core/error/failures.dart';
import 'package:satisfire_hackathon/features/all_categories/data/models/category.dart';

abstract class AllCategoriesRepository {
  Future<Either<Failure, List<Category>>> getAllCategories();
}
