import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:satisfire_hackathon/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:satisfire_hackathon/core/firebase/firebase.dart';
import 'package:satisfire_hackathon/core/network/network_info.dart';
import 'package:satisfire_hackathon/features/create_edit_service/domain/repositories/create_edit_service_repository.dart';
import 'package:satisfire_hackathon/features/service_details/data/models/service.dart';

class CreateEditServiceRepositoryImpl extends CreateEditServiceRepository {
  final NetworkInfo networkInfo;

  CreateEditServiceRepositoryImpl({this.networkInfo});

  @override
  Future<Either<Failure, bool>> saveService(
      Service service, List<File> images) async {
    if (await networkInfo.isConnected) {
      try {
        String serviceID = FirebaseInit.auth.currentUser.uid +
            "_" +
            (FirebaseInit.dbRef.child("services").push().key);
        List<String> imageURLs = [];
        if (images.length > 0) {
          await Future.forEach(images, (image) async {
            UploadTask uploadTask =
                FirebaseInit.storageRef.child("services/").putFile(image);
            await uploadTask.then((snapshot) async {
              imageURLs.add(await snapshot.ref.getDownloadURL());
            });
          });
        }

        service.images = imageURLs;

        await FirebaseInit.dbRef
            .child("services/$serviceID")
            .set(service.toJson());

        return Right(true);
      } catch (e) {
        print("Exception at saveService(): " + e);
        return Left(ProcessFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
