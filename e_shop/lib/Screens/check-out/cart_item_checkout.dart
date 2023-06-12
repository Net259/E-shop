// ignore_for_file: use_build_context_synchronously

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:e_shop/Controllers/firebase_firestore.dart';
import 'package:e_shop/constants/colors.dart';
import 'package:e_shop/provider/app_provider.dart';
import 'package:e_shop/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class CartItemCheckout extends StatefulWidget {
  const CartItemCheckout({
    super.key,
  });

  @override
  State<CartItemCheckout> createState() => _CartItemCheckoutState();
}

class _CartItemCheckoutState extends State<CartItemCheckout> {
  int groupValue = 1;
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
              text: 'Cart Item Checkout',
              color: Colors.white,
              size: 16,
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                const SizedBox(
                  height: 36,
                ),
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Palette.col, width: 2)),
                  width: double.infinity,
                  child: Row(
                    children: [
                      Radio(
                        activeColor: Palette.col,
                        value: 1,
                        groupValue: groupValue,
                        onChanged: (value) {
                          setState(() {
                            groupValue = 2;
                          });
                        },
                      ),
                      const Icon(LineIcons.wavyMoneyBill),
                      const SizedBox(
                        width: 12,
                      ),
                      const Text(
                        "Cash on Delivery",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Palette.col, width: 2)),
                  width: double.infinity,
                  child: Row(
                    children: [
                      Radio(
                          activeColor: Palette.col,
                          value: 2,
                          groupValue: groupValue,
                          onChanged: null),
                      const Icon(LineIcons.wavyMoneyBill),
                      const SizedBox(
                        width: 12,
                      ),
                      const Text(
                        "FastPay For Future",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100,
                  width: double.infinity,
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Palette.col,
                  ),
                  width: double.infinity,
                  height: 40,
                  child: OutlinedButton(
                    child: const Text(
                      "Buy",
                      style: TextStyle(
                        fontFamily: 'merienda',
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      if (groupValue == 1) {
                        await FirebaseFirestoreMethod.instance
                            .uploadOrderedProductFirebase(
                                appProvider.getBuyProductList,
                                context,
                                "Cash on delivery");
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
