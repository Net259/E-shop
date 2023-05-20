import 'package:e_shop/Controllers/firebase_option.dart';
import 'package:e_shop/constants/colors.dart';
import 'package:e_shop/provider/app_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Screens/home/splash_screen.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'Controllers/theme_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseConfig.platformOptions,
  );

  final themeService = await ThemeService.instance;
  var initTheme = themeService.initial;
  runApp(EShop(theme: initTheme));
}

class EShop extends StatelessWidget {
  const EShop({
    Key? key,
    required this.theme,
  }) : super(key: key);
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
        initTheme: theme,
        builder: (_, theme) {
          return ChangeNotifierProvider(
            create: (context) => AppProvider(),
            child: MaterialApp(
                title: "E-Shop",
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: Palette.col,
                ),
                home: const Scaffold(
                  extendBody: true,
                  body: Splash(),
                )),
          );
        });
  }
}


                    //   StreamBuilder(
                    //   stream: FirebaseAuthHelper.instance.getAuthChange,
                    //   builder: (context, snapshot) {
                    //     if (snapshot.hasData) {
                    //       return const Home();
                    //     }
                    //     return const Welcome();
                    //   },
                    // ),