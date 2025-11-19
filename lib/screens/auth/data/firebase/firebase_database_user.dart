import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasky/network/result_firebase.dart';
import 'package:tasky/screens/auth/data/model/user_model.dart';

abstract class FBAUser {
  static CollectionReference<UserModel> get _getCollection {
    return FirebaseFirestore.instance
        .collection(UserModel.collection)
        .withConverter(
          fromFirestore: (snap, _) => UserModel.fromJson(snap.data()!),
          toFirestore: (userModel, _) => userModel.toJson(),
        );
  }

  static Future<void> addUser(UserModel user) async {
    try {
      await _getCollection.doc(user.id).set(user);
    } catch (e) {
      throw "Error from Add User $e";
    }
  }

  static Future<ResultFB<UserModel>> registerUser(UserModel user) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: user.email ?? "",
        password: user.password ?? "",
      );
      user.id = credential.user?.uid;
      await _getCollection.doc(user.id).set(user);
      return SuccessFB(data: user);
    } catch (e) {
      return ErrorFB(e.toString());
    }
  }

  static Future<ResultFB<UserCredential>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
     final userCredential=await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return SuccessFB(data: userCredential);
    } catch (e) {
      return ErrorFB(e.toString());
    }
  }
}
