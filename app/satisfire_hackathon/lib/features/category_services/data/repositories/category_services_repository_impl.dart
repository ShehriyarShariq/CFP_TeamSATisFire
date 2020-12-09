import 'package:satisfire_hackathon/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:satisfire_hackathon/core/firebase/firebase.dart';
import 'package:satisfire_hackathon/core/network/network_info.dart';
import 'package:satisfire_hackathon/features/category_services/domain/repositories/category_services_repository.dart';
import 'package:satisfire_hackathon/features/service_details/data/models/service.dart';

class CategoryServicesRepositoryImpl extends CategoryServicesRepository {
  final NetworkInfo networkInfo;

  CategoryServicesRepositoryImpl({this.networkInfo});

  @override
  Future<Either<Failure, List<Service>>> getAllCategoryServices(
      String categoryID) async {
    if (networkInfo.isConnected != null) {
      try {
        List<Service> categoryServices = [];

        await FirebaseInit.dbRef
            .child("services")
            .orderByChild("category/id")
            .equalTo(categoryID)
            .once()
            .then((snapshot) {
          if (snapshot.value != null) {
            Map<String, dynamic>.from(snapshot.value)
                .forEach((serviceID, serviceVal) {
              // Service service =
              //     Service.fromJson(Map<String, dynamic>.from(serviceVal));
              // service.id = serviceID;
              // categoryServices.add(service);
            });
          }
        });

        return Right(categoryServices);
      } catch (e) {
        print("Exception in getAllCategoryServices(): " + e.toString());
        return Left(DbLoadFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
