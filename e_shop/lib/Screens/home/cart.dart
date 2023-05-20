import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:e_shop/Controllers/firebase_auth.dart';
import 'package:e_shop/Screens/auth_screen/login.dart';
import 'package:e_shop/Screens/check-out/get_information.dart';
import 'package:e_shop/constants/colors.dart';
import 'package:e_shop/constants/constants.dart';
import 'package:e_shop/constants/route.dart';
import 'package:e_shop/provider/app_provider.dart';
import 'package:e_shop/widgets/custom_text.dart';
import 'package:e_shop/widgets/single_cart_item.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return ThemeSwitchingArea(
      child: isLoading
          ? Center(
              child: Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Palette.col),
                ),
              ),
            )
          : StreamBuilder(
              stream: FirebaseAuthHelper.instance.getAuthChange,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Scaffold(
                      body: SizedBox(
                        height: 610,
                        child: SizedBox(
                          width: 400,
                          child: appProvider.getCartProductList.isEmpty
                              ? Column(
                                  children: [
                                    const SizedBox(
                                      height: 150,
                                    ),
                                    FadeInUp(
                                      delay: const Duration(milliseconds: 200),
                                      child: const Image(
                                        image: AssetImage(
                                            "assets/img/cart.png"),
                                        fit: BoxFit.cover,
                                        height: 200,
                                      ),
                                    ),
                                  ],
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(bottom: 130),
                                  child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      itemCount:
                                          appProvider.getCartProductList.length,
                                      itemBuilder: (context, index) {
                                        return SingleCartItem(
                                          singleProduct: appProvider
                                              .getCartProductList[index],
                                        );
                                      }),
                                ),
                        ),
                      ),
                      floatingActionButtonLocation:
                          FloatingActionButtonLocation.centerFloat,
                      floatingActionButton: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 8),
                        width: 400,
                        height: 155,
                        child: Column(
                          children: [
                            FadeInUp(
                                delay: const Duration(milliseconds: 500),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const CustomText(
                                      text: 'Total',
                                      color: Palette.col,
                                      size: 20,
                                    ),
                                    CustomText(
                                      text:
                                          "\$${appProvider.totalPrice().toString()}",
                                      color: Palette.col,
                                      size: 20,
                                    ),
                                  ],
                                )),
                            const Divider(),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: FadeInUp(
                                delay: const Duration(milliseconds: 550),
                                child: Container(
                                  height: 40,
                                  width: 100,
                                  decoration: const BoxDecoration(
                                    color: Palette.col,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                  child: MaterialButton(
                                    onPressed: () {
                                      appProvider.clearBuyProduct();
                                      appProvider.addBuyProductCartList();
                                      appProvider.clearCart();
                                      if (appProvider
                                          .getBuyProductList.isEmpty) {
                                        errorMessage("Cart is empty");
                                      } else {
                                        Routes.instance.push(
                                            widget: const GetInformation(),
                                            context: context);
                                      }
                                    },
                                    child: const Text(
                                      "Checkout",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontFamily: 'merienda'),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ));
                }

                return Scaffold(
                  body: Center(
                    child: ElevatedButton(
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
                  ),
                );
              },
            ),
    );
  }
}
