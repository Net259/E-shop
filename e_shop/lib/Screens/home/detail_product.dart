import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:e_shop/Controllers/firebase_auth.dart';
import 'package:e_shop/Controllers/firebase_firestore.dart';
import 'package:e_shop/Screens/check-out/get_information_1.dart';
import 'package:e_shop/constants/colors.dart';
import 'package:e_shop/constants/constants.dart';
import 'package:e_shop/constants/route.dart';
import 'package:e_shop/models/product_model.dart';
import 'package:e_shop/provider/app_provider.dart';
import 'package:e_shop/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  final ProductModel singleProduct;
  const Details({super.key, required this.singleProduct});
  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int qty = 1;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return SafeArea(
      child: ThemeSwitchingArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Palette.col,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Image
                  SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: Stack(
                      children: [
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      NetworkImage(widget.singleProduct.image),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                             StreamBuilder(
              stream: FirebaseAuthHelper.instance.getAuthChange,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                          return  Positioned(
                              right: 20,
                              bottom: 10,
                              child: IconButton(
                                onPressed: () async {
                                  setState(() {
                                    widget.singleProduct.isFavourite =
                                        !widget.singleProduct.isFavourite;
                                  });

                                  if (widget.singleProduct.isFavourite) {
                                  await FirebaseFirestoreMethod.instance
                                        .uploadFavoriteProduct(
                                      [widget.singleProduct],
                                      context,
                                      
                                    );
                                    successMessage("Added to wish list");
                                 
                                  }
                                },
                                icon: Icon(
                                  widget.singleProduct.isFavourite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: const Color.fromRGBO(183, 28, 28, 1.0),
                                  size: 40,
                                ),
                              ),
                            );
                            } return Positioned(
                              right: 20,
                              bottom: 10,
                              child: IconButton(
                                onPressed: ()  {
                                  successMessage(
                              "If you want to add to wish list a product, you must first login");
                                },
                                icon: Icon(
                                  widget.singleProduct.isFavourite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: const Color.fromRGBO(183, 28, 28, 1.0),
                                  size: 40,
                                ),
                              ),
                            );


              } ,
              )

                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: widget.singleProduct.name,
                                color: Palette.col,
                                size: 20,
                              ),
                              CustomText(
                                text:
                                    "\$${widget.singleProduct.price.toString()}",
                                color: Palette.col,
                                size: 20,
                              ),
                            ],
                          ),
                          widget.singleProduct.prevprice.isNotEmpty
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: Text(
                                        "\$${widget.singleProduct.prevprice.toString()}",
                                        style: const TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            decorationThickness: 2,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.red,
                                            fontFamily: 'merienda'),
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      widget.singleProduct.description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Merienda',
                          fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoButton(
                onPressed: () {
                  if (qty >= 1) {
                    setState(() {
                      qty--;
                    });
                  }
                },
                padding: EdgeInsets.zero,
                child: const CircleAvatar(
                  backgroundColor: Palette.col,
                  child: Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                qty.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              CupertinoButton(
                onPressed: () {
                  setState(() {
                    qty++;
                  });
                },
                padding: EdgeInsets.zero,
                child: const CircleAvatar(
                  backgroundColor: Palette.col,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          bottomNavigationBar: BottomAppBar(
            child: StreamBuilder(
              stream: FirebaseAuthHelper.instance.getAuthChange,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SizedBox(
                    height: 60.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            ProductModel productModel =
                                widget.singleProduct.copyWith(qty: qty);
                            appProvider.addCartProduct(productModel);
                            successMessage("Added to Cart");
                          },
                          label: const Text(
                            "Add to Cart",
                            style: TextStyle(
                              color: Palette.col,
                              fontSize: 15,
                              fontFamily: 'merienda',
                            ),
                          ),
                          icon: const Icon(
                            LineIcons.addToShoppingCart,
                            color: Palette.col,
                            size: 30,
                          ),
                        ),
                        const VerticalDivider(),
                        TextButton.icon(
                          onPressed: () {
                            ProductModel productModel =
                                widget.singleProduct.copyWith(qty: qty);

                            Routes.instance.push(
                                widget: GetInformationOneProduct(
                                    singleProduct: productModel),
                                context: context);
                          },
                          label: const Text(
                            "Buy Now",
                            style: TextStyle(
                              color: Palette.col,
                              fontSize: 15,
                              fontFamily: 'merienda',
                            ),
                          ),
                          icon: const Icon(
                            LineIcons.buysellads,
                            color: Palette.col,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return SizedBox(
                  height: 60.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          successMessage(
                              "If you want to add to cart a product, you must first login");
                        },
                        label: const Text(
                          "Add to Cart",
                          style: TextStyle(
                            color: Palette.col,
                            fontSize: 15,
                            fontFamily: 'merienda',
                          ),
                        ),
                        icon: const Icon(
                          LineIcons.addToShoppingCart,
                          color: Palette.col,
                          size: 30,
                        ),
                      ),
                      const VerticalDivider(),
                      TextButton.icon(
                        onPressed: () {
                          successMessage(
                              "If you want to buy a product, you must first login");
                        },
                        label: const Text(
                          "Buy Now",
                          style: TextStyle(
                            color: Palette.col,
                            fontSize: 15,
                            fontFamily: 'merienda',
                          ),
                        ),
                        icon: const Icon(
                          LineIcons.buysellads,
                          color: Palette.col,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
