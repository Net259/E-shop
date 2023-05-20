import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:e_shop/constants/colors.dart';
import 'package:e_shop/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Palette.col,
            title: const CustomText(
              text: 'About Us',
              color: Colors.white,
              size: 16,
            )),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: CustomText(
                      text: 'Our Company', color: Palette.col, size: 20)),
              SizedBox(height: 16),
              Text(
                'At E-Shop, we are passionate about providing our customers with the best shopping experience possible. We believe that shopping should be fun, easy, and convenient, and we work hard to make that a reality for every customer.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Merienda',
                    fontSize: 14),
              ),
              SizedBox(height: 16),
              Center(
                  child: CustomText(
                      text: 'Our Team', color: Palette.col, size: 20)),
              SizedBox(height: 16),
              Text(
                'Our team is made up of experienced developers and designers who are dedicated to creating innovative and user-friendly shopping experiences. We are constantly learning and exploring new technologies to ensure that we stay at the forefront of the industry.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Merienda',
                    fontSize: 14),
              ),
              SizedBox(height: 16),
              Center(
                  child: CustomText(
                      text: 'Contact Us', color: Palette.col, size: 20)),
              SizedBox(height: 16),
              Text(
                'If you have any questions, comments, or concerns, please do not hesitate to contact us. You can reach us by email or phone. We are always happy to hear from our customers and we will do everything we can to help.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Merienda',
                    fontSize: 14),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
