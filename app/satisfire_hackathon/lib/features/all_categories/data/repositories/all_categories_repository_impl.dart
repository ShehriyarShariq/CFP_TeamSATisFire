import 'package:dartz/dartz.dart';
import 'package:satisfire_hackathon/core/error/failures.dart';
import 'package:satisfire_hackathon/core/firebase/firebase.dart';
import 'package:satisfire_hackathon/core/network/network_info.dart';
import 'package:satisfire_hackathon/features/all_categories/data/models/category.dart';
import 'package:satisfire_hackathon/features/all_categories/domain/repositories/all_categories_repository.dart';

class AllCategoriesRepositoryImpl extends AllCategoriesRepository {
  final NetworkInfo networkInfo;

  AllCategoriesRepositoryImpl({this.networkInfo});

  @override
  Future<Either<Failure, List<Category>>> getAllCategories() async {
    if (await networkInfo.isConnected != null) {
      try {
        List<Category> categories = [];

        await FirebaseInit.dbRef.child("categories").once().then((snapshot) {
          if (snapshot.value != null) {
            // Map<String, dynamic>.from(snapshot.value).forEach((key, value) {
            //   Map<String, String> categoryMap = Map<String, String>.from(value);
            //   categoryMap['id'] = key;
            //   categories.add(Category.fromJson(categoryMap));
            // });
          }
        });

        return Right(categories);
      } catch (e) {
        print("Exception in getAllCategories(): " + e.toString());
        return Left(DbLoadFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
