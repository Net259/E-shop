import 'package:animate_do/animate_do.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:e_shop/Screens/home/home_screen.dart';
import 'package:e_shop/Screens/home/search.dart';
import 'package:e_shop/Screens/home/cart.dart';
import 'package:e_shop/Screens/home/favorite.dart';
import 'package:e_shop/constants/colors.dart';
import 'package:e_shop/widgets/my_drawer.dart';
import 'package:e_shop/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

String name = "E-Shop";

int index = 0;
bool isSearchActive = false;

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        drawer: const Drawer(
          child: MyDrawer(),
        ),
        appBar: AppBar(
          title: isSearchActive
              ? FadeIn(
                  delay: const Duration(milliseconds: 300),
                  child: const CustomText(
                    text: 'Search',
                    color: Colors.white,
                    size: 16,
                  ),
                )
              : FadeIn(
                  delay: const Duration(milliseconds: 300),
                  child: CustomText(
                    text: name,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
          backgroundColor: Palette.col,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    isSearchActive = !isSearchActive;
                  });
                },
                icon: const Icon(
                  LineIcons.search,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
          ],
        ),
        extendBody: true,
        body: getSelectedWidget(index: index),
        bottomNavigationBar: CurvedNavigationBar(
          height: 60,
          backgroundColor: Colors.transparent,
          color: Palette.col,
          animationDuration: const Duration(milliseconds: 300),
          index: index,
          onTap: (selectedindex) {
            setState(() {
              index = selectedindex;

              if (index == 1) {
                name = "Favorite";
              } else if (index == 2) {
                name = "Cart";
              } else {
                name = "E-Shop";
              }
            });
          },
          items: const [
            Icon(
              Icons.home,
              color: Colors.white,
            ),
            Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget getSelectedWidget({required int index}) {
    Widget widget;
    switch (index) {
      case 1:
        widget = isSearchActive ? const Search() : const Favorite();
        isSearchActive = false;
        break;
      case 2:
        widget = isSearchActive ? const Search() : const Cart();
        isSearchActive = false;
        break;
      default:
        widget = isSearchActive ? const Search() : const HomeScreen();
        isSearchActive = false;
    }
    isSearchActive = false;

    return widget;
  }
}
