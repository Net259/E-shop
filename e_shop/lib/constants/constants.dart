import 'package:e_shop/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void errorMessage(String message) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: Colors.grey,
    textColor: Colors.red,
    fontSize: 16,
  );
}

void successMessage(String message) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: Colors.grey,
    textColor: Palette.col,
    fontSize: 16,
  );
}

bool loginVaildation(String email, String password) {
  if (email.isEmpty && password.isEmpty) {
    errorMessage("Both Fields are empty");
    return false;
  } else if (email.isEmpty) {
    errorMessage("Email is Empty");
    return false;
  } else if (password.isEmpty) {
    errorMessage("Password is Empty");
    return false;
  } else {
    return true;
  }
}

bool signUpVaildation(
    String email, String password, String name, String phone) {
  if (email.isEmpty && password.isEmpty && name.isEmpty && phone.isEmpty) {
    errorMessage("All Fields are empty");
    return false;
  } else if (name.isEmpty) {
    errorMessage("Name is Empty");
    return false;
  } else if (email.isEmpty) {
    errorMessage("Email is Empty");
    return false;
  } else if (phone.isEmpty) {
    errorMessage("Phone is Empty");
    return false;
  } else if (password.isEmpty) {
    errorMessage("Password is Empty");
    return false;
  } else {
    return true;
  }
}
