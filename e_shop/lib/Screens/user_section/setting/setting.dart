import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:e_shop/Controllers/firebase_auth.dart';
import 'package:e_shop/Screens/user_section/setting/change_password.dart';
import 'package:e_shop/Screens/user_section/setting/change_name.dart';
import 'package:e_shop/Screens/user_section/setting/change_phone.dart';
import 'package:e_shop/Screens/user_section/setting/change_photo.dart';
import 'package:e_shop/constants/colors.dart';
import 'package:e_shop/constants/route.dart';
import 'package:e_shop/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  final dynamic data;
  const Setting({super.key, this.data});

  @override
  // ignore: library_private_types_in_public_api
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Palette.col,
          title: const CustomText(
            text: 'Setting',
            color: Colors.white,
            size: 16,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  Routes.instance
                      .push(widget: const ChangePhoto(), context: context);
                },
                leading: const Icon(
                  Icons.photo_camera_front_outlined,
                  color: Palette.col,
                ),
                title: const CustomText(
                  text: "Change Photo",
                  size: 15,
                  color: Palette.col,
                ),
              ),
              ListTile(
                onTap: () {
                  Routes.instance
                      .push(widget: const ChangeName(), context: context);
                },
                leading: const Icon(
                  Icons.change_circle_outlined,
                  color: Palette.col,
                ),
                title: const CustomText(
                  text: "Change Name",
                  size: 15,
                  color: Palette.col,
                ),
              ),
              ListTile(
                onTap: () {
                  Routes.instance
                      .push(widget: const ChangePhone(), context: context);
                },
                leading: const Icon(
                  Icons.phone,
                  color: Palette.col,
                ),
                title: const CustomText(
                  text: "Change Phone Namber",
                  size: 15,
                  color: Palette.col,
                ),
              ),
              ListTile(
                onTap: () {
                  Routes.instance
                      .push(widget: const ChangePassword(), context: context);
                },
                leading: const Icon(
                  Icons.lock_outline,
                  color: Palette.col,
                ),
                title: const CustomText(
                  text: "Change Password",
                  size: 15,
                  color: Palette.col,
                ),
              ),
              ListTile(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const CustomText(
                          text: 'Delete Your Account',
                          color: Colors.red,
                          size: 12,
                        ),
                        content: const CustomText(
                          text: 'Are you sure you want to delete your account?',
                          color: Colors.black,
                          size: 12,
                        ),
                        actions: [
                          TextButton(
                            child: const CustomText(
                              text: 'No',
                              color: Colors.black,
                              size: 12,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const CustomText(
                              text: 'Yes',
                              color: Colors.red,
                              size: 12,
                            ),
                            onPressed: () {
                              FirebaseAuthHelper.instance
                                  .deleteAccount(context);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                  
                },
                leading: const Icon(
                  Icons.delete_rounded,
                  color: Colors.red,
                ),
                title: const CustomText(
                  text: "Delete Account",
                  size: 15,
                  color: Palette.col,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
