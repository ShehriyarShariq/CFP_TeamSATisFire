import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:satisfire_hackathon/core/error/failures.dart';
import 'package:satisfire_hackathon/core/firebase/firebase.dart';
import 'package:satisfire_hackathon/core/network/network_info.dart';
import 'package:satisfire_hackathon/core/util/constants.dart';
import 'package:satisfire_hackathon/features/welcome/domain/repositories/welcome_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeRepositoryImpl extends WelcomeRepository {
  final NetworkInfo networkInfo;
  final SharedPreferences sharedPreferences;

  WelcomeRepositoryImpl({this.sharedPreferences, this.networkInfo});

  @override
  Future<Either<Failure, Map<String, bool>>> checkCurrentUser() async {
    // if (await networkInfo.isConnected) {
    try {
      User currentUser = FirebaseInit.auth.currentUser;
      if (currentUser == null) return Left(AuthFailure());

      bool isCust = await FirebaseInit.dbRef
          .child("customer/${currentUser.uid}")
          .once()
          .then((snapshot) => snapshot.value != null);

      await sharedPreferences.setBool("isCust", isCust);

      return Right({
        'isSignedIn': true,
        'isCust': isCust,
      });
    } catch (e) {
      print("Exception in checkCurrentUser(): " + e.toString());
      return Left(AuthFailure());
    }
    // } else {
    //   User currentUser = FirebaseInit.auth.currentUser;
    //   if (currentUser == null) return Left(AuthFailure());

    //   return Right({
    //     'isSignedIn': true,
    //     'isCust': sharedPreferences.getBool("isCust") ?? false,
    //   });
    // }
  }

  @override
  Future<bool> getIsNewUser() {
    return Future.value(
        !sharedPreferences.containsKey(Constants.FIRST_TIME_USER_CHECK_PREF));
  }

  @override
  Future<void> setIsNewUser() {
    return Future.value(
        sharedPreferences.setBool(Constants.FIRST_TIME_USER_CHECK_PREF, true));
  }
}
