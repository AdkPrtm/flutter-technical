import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:techincal_test_flutter/model/user_model.dart';

class HomeService {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('users');

  Future<Either> getDataUser() async {
    try {
      final result = await _collectionReference.get();
      final userData = result.docs
          .map((data) => UserModel.fromSnapshot(
              data as DocumentSnapshot<Map<String, dynamic>>))
          .toList();
      return Right(userData);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
