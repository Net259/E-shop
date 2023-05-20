import 'dart:io';
import 'package:e_shop/constants/colors.dart';
import 'package:e_shop/models/user_model.dart';
import 'package:e_shop/provider/app_provider.dart';
import 'package:e_shop/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  final dynamic data;
  const EditProfile({super.key, this.data});

  @override
  // ignore: library_private_types_in_public_api
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  File? image;
  void takePicture() async {
    XFile? value = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 70);
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
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: 'Edit Profile',
          color: Colors.white,
          size: 16,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              image == null
                  ? CupertinoButton(
                      onPressed: () {
                        takePicture();
                      },
                      child: const CircleAvatar(
                          radius: 55, child: Icon(Icons.camera_alt)),
                    )
                  : CupertinoButton(
                      onPressed: () {
                        takePicture();
                      },
                      child: CircleAvatar(
                        radius: 63,
                        backgroundColor: Palette.col,
                        child: CircleAvatar(
                          backgroundImage: FileImage(image!),
                          radius: 60,
                        ),
                      ),
                    ),
              const SizedBox(height: 16),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: appProvider.getUserInformation!.name,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: appProvider.getUserInformation!.email,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                  hintText: appProvider.getUserInformation!.phone,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    UserModel userModel = appProvider.getUserInformation!
                        .copyWith(
                            name: nameController.text,
                            phone: phoneController.text);
                    appProvider.updateUserInfoFirebase(
                        context, userModel, image);
                  },
                  child: const Text("Save Changes"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
