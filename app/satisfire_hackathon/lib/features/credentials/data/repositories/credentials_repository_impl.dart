import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:satisfire_hackathon/core/error/failures.dart';
import 'package:satisfire_hackathon/core/firebase/firebase.dart';
import 'package:satisfire_hackathon/core/network/network_info.dart';
import 'package:satisfire_hackathon/features/credentials/data/models/credentials_model.dart';
import 'package:satisfire_hackathon/features/credentials/domain/repositories/credentials_repository.dart';

class CredentialsRepositoryImpl extends CredentialsRepository {
  final NetworkInfo networkInfo;

  CredentialsRepositoryImpl({this.networkInfo});

  // @override
  // Future<Either<Failure, bool>> signInWithCredentials(
  //     CredentialsModel credentials) async {
  //   if (await networkInfo.isConnected) {
  //     try {
  //       await FirebaseInit.auth.signInWithEmailAndPassword(
  //           email: credentials.email, password: credentials.password);

  //       User currentUser = FirebaseInit.auth.currentUser;

  //       bool isProvidder = (await FirebaseInit.dbRef
  //           .child("provider/${currentUser.uid}")
  //           .once()
  //           .then((snapshot) => snapshot.value != null));

  //       if (!isProvidder) {
  //         await FirebaseInit.fcm.subscribeToTopic(currentUser.uid);
  //         await FirebaseInit.fcm.subscribeToTopic("scheduled_notifs");

  //         return Right(false);
  //       }

  //       return Right(true);
  //     } on FirebaseAuthException catch (e) {
  //       return Left(AuthFailure(errorMsg: e.message));
  //     }
  //   } else {
  //     return Left(NetworkFailure());
  //   }
  // }

  // @override
  // Future<Either<Failure, bool>> signUpWithCredentials(
  //     CredentialsModel credentials) async {
  //   if (await networkInfo.isConnected) {
  //     try {
  //       await FirebaseInit.auth.(credentials.phoneNum);        

  //       User currentUser = FirebaseInit.auth.currentUser;
  //       currentUser.updateProfile(displayName: credentials.name);

  //       await FirebaseInit.dbRef
  //           .child(
  //               "${credentials.isCustomer ? "customer" : "provider"}/${currentUser.uid}")
  //           .set({
  //         "name": credentials.name.toLowerCase(),
  //         "email": credentials.email,
  //         "phoneNum": credentials.phoneNum
  //       });

  //       return Right(true);
  //     } on FirebaseAuthException catch (e) {
  //       return Left(AuthFailure(errorMsg: e.message));
  //     }
  //   } else {
  //     return Left(NetworkFailure());
  //   }
  // }

  // @override
  // Future<Either<Failure, bool>> sendPasswordResetEmail(String email) async {
  //   if (await networkInfo.isConnected) {
  //     try {
  //       await FirebaseInit.auth.sendPasswordResetEmail(email: email);

  //       return Right(true);
  //     } on FirebaseAuthException catch (e) {
  //       return Right(false);
  //     }
  //   } else {
  //     return Left(NetworkFailure());
  //   }
  // }
}
