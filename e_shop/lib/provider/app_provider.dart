import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Controllers/firebase_firestore.dart';
import 'package:e_shop/Controllers/firebase_storage.dart';
import 'package:e_shop/models/product_model.dart';
import 'package:e_shop/models/user_model.dart';
import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  //// Cart Work
  final List<ProductModel> _cartProductList = [];
  final List<ProductModel> _buyProductList = [];
  UserModel? _userModel;
  UserModel? get getUserInformation => _userModel;

  void addCartProduct(ProductModel productModel) {
    _cartProductList.add(productModel);
    notifyListeners();
  }

  void removeCartProduct(ProductModel productModel) {
    _cartProductList.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get getCartProductList => _cartProductList;
/////////////////////////////////////////////////////////////////////////

  ////// User Information
  void getUserInfoFirebase() async {
    _userModel = await FirebaseFirestoreMethod.instance.getUserInformation();
    notifyListeners();
  }

  void updateUserInfoFirebase(
      BuildContext context, UserModel userModel, File? file) async {
    if (file == null) {
      _userModel = userModel;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_userModel!.id)
          .set(_userModel!.toJson());
    } else {
      String imageUrl =
          await FirebaseStorageHelper.instance.uploadUserImage(file);
      _userModel = userModel.copyWith(image: imageUrl);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_userModel!.id)
          .set(_userModel!.toJson());
    }

    notifyListeners();
  }

  //////// TOTAL PRICE / // / // / / // / / / // /

  double totalPrice() {
    double totalPrice = 0.0;
    for (var element in _cartProductList) {
      totalPrice += element.price * element.qty!;
    }
    return totalPrice;
  }

  double totalPriceBuyProductList() {
    double totalPrice = 0.0;
    for (var element in _buyProductList) {
      totalPrice += element.price * element.qty!;
    }
    return totalPrice;
  }

  void updateQty(ProductModel productModel, int qty) {
    int index = _cartProductList.indexOf(productModel);
    _cartProductList[index].qty = qty;
    notifyListeners();
  }
  ///////// BUY Product  / / // / / // / / / // /

  void addBuyProduct(ProductModel model) {
    _buyProductList.add(model);
    notifyListeners();
  }

  void addBuyProductCartList() {
    _buyProductList.addAll(_cartProductList);
    notifyListeners();
  }

  void clearCart() {
    _cartProductList.clear();
    notifyListeners();
  }

  void clearBuyProduct() {
    _buyProductList.clear();
    notifyListeners();
  }

  List<ProductModel> get getBuyProductList => _buyProductList;
}
