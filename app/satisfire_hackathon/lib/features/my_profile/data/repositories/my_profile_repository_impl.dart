import 'package:firebase_storage/firebase_storage.dart';
import 'package:satisfire_hackathon/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:satisfire_hackathon/core/firebase/firebase.dart';
import 'package:satisfire_hackathon/core/network/network_info.dart';
import 'dart:io';

import 'package:satisfire_hackathon/features/my_profile/domain/repositories/my_profile_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfileRepositoryImpl extends MyProfileRepository {
  final NetworkInfo networkInfo;
  final SharedPreferences sharedPreferences;

  MyProfileRepositoryImpl({this.networkInfo, this.sharedPreferences});

  @override
  Future<Either<Failure, bool>> updateData(String type, String data) async {
    if (await networkInfo.isConnected != null) {
      try {
        await FirebaseInit.dbRef
            .child((sharedPreferences.getBool("isProvider")
                    ? "provider"
                    : "customer") +
                "/${FirebaseInit.auth.currentUser.uid}/type")
            .set(data);

        if (type == "name") {
          await FirebaseInit.auth.currentUser.updateProfile(displayName: data);
        }

        return Right(true);
      } catch (e) {
        print("Exception in updateData(): " + e.toString());
        return Left(ProcessFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> uploadProfileImage(File image) async {
    if (await networkInfo.isConnected != null) {
      try {
        UploadTask uploadTask = FirebaseInit.storageRef
            .child("users/${FirebaseInit.auth.currentUser.uid}")
            .putFile(image);
        await uploadTask.then((snapshot) async {
          String downloadURL = await snapshot.ref.getDownloadURL();

          await FirebaseInit.auth.currentUser
              .updateProfile(photoURL: downloadURL);
          await FirebaseInit.dbRef
              .child((sharedPreferences.getBool("isProvider")
                      ? "provider"
                      : "customer") +
                  "/${FirebaseInit.auth.currentUser.uid}/imageURL")
              .set(downloadURL);
        });

        return Right(true);
      } catch (e) {
        print("Exception in uploadProfileImage(): " + e.toString());
        return Left(ProcessFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
