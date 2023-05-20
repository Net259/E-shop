import 'package:e_shop/constants/colors.dart';
import 'package:e_shop/constants/constants.dart';
import 'package:e_shop/models/product_model.dart';
import 'package:e_shop/provider/app_provider.dart';
import 'package:e_shop/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleCartItem extends StatefulWidget {
  final ProductModel singleProduct;
  const SingleCartItem({super.key, required this.singleProduct});

  @override
  State<SingleCartItem> createState() => _SingleCartItemState();
}

class _SingleCartItemState extends State<SingleCartItem> {
  int qty = 1;
  @override
  void initState() {
    qty = widget.singleProduct.qty ?? 1;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          5,
        ),
        border: Border.all(color: Palette.col, width: 2),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 140,
              color: Palette.col.withOpacity(0.5),
              child: Image.network(
                widget.singleProduct.image,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 140,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FittedBox(
                              child: CustomText(
                                text: widget.singleProduct.name,
                                color: Palette.col,
                                size: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                CupertinoButton(
                                  onPressed: () {
                                    if (qty > 1) {
                                      setState(() {
                                        qty--;
                                      });
                                      appProvider.updateQty(
                                          widget.singleProduct, qty);
                                    }
                                  },
                                  padding: EdgeInsets.zero,
                                  child: const CircleAvatar(
                                    backgroundColor: Palette.col,
                                    maxRadius: 13,
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                CustomText(
                                  text: qty.toString(),
                                  color: Palette.col,
                                  size: 18,
                                ),
                                CupertinoButton(
                                  onPressed: () {
                                    setState(() {
                                      qty++;
                                    });
                                    appProvider.updateQty(
                                        widget.singleProduct, qty);
                                  },
                                  padding: EdgeInsets.zero,
                                  child: const CircleAvatar(
                                    backgroundColor: Palette.col,
                                    maxRadius: 13,
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        CustomText(
                          text: "\$${widget.singleProduct.price.toString()}",
                          color: Palette.col,
                          size: 12,
                        ),
                      ],
                    ),
                    CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          appProvider.removeCartProduct(widget.singleProduct);
                          errorMessage("Removed from Cart");
                        },
                        child: const Icon(
                          Icons.close,
                          size: 25,
                          color: Colors.grey,
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
