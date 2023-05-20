import 'package:e_shop/Controllers/home_controller.dart';
import 'package:e_shop/Controllers/firebase_auth.dart';
import 'package:e_shop/Screens/auth_screen/forget_password.dart';
import 'package:e_shop/constants/colors.dart';
import 'package:e_shop/constants/constants.dart';
import 'package:e_shop/constants/route.dart';
import 'package:e_shop/Screens/auth_screen/sign_up.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  bool passToggle = true;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.col,
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(60)),
                  color: Colors.white,
                ),
                height: 200,
                width: double.infinity,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image(
                        image: AssetImage('assets/img/shopping-bag-icon.png'),
                        height: 90,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Palette.col,
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
                                  controller: emailController,
                                  showCursor: true,
                                  cursorColor: Colors.white,
                                  decoration: const InputDecoration(
                                    labelText: "Email Address",
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Colors.white,
                                    ),
                                    labelStyle: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'merienda',
                                        fontSize: 15),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                  width: double.infinity,
                                ),
                                TextFormField(
                                  obscureText: passToggle,
                                  controller: passController,
                                  showCursor: true,
                                  cursorColor: Colors.white,
                                  decoration: InputDecoration(
                                    labelText: "Password",
                                    prefixIcon: const Icon(
                                      Icons.lock,
                                      color: Colors.white,
                                    ),
                                    labelStyle: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'merienda',
                                        fontSize: 15),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
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
                                        color: Colors.white,
                                      ),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: TextButton(
                                      onPressed: () {
                                        Routes.instance.push(
                                            widget: const ForgetPassword(),
                                            context: context);
                                      },
                                      child: const Text(
                                        "Forget Password ?",
                                        style: TextStyle(
                                          fontFamily: 'merienda',
                                          fontSize: 13,
                                          color: Colors.white,
                                        ),
                                      )),
                                ),
                                const SizedBox(
                                  height: 30,
                                  width: double.infinity,
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: Colors.white,
                                  ),
                                  width: double.infinity,
                                  height: 40,
                                  child: OutlinedButton(
                                    child: const Text(
                                      "Login",
                                      style: TextStyle(
                                        fontFamily: 'merienda',
                                        fontSize: 20,
                                        color: Palette.col,
                                      ),
                                    ),
                                    onPressed: () async {
                                      bool isVaildated = loginVaildation(
                                          emailController.text,
                                          passController.text);
                                      if (isVaildated) {
                                        bool isLogined =
                                            await FirebaseAuthHelper.instance
                                                .login(
                                                    emailController.text,
                                                    passController.text,
                                                    context);
                                        if (isLogined) {
                                          // ignore: use_build_context_synchronously
                                          Routes.instance.pushAndRemoveUntil(
                                              widget: const Home(),
                                              context: context);
                                          // ignore: use_build_context_synchronously
                                        } else {
                                          // ignore: use_build_context_synchronously
                                          Routes.instance.pushAndRemoveUntil(
                                              widget: const Login(),
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
                                      "If You Do Not Have Account!",
                                      style: TextStyle(
                                        fontFamily: 'merienda',
                                        fontSize: 13,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    GestureDetector(
                                      child: const Text(
                                        "Sign Up",
                                        style: TextStyle(
                                          fontFamily: 'merienda',
                                          fontSize: 13,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      onTap: () {
                                        Routes.instance.push(
                                            widget: const SignUp(),
                                            context: context);
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
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
