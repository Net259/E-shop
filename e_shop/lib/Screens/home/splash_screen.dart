import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:e_shop/Controllers/home_controller.dart';
import 'package:e_shop/constants/colors.dart';
import 'package:e_shop/constants/route.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      Routes.instance.push(widget: const Home(), context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Image(
                image: AssetImage('assets/img/shopping-bag-icon.png'),
                height: 150,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "E-Shop",
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'merienda',
                  color: Palette.col,
                ),
              ),
              Spacer(),
              Text("Version 1.0.0"),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
