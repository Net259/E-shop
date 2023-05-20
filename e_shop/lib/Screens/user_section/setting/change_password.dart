import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:e_shop/Controllers/firebase_auth.dart';
import 'package:e_shop/constants/colors.dart';
import 'package:e_shop/constants/constants.dart';
import 'package:e_shop/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool passToggle = true;
  bool passToggle2 = true;
  TextEditingController newpassword = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Palette.col,
            title: const CustomText(
              text: 'Change Password',
              color: Colors.white,
              size: 16,
            )),
        body: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              TextFormField(
                controller: newpassword,
                obscureText: passToggle,
                decoration: InputDecoration(
                   focusedBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: Palette.col,
                                  width: 2,
                                ),),
                  hintText: "New Password",
                  prefixIcon: const Icon(
                    Icons.password_sharp,color: Palette.col,
                  ),
                  suffix: InkWell(
                    onTap: () {
                      setState(() {
                        passToggle = !passToggle;
                      });
                    },
                    child: Icon(
                      passToggle ? Icons.visibility : Icons.visibility_off,
                      color: Palette.col,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              TextFormField(
                controller: confirmpassword,
                obscureText: passToggle2,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: Palette.col,
                                  width: 2,
                                ),),
                  hintText: "Confrim Password",
                  prefixIcon: const Icon(
                    Icons.password_sharp,color: Palette.col,
                  ),
                  suffix: InkWell(
                    onTap: () {
                      setState(() {
                        passToggle2 = !passToggle2;
                      });
                    },
                    child: Icon(
                      passToggle2 ? Icons.visibility : Icons.visibility_off,
                      color: Palette.col,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              Container(
                width: 300,
                height: 60,
                decoration: const BoxDecoration(
                  color: Palette.col,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: CupertinoButton(
                  child: const CustomText(
                    text: "Update",
                    color: Colors.white,
                    size: 16,
                  ),
                  onPressed: () async {
                    if (newpassword.text.isEmpty) {
                      errorMessage("New Password is empty");
                    } else if (confirmpassword.text.isEmpty) {
                      errorMessage("Confirm Password is empty");
                    } else if (confirmpassword.text == newpassword.text) {
                      FirebaseAuthHelper.instance
                          .changePassword(newpassword.text);
                      Navigator.of(context).pop();
                    } else {
                      errorMessage("Confrim Password is not match");
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
