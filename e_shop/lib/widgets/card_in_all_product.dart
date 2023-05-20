import 'package:e_shop/constants/colors.dart';
import 'package:e_shop/constants/constants.dart';
import 'package:e_shop/models/product_model.dart';
import 'package:e_shop/provider/app_provider.dart';
import 'package:e_shop/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

Widget cardAll(ProductModel data, context) {
  AppProvider appProvider = Provider.of<AppProvider>(
    context,
  );
  int qty = 1;
  return Column(
    children: [
      Stack(
        children: [
          Container(
            width: 200,
            height: 200,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                image: NetworkImage(data.image),
                fit: BoxFit.cover,
              ),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 4,
                  color: Color.fromARGB(70, 0, 0, 0),
                )
              ],
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: CircleAvatar(
              backgroundColor: Palette.col,
              child: IconButton(
                onPressed: () {
                  ProductModel productModel = data.copyWith(qty: qty);
                  appProvider.addCartProduct(productModel);
                  successMessage("Added to Cart");
                },
                icon: const Icon(
                  LineIcons.addToShoppingCart,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Text(
          data.name,
          style: const TextStyle(
              fontSize: 12, fontFamily: 'merienda', color: Palette.col),
        ),
      ),
      data.prevprice.isNotEmpty
          ? SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${data.prevprice.toString()}",
                    style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        decorationThickness: 2,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                        fontFamily: 'merienda'),
                  ),
                  CustomText(
                    text: "\$${data.price.toString()}",
                    color: Palette.col,
                    size: 12,
                  )
                ],
              ),
            )
          : CustomText(
              text: "\$${data.price.toString()}",
              color: Palette.col,
              size: 12,
            )
    ],
  );
}
