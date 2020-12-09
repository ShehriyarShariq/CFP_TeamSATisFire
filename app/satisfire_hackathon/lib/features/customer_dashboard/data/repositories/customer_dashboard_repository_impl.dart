import 'package:satisfire_hackathon/core/firebase/firebase.dart';
import 'package:satisfire_hackathon/core/network/network_info.dart';
import 'package:satisfire_hackathon/core/util/constants.dart';
import 'package:satisfire_hackathon/core/util/utils.dart';
import 'package:satisfire_hackathon/features/all_categories/data/models/category.dart';
import 'package:satisfire_hackathon/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:satisfire_hackathon/features/customer_dashboard/domain/repositories/customer_dashboard_repository.dart';
import 'package:satisfire_hackathon/features/service_details/data/models/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerDashboardRepositoryImpl extends CustomerDashboardRepository {
  final NetworkInfo networkInfo;
  final SharedPreferences sharedPreferences;

  CustomerDashboardRepositoryImpl({this.networkInfo, this.sharedPreferences});

  @override
  Future<Either<Failure, List<Category>>> getLimitedCategories() async {
    if (await networkInfo.isConnected != null) {
      try {
        List<Category> categories = [];

        await FirebaseInit.dbRef.child("categories").once().then((snapshot) {
          print(snapshot.value);
          if (snapshot.value != null) {
            Map<String, dynamic>.from(snapshot.value).forEach((key, value) {
              Map<String, String> categoryMap = Map<String, String>.from(value);
              categoryMap['id'] = key;
              print(categoryMap);
              categories.add(Category.fromJson(categoryMap));
            });
          }
        });

        return Right(categories);
      } catch (e) {
        print("Exception in getLimitedCategories(): " + e.toString());
        return Left(DbLoadFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Service>>> getQueriedServices(
      String queryType, String queryTerm) async {
    if (await networkInfo.isConnected != null) {
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
              // services.add(Service.fromJson(serviceMap));
            });
          }
        });

        return Right(services);
      } catch (e) {
        print("Exception in getQueriedServices(): " + e.toString());
        return Left(DbLoadFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Service>>> getPopularServices() async {
    if (await networkInfo.isConnected != null) {
      try {
        List<Service> popularServices = [];

        await FirebaseInit.dbRef
            .child("services")
            .orderByChild("ranking")
            .equalTo(0)
            .once()
            .then((snapshot) async {
          if (snapshot.value != null) {
            await Future.forEach(
                Map<String, dynamic>.from(snapshot.value).entries,
                (serviceEntry) async {
              Map<String, dynamic> serviceMap =
                  Map<String, dynamic>.from(serviceEntry.value);
              serviceMap['id'] = serviceEntry.key;

              serviceMap['providerName'] = await FirebaseInit.dbRef
                  .child("provider/${serviceEntry.value['provider_id']}/name")
                  .once()
                  .then((snapshot) =>
                      Utils.getFirstLetterOfWordsCapped(snapshot.value) ?? "");

              await FirebaseInit.dbRef
                  .child("service_ranking/${serviceEntry.key}")
                  .once()
                  .then((snapshot) {
                if (snapshot.value != null) {
                  double totalCount = 0;
                  double totalScore = 0;
                  Map<String, int>.from(snapshot.value).forEach((key, value) {
                    totalScore += Constants.RATING_MAP[key] * value;
                    totalCount += value;
                  });
                  serviceMap['rating'] = (totalScore / totalCount);
                  print(serviceMap['rating']);
                } else {
                  serviceMap['rating'] = 0.0;
                }
              });

              popularServices.add(Service.fromJson(serviceMap));
            });
          }
        });

        return Right(popularServices);
      } catch (e) {
        print("Exception in getPopularServices(): " + e.toString());
        return Left(DbLoadFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> endCurrentSession(String bookingID) {
    // TODO: implement endCurrentSession
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> logoutCurrentUser() async {
    await FirebaseInit.auth.signOut();
    await FirebaseInit.auth.signInAnonymously();
    await sharedPreferences.remove("isCust");
    return Right(true);
  }
}
