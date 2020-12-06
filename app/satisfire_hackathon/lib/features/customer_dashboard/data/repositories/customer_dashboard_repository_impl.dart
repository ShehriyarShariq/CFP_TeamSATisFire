import 'package:satisfire_hackathon/core/firebase/firebase.dart';
import 'package:satisfire_hackathon/core/network/network_info.dart';
import 'package:satisfire_hackathon/core/util/constants.dart';
import 'package:satisfire_hackathon/features/all_categories/data/models/category.dart';
import 'package:satisfire_hackathon/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:satisfire_hackathon/features/customer_dashboard/domain/repositories/customer_dashboard_repository.dart';
import 'package:satisfire_hackathon/features/service_details/data/models/service.dart';

class CustomerDashboardRepositoryImpl extends CustomerDashboardRepository {
  final NetworkInfo networkInfo;

  CustomerDashboardRepositoryImpl({this.networkInfo});

  @override
  Future<Either<Failure, List<Category>>> getLimitedCategories() async {
    if (await networkInfo.isConnected) {
      try {
        List<Category> categories = [];

        await FirebaseInit.dbRef
            .child("categories")
            .orderByKey()
            .limitToFirst(6)
            .once()
            .then((snapshot) {
          if (snapshot.value != null) {
            Map<String, dynamic>.from(snapshot.value).forEach((key, value) {
              Map<String, String> categoryMap = Map<String, String>.from(value);
              categoryMap['id'] = key;
              categories.add(Category.fromJson(categoryMap));
            });
          }
        });

        return Right(categories);
      } catch (e) {
        print("Exception in getLimitedCategories(): " + e);
        return Left(DbLoadFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Service>>> getQueriedServices(
      String queryType, String queryTerm) async {
    if (await networkInfo.isConnected) {
      try {
        List<Service> services = [];

        await FirebaseInit.dbRef
            .child("services")
            .orderByChild(queryType == Constants.SEARCH_FILTER_TYPE_CATEGORY
                ? "title"
                : "category/name")
            .startAt(queryTerm)
            .endAt("$queryTerm\uf8ff")
            .once()
            .then((snapshot) {
          if (snapshot.value != null) {
            Map<String, dynamic>.from(snapshot.value).forEach((key, value) {
              Map<String, dynamic> serviceMap =
                  Map<String, dynamic>.from(value);
              serviceMap['id'] = key;
              services.add(Service.fromJson(serviceMap));
            });
          }
        });

        return Right(services);
      } catch (e) {
        print("Exception in getQueriedServices(): " + e);
        return Left(DbLoadFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Service>>> getPopularServices() async {
    if (await networkInfo.isConnected) {
      try {
        List<Service> popularServices = [];

        await FirebaseInit.dbRef
            .child("services")
            .orderByChild("ranking")
            .equalTo(0)
            .once()
            .then((snapshot) {
          if (snapshot.value != null) {
            Map<String, dynamic>.from(snapshot.value).forEach((key, value) {
              Map<String, dynamic> serviceMap =
                  Map<String, dynamic>.from(value);
              serviceMap['id'] = key;
              popularServices.add(Service.fromJson(serviceMap));
            });
          }
        });

        return Right(popularServices);
      } catch (e) {
        print("Exception in getPopularServices(): " + e);
        return Left(DbLoadFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
