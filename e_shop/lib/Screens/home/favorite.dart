import 'package:animate_do/animate_do.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Controllers/firebase_auth.dart';
import 'package:e_shop/Controllers/firebase_firestore.dart';
import 'package:e_shop/Screens/auth_screen/login.dart';
import 'package:e_shop/Screens/home/detail_product.dart';
import 'package:e_shop/constants/colors.dart';
import 'package:e_shop/constants/constants.dart';
import 'package:e_shop/constants/route.dart';
import 'package:e_shop/models/favorite_model.dart';
import 'package:e_shop/models/product_model.dart';
import 'package:e_shop/widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  Stream<QuerySnapshot<Map<String, dynamic>>> fStream() {
    return FirebaseFirestore.instance
        .collection("usersWishList")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("WishList")
        .orderBy("fDate", descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
        child: StreamBuilder(
      stream: FirebaseAuthHelper.instance.getAuthChange,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: fStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<FavoriteModel> favorites =
                        snapshot.data!.docs.map((doc) {
                      Map<String, dynamic> data = doc.data();
                      Timestamp timestamp = data["fDate"];
                      DateTime fDate = timestamp.toDate();
                      String fId = doc.id;
                      List<dynamic> productMap = data["products"];
                      List<ProductModel> products = productMap
                          .map((productData) =>
                              ProductModel.fromJson(productData))
                          .toList();

                      return FavoriteModel(
                        fId: fId,
                        products: products,
                        fDate: fDate,
                      );
                    }).toList();

                    return favorites.isNotEmpty
                        ? ListView.builder(
                            itemCount: favorites.length,
                            itemBuilder: (BuildContext context, int index) {
                              final favorite = favorites[index];

                              return Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: ListTile(
                                  // title: Text("Favorite ID: ${favorite.fId}"),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: favorite.products
                                        .map((product) => Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 5),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  5,
                                                ),
                                                border: Border.all(
                                                    color: Palette.col,
                                                    width: 2),
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      height: 140,
                                                      color: Palette.col
                                                          .withOpacity(0.5),
                                                      child: Image.network(
                                                        product.image,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: SizedBox(
                                                      height: 140,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12),
                                                        child: Stack(
                                                          alignment: Alignment
                                                              .bottomRight,
                                                          children: [
                                                            Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    CustomText(
                                                                      text: product
                                                                          .name,
                                                                      color: Palette
                                                                          .col,
                                                                      size: 12,
                                                                    ),
                                                                    CupertinoButton(
                                                                        padding:
                                                                            EdgeInsets
                                                                                .zero,
                                                                        onPressed:
                                                                            () {
                                                                          Routes.instance.push(
                                                                              widget: Details(
                                                                                singleProduct: product,
                                                                              ),
                                                                              context: context);
                                                                        },
                                                                        child: const CustomText(
                                                                            text:
                                                                                "Details",
                                                                            color:
                                                                                Palette.col,
                                                                            size: 12)),
                                                                  ],
                                                                ),
                                                                Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    CustomText(
                                                                      text:
                                                                          "\$${product.price.toString()}",
                                                                      color: Palette
                                                                          .col,
                                                                      size: 12,
                                                                    ),
                                                                    CupertinoButton(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .zero,
                                                                      onPressed:
                                                                          () {
                                                                        showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (BuildContext context) {
                                                                            return AlertDialog(
                                                                              title: const CustomText(
                                                                                text: 'Delete Product Wish List',
                                                                                color: Colors.red,
                                                                                size: 12,
                                                                              ),
                                                                              content: const CustomText(
                                                                                text: 'Are you sure you want to delete product wish list?',
                                                                                color: Colors.black,
                                                                                size: 12,
                                                                              ),
                                                                              actions: [
                                                                                TextButton(
                                                                                  child: const CustomText(
                                                                                    text: 'No',
                                                                                    color: Colors.black,
                                                                                    size: 12,
                                                                                  ),
                                                                                  onPressed: () {
                                                                                    Navigator.of(context).pop();
                                                                                  },
                                                                                ),
                                                                                TextButton(
                                                                                  child: const CustomText(
                                                                                    text: 'Yes',
                                                                                    color: Colors.red,
                                                                                    size: 12,
                                                                                  ),
                                                                                  onPressed: () async {
                                                                                    bool deleted = await FirebaseFirestoreMethod.instance.deleteFavoriteProduct(favorite.fId, context);
                                                                                    if (deleted) {
                                                                                      errorMessage("Removed to wishlist");
                                                                                      // ignore: use_build_context_synchronously
                                                                                      Navigator.of(context).pop();
                                                                                    }
                                                                                  },
                                                                                ),
                                                                              ],
                                                                            );
                                                                          },
                                                                        );
                                                                      },
                                                                      child:
                                                                          const Icon(
                                                                        Icons
                                                                            .close,
                                                                        size:
                                                                            25,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                ),
                              );
                            })
                        : Center(
                            child: FadeInUp(
                              delay: const Duration(milliseconds: 200),
                              child: const Image(
                                image: AssetImage("assets/img/empty_order.png"),
                                fit: BoxFit.cover,
                                height: 200,
                              ),
                            ),
                          );
                  }
                  return Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Palette.col),
                      ),
                    ),
                  );
                }),
          );
        }
        return Scaffold(
            body: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Palette.col,
            ),
            onPressed: () {
              Routes.instance.push(widget: const Login(), context: context);
            },
            child:
                const CustomText(text: 'Login', color: Colors.white, size: 16),
          ),
        ));
      },
    ));
  }
}
