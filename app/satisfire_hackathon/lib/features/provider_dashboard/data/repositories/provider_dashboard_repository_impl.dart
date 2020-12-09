import 'package:dartz/dartz.dart';
import 'package:satisfire_hackathon/core/error/failures.dart';
import 'package:satisfire_hackathon/core/firebase/firebase.dart';
import 'package:satisfire_hackathon/core/network/network_info.dart';
import 'package:satisfire_hackathon/features/provider_dashboard/domain/repositories/provider_dashboard_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderDashboardRepositoryImpl extends ProviderDashboardRepository {
  final NetworkInfo networkInfo;
  final SharedPreferences sharedPreferences;

  ProviderDashboardRepositoryImpl({this.networkInfo, this.sharedPreferences});

  @override
  Future<Either<Failure, bool>> logoutCurrentUser() async {
    await FirebaseInit.auth.signOut();
    await FirebaseInit.auth.signInAnonymously();
    await sharedPreferences.remove("isCust");
    return Right(true);
  }
}
