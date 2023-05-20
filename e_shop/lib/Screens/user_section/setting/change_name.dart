import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:e_shop/constants/colors.dart';
import 'package:e_shop/constants/constants.dart';
import 'package:e_shop/models/user_model.dart';
import 'package:e_shop/provider/app_provider.dart';
import 'package:e_shop/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeName extends StatefulWidget {
  final dynamic data;
  const ChangeName({super.key, this.data});

  @override
  // ignore: library_private_types_in_public_api
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<ChangeName> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    String initialValue = appProvider.getUserInformation!.name;
    nameController = TextEditingController(text: initialValue);
  }

  @override
  void dispose() {
    nameController.dispose();

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
            text: 'Edit Name',
            color: Colors.white,
            size: 16,
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextFormField(
                      controller: nameController,
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
                        hintText: 'Enter Your Name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 80,
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          UserModel userModel = appProvider.getUserInformation!
                              .copyWith(name: nameController.text);
                          appProvider.updateUserInfoFirebase(
                              context, userModel, null);

                          Navigator.of(context, rootNavigator: true).pop();

                          Navigator.of(context).pop();
                        }
                        successMessage("Successfully updated ");
                      },
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
