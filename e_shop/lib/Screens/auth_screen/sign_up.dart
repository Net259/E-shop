import 'package:e_shop/Controllers/firebase_auth.dart';
import 'package:e_shop/Controllers/home_controller.dart';
import 'package:e_shop/constants/colors.dart';
import 'package:e_shop/constants/constants.dart';
import 'package:e_shop/constants/route.dart';
import 'package:e_shop/Screens/auth_screen/login.dart';
import 'package:e_shop/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkeyy = GlobalKey<FormState>();
  var nameControllerr = TextEditingController();
  var emailControllerr = TextEditingController();
  var phoneControllerr = TextEditingController();
  var passControllerr = TextEditingController();
  var repassControllerr = TextEditingController();

  bool passToggle = true;
  bool confirmpassToggle = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: _formkeyy,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(40, 25, 0, 0),
                decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(60)),
                  color: Palette.col,
                ),
                height: 75,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.white,
                          ),
                        ),
                        const CustomText(
                          text: 'Create Account',
                          color: Colors.white,
                          size: 16,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      color: Palette.col,
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                        ),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 30, left: 20, right: 20),
                        child: Center(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: nameControllerr,
                                  decoration: const InputDecoration(
                                    labelText: "User name",
                                    labelStyle: TextStyle(
                                        color: Palette.col,
                                        fontFamily: 'merienda',
                                        fontSize: 15),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                  width: double.infinity,
                                ),
                                TextFormField(
                                  controller: emailControllerr,
                                  keyboardType: TextInputType.emailAddress,
                                  showCursor: true,
                                  cursorColor: Palette.col,
                                  decoration: const InputDecoration(
                                    labelText: "Email Address",
                                    labelStyle: TextStyle(
                                        color: Palette.col,
                                        fontFamily: 'merienda',
                                        fontSize: 15),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                  width: double.infinity,
                                ),
                                IntlPhoneField(
                                  controller: phoneControllerr,
                                  decoration: const InputDecoration(
                                    labelText: "Phone Number",
                                    labelStyle: TextStyle(
                                        color: Palette.col,
                                        fontFamily: 'merienda',
                                        fontSize: 15),
                                  ),
                                  initialCountryCode: 'IQ',
                                ),
                                const SizedBox(
                                  height: 20,
                                  width: double.infinity,
                                ),
                                TextFormField(
                                  obscureText: passToggle,
                                  controller: passControllerr,
                                  decoration: InputDecoration(
                                    suffix: InkWell(
                                      onTap: () {
                                        setState(() {
                                          passToggle = !passToggle;
                                        });
                                      },
                                      child: Icon(
                                        passToggle
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Palette.col,
                                      ),
                                    ),
                                    labelText: "Password",
                                    labelStyle: const TextStyle(
                                        color: Palette.col,
                                        fontFamily: 'merienda',
                                        fontSize: 15),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                  width: double.infinity,
                                ),
                                TextFormField(
                                  controller: repassControllerr,
                                  obscureText: confirmpassToggle,
                                  validator: (value) {
                                    if (passControllerr.text !=
                                        repassControllerr.text) {
                                      return "Please Retype Password";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    suffix: InkWell(
                                      onTap: () {
                                        setState(() {
                                          confirmpassToggle =
                                              !confirmpassToggle;
                                        });
                                      },
                                      child: Icon(
                                        confirmpassToggle
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Palette.col,
                                      ),
                                    ),
                                    labelText: "Confirm Password",
                                    labelStyle: const TextStyle(
                                        color: Palette.col,
                                        fontFamily: 'merienda',
                                        fontSize: 15),
                                  ),
                                ),
                                const SizedBox(
                                  height: 45,
                                  width: double.infinity,
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: Palette.col,
                                  ),
                                  width: double.infinity,
                                  height: 40,
                                  child: OutlinedButton(
                                    child: const Text(
                                      "Sign Up",
                                      style: TextStyle(
                                        fontFamily: 'merienda',
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: () async {
                                      bool isVaildated = signUpVaildation(
                                          emailControllerr.text,
                                          passControllerr.text,
                                          nameControllerr.text,
                                          phoneControllerr.text);
                                      if (isVaildated) {
                                        bool isLogined =
                                            await FirebaseAuthHelper.instance
                                                .signUp(
                                                    nameControllerr.text,
                                                    emailControllerr.text,
                                                    passControllerr.text,
                                                    phoneControllerr.text,
                                                    context);
                                        if (isLogined) {
                                          // ignore: use_build_context_synchronously
                                          Routes.instance.pushAndRemoveUntil(
                                              widget: const Home(),
                                              context: context);
                                        }
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                  width: double.infinity,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "I Have Already An Account",
                                      style: TextStyle(
                                        fontFamily: 'merienda',
                                        fontSize: 13,
                                        color: Palette.col,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    GestureDetector(
                                      child: const Text(
                                        "Login",
                                        style: TextStyle(
                                          fontFamily: 'merienda',
                                          fontSize: 13,
                                          color: Palette.col,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      onTap: () {
                                        Routes.instance.push(
                                            widget: const Login(),
                                            context: context);
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
