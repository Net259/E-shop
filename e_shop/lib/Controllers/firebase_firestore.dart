import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Controllers/home_controller.dart';
import 'package:e_shop/constants/constants.dart';
import 'package:e_shop/constants/route.dart';
import 'package:e_shop/models/category_model.dart';
import 'package:e_shop/models/product_model.dart';
import 'package:e_shop/models/user_model.dart';
import 'package:e_shop/provider/app_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class FirebaseFirestoreMethod {
  static FirebaseFirestoreMethod instance = FirebaseFirestoreMethod();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("categories").get();

      List<CategoryModel> categoriesList = querySnapshot.docs
          .map((e) => CategoryModel.fromJson(e.data()))
          .toList();

      return categoriesList;
    } catch (e) {
      errorMessage(e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getProducts() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collectionGroup("products").get();

      List<ProductModel> productModelList = querySnapshot.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();

      return productModelList;
    } catch (e) {
      errorMessage(e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getCategoryViewProduct(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection("categories")
              .doc(id)
              .collection("products")
              .get();

      List<ProductModel> productModelList = querySnapshot.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();

      return productModelList;
    } catch (e) {
      errorMessage(e.toString());
      return [];
    }
  }

  Future<UserModel?> getUserInformation() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return null;
    }

    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore.collection("users").doc(currentUser.uid).get();

    if (!querySnapshot.exists) {
      return null;
    }

    final userData = querySnapshot.data();
    if (userData == null) {
      return null;
    }

    return UserModel.fromJson(userData);
  }

  Future<bool> uploadOrderedProductFirebase(
      List<ProductModel> list, BuildContext context, String payment) async {
    String orderid = DateTime.now().toString();

    try {
      double totalPrice = 0.0;
      for (var element in list) {
        totalPrice += element.price * element.qty!;
      }
      DocumentReference documentReference = _firebaseFirestore
          .collection("usersOrders")
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection("orders")
          .doc(orderid);

      DocumentReference admin =
          _firebaseFirestore.collection("orders").doc(orderid);

      admin.set({
        "products": list.map((e) => e.toJson()),
        "status": "Pending",
        "totalPrice": totalPrice,
        "payment": payment,
        "orderId": admin.id,
        "orderDate": DateTime.now(),
        "name": Provider.of<AppProvider>(context, listen: false)
            .getUserInformation
            ?.name,
        "phone": Provider.of<AppProvider>(context, listen: false)
            .getUserInformation
            ?.phone,
        "address": Provider.of<AppProvider>(context, listen: false)
            .getUserInformation
            ?.address,
        "email": FirebaseAuth.instance.currentUser!.email,
      });
      documentReference.set({
        "products": list.map((e) => e.toJson()),
        "status": "Pending",
        "totalPrice": totalPrice,
        "payment": payment,
        "orderId": documentReference.id,
        "orderDate": DateTime.now(),
      });
      Routes.instance.push(widget: const Home(), context: context);
      successMessage("Ordered Successfully");
      return true;
    } catch (e) {
      errorMessage(e.toString());
      Navigator.of(context, rootNavigator: true).pop();
      return false;
    }
  }

  Future<bool> uploadFavoriteProduct(
      List<ProductModel> list, BuildContext context) async {
    String id = DateTime.now().toString();

    try {
      DocumentReference documentReference = _firebaseFirestore
          .collection("usersWishList")
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection("WishList")
          .doc(id);
      documentReference.set({
        "products": list.map((e) => e.toJson()),
        "fDate": DateTime.now(),
        "fId": DateTime.now(),
      });

      return true;
    } catch (e) {
      errorMessage(e.toString());
      Navigator.of(context, rootNavigator: true).pop();
      return false;
    }
  }

  Future<bool> deleteFavoriteProduct(String id, BuildContext context) async {
    try {
      String? userEmail = FirebaseAuth.instance.currentUser!.email;

      await FirebaseFirestore.instance
          .collection("usersWishList")
          .doc(userEmail)
          .collection("WishList")
          .doc(id)
          .delete();

      successMessage("Product deleted from wishlist successfully");
      return true;
    } catch (e) {
      errorMessage("Error deleting product from wishlist: $e");
      Navigator.of(context, rootNavigator: true).pop();
      return false;
    }
  }
}
