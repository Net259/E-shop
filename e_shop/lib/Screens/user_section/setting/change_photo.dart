import 'dart:io';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:e_shop/constants/colors.dart';
import 'package:e_shop/constants/constants.dart';
import 'package:e_shop/models/user_model.dart';
import 'package:e_shop/provider/app_provider.dart';
import 'package:e_shop/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ChangePhoto extends StatefulWidget {
  final dynamic data;
  const ChangePhoto({super.key, this.data});

  @override
  // ignore: library_private_types_in_public_api
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<ChangePhoto> {
  File? image;
  void takePicture() async {
    XFile? value = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 40);
    if (value != null) {
      setState(() {
        image = File(value.path);
      });
    }
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
            text: 'Edit Photo',
            color: Colors.white,
            size: 16,
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                image == null
                    ? CupertinoButton(
                        onPressed: () {
                          takePicture();
                        },
                        child: Container(
                          width: 300,
                          height: 300,
                          decoration: BoxDecoration(
                            color: Palette.col.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 10,
                                color: Color.fromARGB(70, 0, 0, 0),
                              )
                            ],
                          ),
                          child: const Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      )
                    : CupertinoButton(
                        onPressed: () {
                          takePicture();
                        },
                        child: Container(
                          width: 300,
                          height: 300,
                          decoration: BoxDecoration(
                            border: Border.all(color: Palette.col, width: 2),
                            image: DecorationImage(
                              image: FileImage(image!),
                              fit: BoxFit.cover,
                            ),
                            color: Palette.col.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 10,
                                color: Color.fromARGB(70, 0, 0, 0),
                              )
                            ],
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 60,
                ),
                Container(
                  width: 300,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Palette.col,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 10,
                        color: Color.fromARGB(70, 0, 0, 0),
                      )
                    ],
                  ),
                  child: CupertinoButton(
                    child: const CustomText(
                      text: "Update",
                      color: Colors.white,
                      size: 16,
                    ),
                    onPressed: () {
                      UserModel userModel =
                          appProvider.getUserInformation!.copyWith();
                      appProvider.updateUserInfoFirebase(
                          context, userModel, image);
                      Navigator.of(context, rootNavigator: true).pop();

                      Navigator.of(context).pop();
                      successMessage("Successfully updated ");
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
