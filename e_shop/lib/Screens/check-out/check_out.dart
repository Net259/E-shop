import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:e_shop/Controllers/firebase_firestore.dart';
import 'package:e_shop/constants/colors.dart';
import 'package:e_shop/models/product_model.dart';
import 'package:e_shop/provider/app_provider.dart';
import 'package:e_shop/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class Checkout extends StatefulWidget {
  final ProductModel singleProduct;
  const Checkout({super.key, required this.singleProduct});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
  }

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
              text: 'Checkout',
              color: Colors.white,
              size: 16,
            )),
        body: Padding(
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
                          groupValue = 1;
                        });
                      },
                    ),
                    const Icon(LineIcons.wavyMoneyBill),
                    const SizedBox(
                      width: 12.0,
                    ),
                    const Text(
                      "Cash on Delivery",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              Container(
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Palette.col, width: 2)),
                width: double.infinity,
                child: Row(
                  children: [
                    Radio(value: 2, groupValue: groupValue, onChanged: null),
                    const Icon(LineIcons.wavyMoneyBill),
                    const SizedBox(
                      width: 12.0,
                    ),
                    const Text(
                      "FastPay",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24.0,
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
                    appProvider.clearBuyProduct();
                    appProvider.addBuyProduct(widget.singleProduct);

                    if (groupValue == 1) {
                      await FirebaseFirestoreMethod.instance
                          .uploadOrderedProductFirebase(
                              appProvider.getBuyProductList,
                              context,
                              "Cash on delivery");
                    } else {}
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
