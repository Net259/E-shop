import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:e_shop/Screens/check-out/check_out.dart';
import 'package:e_shop/constants/colors.dart';
import 'package:e_shop/constants/route.dart';
import 'package:e_shop/models/product_model.dart';
import 'package:e_shop/models/user_model.dart';
import 'package:e_shop/provider/app_provider.dart';
import 'package:e_shop/widgets/custom_text.dart';

class GetInformationOneProduct extends StatefulWidget {
  final ProductModel singleProduct;
  const GetInformationOneProduct({
    Key? key,
    required this.singleProduct,
  }) : super(key: key);

  @override
  State<GetInformationOneProduct> createState() => _GetInformationState();
}

class _GetInformationState extends State<GetInformationOneProduct> {
  final _formkeyy = GlobalKey<FormState>();

  var addressControllerr = TextEditingController();
  var emailControllerr = TextEditingController();
  var phoneControllerr = TextEditingController();

  @override
  void initState() {
    super.initState();
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    String initialValueEmail = appProvider.getUserInformation!.email;
    emailControllerr = TextEditingController(text: initialValueEmail);
    String initialValuePhone = appProvider.getUserInformation!.phone;
    phoneControllerr = TextEditingController(text: initialValuePhone);
  }

  @override
  void dispose() {
    emailControllerr.dispose();
    phoneControllerr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Palette.col,
            title: const CustomText(
              text: 'About you',
              color: Colors.white,
              size: 16,
            )),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: _formkeyy,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 20, right: 20),
                    child: Center(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: emailControllerr,
                            keyboardType: TextInputType.emailAddress,
                            enabled: false,
                            showCursor: true,
                            cursorColor: Palette.col,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: Palette.col,
                                  width: 2,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: Palette.col,
                                  width: 1,
                                ),
                              ),
                              labelText: "Email Address",
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
                          IntlPhoneField(
                            controller: phoneControllerr,
                            showCursor: true,
                            cursorColor: Palette.col,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: Palette.col,
                                  width: 2,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: Palette.col,
                                  width: 1,
                                ),
                              ),
                              labelText: "Phone Number",
                              labelStyle: const TextStyle(
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
                            controller: addressControllerr,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your address';
                              }
                              return null;
                            },
                            showCursor: true,
                            cursorColor: Palette.col,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: Palette.col,
                                  width: 2,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: Palette.col,
                                  width: 1,
                                ),
                              ),
                              labelText: "Address",
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
                                "Continues",
                                style: TextStyle(
                                  fontFamily: 'merienda',
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                if (_formkeyy.currentState!.validate()) {
                                  UserModel userModel =
                                      appProvider.getUserInformation!.copyWith(
                                          phone: phoneControllerr.text,
                                          address: addressControllerr.text);
                                  appProvider.updateUserInfoFirebase(
                                      context, userModel, null);

                                  ProductModel productModel =
                                      widget.singleProduct.copyWith();
                                  Routes.instance.push(
                                      widget:
                                          Checkout(singleProduct: productModel),
                                      context: context);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
