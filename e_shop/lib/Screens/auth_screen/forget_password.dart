import 'package:e_shop/Screens/auth_screen/login.dart';
import 'package:e_shop/constants/colors.dart';
import 'package:e_shop/constants/constants.dart';
import 'package:e_shop/constants/route.dart';
import 'package:e_shop/widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.col,
        title: const CustomText(
          text: 'Forget Password',
          color: Colors.white,
          size: 16,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              showCursor: true,
              cursorColor: Palette.col,
              decoration: const InputDecoration(
                labelText: "Email Address",
                labelStyle: TextStyle(
                    color: Palette.col, fontFamily: 'merienda', fontSize: 15),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
                width: 300,
                height: 55,
                decoration: const BoxDecoration(
                  color: Palette.col,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: CupertinoButton(
                  onPressed: () {
                    auth
                        .sendPasswordResetEmail(
                            email: emailController.text.toString())
                        .then((value) {
                      successMessage(
                          'We have sent you email to recover password, please check email');
                      Routes.instance
                          .push(widget: const Login(), context: context);
                    }).onError((error, stackTrace) {
                      errorMessage(error.toString());
                    });
                  },
                  child: const CustomText(
                      text: "Forgot", color: Colors.white, size: 16),
                ))
          ],
        ),
      ),
    );
  }
}
