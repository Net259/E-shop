import 'package:e_shop/constants/colors.dart';
import 'package:e_shop/models/product_model.dart';
import 'package:e_shop/widgets/custom_text.dart';
import 'package:flutter/material.dart';

Widget card(ProductModel data) {
  return Padding(
    padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
    child: Column(
      children: [
        Container(
          width: 200,
          height: 210,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(
              image: NetworkImage(data.image),
              fit: BoxFit.fitHeight,
            ),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 10,
                color: Color.fromARGB(70, 0, 0, 0),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: CustomText(
            text: data.name,
            size: 12,
            color: Palette.col,
          ),
        ),
        data.prevprice.isNotEmpty
            ? SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${data.prevprice}",
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
    ),
  );
}
