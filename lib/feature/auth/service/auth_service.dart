import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:techincal_test_flutter/model/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('users');

  //REGISTER SERVICE PROCCESS
  Future<Either> registerWithEmail({
    required String nama,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user!.updateDisplayName(nama);
      await userCredential.user!.sendEmailVerification();

      UserModel userModel = UserModel(
        id: userCredential.user!.uid,
        name: nama,
        email: email,
        verified: false,
      );

      await _collectionReference.doc(userCredential.user!.uid).set({
        'uid': userModel.id,
        'email': userModel.email,
        'name': userModel.name,
        'verified': userModel.verified,
      });

      return Right(userModel);
    } on FirebaseAuthException catch (e) {
      return Left(e.message);
    }
  }

  //LOGIN SERVICE PROCCESS
  Future<Either> loginWithEmail(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user!.emailVerified) {
        await _collectionReference
            .doc(userCredential.user!.uid)
            .update({'verified': true});
        DocumentSnapshot snapshot =
            await _collectionReference.doc(userCredential.user!.uid).get();
        UserModel userModel = UserModel(
          id: userCredential.user!.uid,
          name: snapshot['name'],
          email: snapshot['email'],
          verified: snapshot['verified'],
        );
        return Right(userModel);
      } else {
        return const Left('Please verify your email address first');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return const Left('No user exists with this email.');
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        return const Left('Incorrect Password.');
      } else if (e.code == 'too-many-requests'){
        return Left(e.message);
      }
      return const Left('Upss, something went wrong');
    }
  }

  //LOAD USER BY ID PROCCESS
  Future<Either> getDataCredentials({required String uid}) async {
    try {
      DocumentSnapshot snapshot = await _collectionReference.doc(uid).get();
      UserModel userModel = UserModel(
        id: uid,
        name: snapshot['name'],
        email: snapshot['email'],
        verified: snapshot['verified'],
      );
      return Right(userModel);
    } catch (e) {
      return const Left('Upsss, something went wrong');
    }
  }

  //LOGOUT PROCCESS
  Future<Either> logoutUser() async {
    try {
      await _auth.signOut();
      return const Right('Success');
    } catch (e) {
      return Left(e.toString());
    }
  }

  //FORGOT PASSWORD PROCCESS
  Future<Either> forgotPass(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return const Right('Success');
    } on FirebaseAuthException catch (e) {
      return Left(e.message.toString());
    }
  }
}
