import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Controllers/home_controller.dart';
import 'package:e_shop/constants/constants.dart';
import 'package:e_shop/constants/route.dart';
import 'package:e_shop/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthHelper {
  static FirebaseAuthHelper instance = FirebaseAuthHelper();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<User?> get getAuthChange => _auth.authStateChanges();

  Future<bool> login(
      String email, String password, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // ignore: use_build_context_synchronously
      Navigator.of(context, rootNavigator: true).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context, rootNavigator: true).pop();
      errorMessage(error.code.toString());
      return false;
    }
  }

  Future<bool> signUp(String name, String email, String password, String phone,
      BuildContext context) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      UserModel userModel = UserModel(
          id: userCredential.user!.uid,
          name: name,
          email: email,
          image: null,
          phone: phone,
          address: "",
          password: password);

      _firestore.collection("users").doc(userModel.id).set(userModel.toJson());
      // ignore: use_build_context_synchronously
      Navigator.of(context, rootNavigator: true).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context, rootNavigator: true).pop();
      errorMessage(error.code.toString());
      return false;
    }
  }

  void signOut() async {
    await _auth.signOut();
  }

  Future<void> changePassword(String newPassword) async {
    try {
      final User? user = _auth.currentUser;
      await user?.updatePassword(newPassword);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user?.uid)
          .update({
        "password": newPassword,
      });

      successMessage("Password Changed");

    } catch (e) {
      errorMessage('Error updating password: $e');
    }
  }

  Future<void> deleteAccount(BuildContext context) async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).delete();
        await user.delete();
        signOut();
        // ignore: use_build_context_synchronously
        Routes.instance.push(widget: const Home(), context: context);
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content:
                const Text('Failed to delete account. Please try again later.'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
