import 'package:animate_do/animate_do.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/constants/colors.dart';
import 'package:e_shop/models/order_model.dart';
import 'package:e_shop/widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Palette.col,
          title: const CustomText(
            text: "My Orders",
            color: Colors.white,
            size: 16,
          ),
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: orderStream(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
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
              }

              List<OrderModel> orderList = snapshot.data!.docs
                  .map((element) => OrderModel.fromJson(element.data()))
                  .toList();

              return orderList.isNotEmpty
                  ? ListView.builder(
                      itemCount: orderList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final order = orderList[index];
                        DateTime getdate = order.orderDate;

                        String date =
                            "${getdate.day}-${getdate.month}-${getdate.year}/${getdate.hour}:${getdate.minute}";

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15, left: 10),
                              child: CustomText(
                                text: date,
                                color: Palette.col,
                                size: 14,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 3, left: 10, right: 10),
                              child: ExpansionTile(
                                iconColor: Palette.col,
                                tilePadding: EdgeInsets.zero,
                                collapsedShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: const BorderSide(
                                        color: Palette.col, width: 2)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: const BorderSide(
                                        color: Palette.col, width: 2)),
                                title: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Container(
                                      height: 120,
                                      width: 120,
                                      color: Palette.col.withOpacity(0.5),
                                      child: Image.network(
                                        order.products[0].image,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            text: order.products[0].name,
                                            color: Palette.col,
                                            size: 12,
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          order.products.length > 1
                                              ? SizedBox.fromSize()
                                              : Column(
                                                  children: [
                                                    CustomText(
                                                      text:
                                                          "Quanity: ${order.products[0].qty.toString()}",
                                                      color: Palette.col,
                                                      size: 12,
                                                    ),
                                                    const SizedBox(
                                                      height: 12.0,
                                                    ),
                                                  ],
                                                ),
                                          CustomText(
                                            text:
                                                "Total Price: \$${order.totalPrice.toString()}",
                                            color: Palette.col,
                                            size: 12,
                                          ),
                                          const SizedBox(
                                            height: 12.0,
                                          ),
                                          CustomText(
                                            text:
                                                "Order Status: ${order.status}",
                                            color: Palette.col,
                                            size: 12,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                children: order.products.length > 1
                                    ? [
                                        const CustomText(
                                          text: "Details",
                                          color: Palette.col,
                                          size: 14,
                                        ),
                                        const Divider(color: Palette.col),
                                        ...order.products.map((singleProduct) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12, top: 6),
                                            child: Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .baseline,
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                  children: [
                                                    Container(
                                                      height: 80,
                                                      width: 80,
                                                      color: Palette.col
                                                          .withOpacity(0.5),
                                                      child: Image.network(
                                                        singleProduct.image,
                                                        fit: BoxFit.fitHeight,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          CustomText(
                                                            text: singleProduct
                                                                .name,
                                                            color: Palette.col,
                                                            size: 12,
                                                          ),
                                                          const SizedBox(
                                                            height: 12.0,
                                                          ),
                                                          Column(
                                                            children: [
                                                              CustomText(
                                                                text:
                                                                    "Quanity: ${singleProduct.qty.toString()}",
                                                                color:
                                                                    Palette.col,
                                                                size: 12,
                                                              ),
                                                              const SizedBox(
                                                                height: 12.0,
                                                              ),
                                                            ],
                                                          ),
                                                          CustomText(
                                                            text:
                                                                "Price: \$${singleProduct.price.toString()}",
                                                            color: Palette.col,
                                                            size: 12,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const Divider(
                                                    color: Palette.col),
                                              ],
                                            ),
                                          );
                                        }).toList()
                                      ]
                                    : [],
                              ),
                            ),
                          ],
                        );
                      },
                    )
                  : Center(
                      child: FadeInUp(
                        delay: const Duration(milliseconds: 200),
                        child: const Image(
                          image: AssetImage("assets/img/empty_order2.png"),
                          fit: BoxFit.cover,
                          height: 200,
                        ),
                      ),
                    );
            }),
      ),
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> orderStream() {
    return FirebaseFirestore.instance
        .collection("usersOrders")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("orders")
        .orderBy("orderDate", descending: true)
        .snapshots();
  }
}
