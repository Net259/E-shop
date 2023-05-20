import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:e_shop/Controllers/theme_service.dart';
import 'package:e_shop/Screens/user_section/order.dart';
import 'package:e_shop/Screens/user_section/setting/setting.dart';
import 'package:e_shop/constants/route.dart';
import 'package:e_shop/Screens/auth_screen/login.dart';
import 'package:e_shop/Screens/user_section/about_us.dart';
import 'package:e_shop/Controllers/firebase_auth.dart';
import 'package:e_shop/constants/colors.dart';
import 'package:e_shop/provider/app_provider.dart';
import 'package:e_shop/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

const colorizeColors = [
  Palette.col,
  Colors.purple,
  Colors.blue,
  Colors.yellow,
  Colors.red,
  Colors.amber,
];
const colorizeTextStyle = TextStyle(
  fontSize: 50.0,
  fontFamily: 'merienda',
);

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return StreamBuilder(
      stream: FirebaseAuthHelper.instance.getAuthChange,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ThemeSwitchingArea(
            child: Drawer(
              child: ListView(
                children: [
                  Container(
                    color: Palette.col,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 10, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ThemeSwitcher(builder: (context) {
                                bool isDarkMode =
                                    ThemeModelInheritedNotifier.of(context)
                                            .theme
                                            .brightness ==
                                        Brightness.light;
                                String themeName =
                                    isDarkMode ? 'dark' : 'light';
                                return DayNightSwitcherIcon(
                                  dayBackgroundColor: Palette.col,
                                  nightBackgroundColor: Palette.col,
                                  isDarkModeEnabled: isDarkMode,
                                  onStateChanged: (bool darkMode) async {
                                    var service = await ThemeService.instance
                                      ..save(darkMode ? 'light' : 'dark');
                                    var theme = service.getByName(themeName);

                                    // ignore: use_build_context_synchronously
                                    ThemeSwitcher.of(context).changeTheme(
                                        theme: theme, isReversed: darkMode);
                                  },
                                );
                              }),
                            ],
                          ),
                        ),
                        UserAccountsDrawerHeader(
                          accountName: Text(
                            appProvider.getUserInformation!.name,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'merienda'),
                          ),
                          accountEmail: Text(
                            appProvider.getUserInformation!.email,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'merienda'),
                          ),
                          decoration: const BoxDecoration(
                            color: Palette.col,
                          ),
                          currentAccountPicture: appProvider
                                      .getUserInformation!.image ==
                                  null
                              ? const CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.white,
                                  backgroundImage:
                                      AssetImage("assets/img/profile.png"),
                                )
                              : CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(
                                      appProvider.getUserInformation!.image!),
                                  radius: 60,
                                ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Routes.instance
                          .push(widget: const OrderScreen(), context: context);
                    },
                    leading: const Icon(
                      LineIcons.shoppingBag,
                      color: Palette.col,
                    ),
                    title: const CustomText(
                      text: "My Orders",
                      size: 15,
                      color: Palette.col,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Routes.instance
                          .push(widget: const Setting(), context: context);
                    },
                    leading: const Icon(
                      Icons.settings_outlined,
                      color: Palette.col,
                    ),
                    title: const CustomText(
                      text: "Setting",
                      size: 15,
                      color: Palette.col,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Routes.instance
                          .push(widget: const AboutUs(), context: context);
                    },
                    leading: const Icon(
                      Icons.info_outline,
                      color: Palette.col,
                    ),
                    title: const CustomText(
                      text: "About Us",
                      size: 15,
                      color: Palette.col,
                    ),
                  ),
                  ListTile(
                    onTap: () async {
                      FirebaseAuthHelper.instance.signOut();
                    },
                    leading: const Icon(
                      Icons.exit_to_app_sharp,
                      color: Palette.col,
                    ),
                    title: const CustomText(
                      text: "Logout",
                      size: 15,
                      color: Palette.col,
                    ),
                  ),
                ],
              ),
            ),
          );

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        }
        return ThemeSwitchingArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 10,
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText(
                      'E-Shop',
                      textStyle: colorizeTextStyle,
                      colors: colorizeColors,
                      speed: const Duration(seconds: 1),
                    ),
                  ],
                  isRepeatingAnimation: true,
                  onTap: () async {},
                ),
                const SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Palette.col,
                  ),
                  onPressed: () {
                    Routes.instance
                        .push(widget: const Login(), context: context);
                  },
                  child: const CustomText(
                      text: 'Login', color: Colors.white, size: 16),
                ),
                const SizedBox(
                  height: 130,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
