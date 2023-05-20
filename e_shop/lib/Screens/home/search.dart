import 'package:animate_do/animate_do.dart';
import 'package:e_shop/Controllers/firebase_firestore.dart';
import 'package:e_shop/Screens/home/detail_product.dart';
import 'package:e_shop/constants/colors.dart';
import 'package:e_shop/constants/constants.dart';
import 'package:e_shop/models/product_model.dart';
import 'package:e_shop/provider/app_provider.dart';
import 'package:e_shop/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<ProductModel> productModelList = [];

  @override
  void initState() {
    getCategoryList();
    super.initState();
  }

  void getCategoryList() async {
    productModelList = await FirebaseFirestoreMethod.instance.getProducts();
  }

  TextEditingController search = TextEditingController();
  List<ProductModel> searchList = [];
  void searchProducts(String value) {
    searchList = productModelList
        .where((element) =>
            element.name.toLowerCase().contains(value.toLowerCase()) ||
            element.price.toString().contains(value.toLowerCase()))
        .toList();

    setState(() {});
  }

  int qty = 1;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            // Search Box
            FadeInUp(
              delay: const Duration(milliseconds: 50),
              child: Padding(
                padding: const EdgeInsets.only(right: 15, left: 15, top: 10),
                child: SizedBox(
                  child: Center(
                    child: TextField(
                      controller: search,
                      onChanged: (String value) {
                        searchProducts(value);
                      },
                      style: const TextStyle(
                          fontSize: 10,
                          fontFamily: 'merienda',
                          color: Palette.col),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 20),
                        filled: true,
                        suffixIcon: IconButton(
                          onPressed: () {
                            search.clear();
                            FocusManager.instance.primaryFocus?.unfocus();
                            setState(() {
                              searchList = productModelList;
                            });
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Color(0xFF616161),
                          ),
                        ),
                        hintStyle: const TextStyle(
                          fontSize: 10,
                          fontFamily: 'merienda',
                        ),
                        labelText: "Search",
                        labelStyle: const TextStyle(color: Palette.col),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
//////////////////////////////////////////////////////////////////////////////////////////////////////////

            Expanded(
              child: searchList.isNotEmpty
                  ? GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: searchList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 0.63),
                      itemBuilder: (context, index) {
                        ProductModel singleProduct = searchList[index];
                        return FadeInUp(
                          delay: const Duration(milliseconds: 100),
                          child: GestureDetector(
                            onTap: (() => Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    return Details(
                                        singleProduct: singleProduct);
                                  }),
                                )),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned(
                                  top: 18,
                                  left: 1,
                                  right: 1,
                                  child: Container(
                                    width: 250,
                                    height: 200,
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          singleProduct.image,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          offset: Offset(0, 4),
                                          blurRadius: 4,
                                          color: Color.fromARGB(61, 0, 0, 0),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 40,
                                  child: CircleAvatar(
                                    backgroundColor: Palette.col,
                                    child: IconButton(
                                      onPressed: () {
                                        ProductModel productModel =
                                            singleProduct.copyWith(qty: qty);
                                        appProvider
                                            .addCartProduct(productModel);
                                        successMessage("Added to Cart");
                                      },
                                      icon: const Icon(
                                        LineIcons.addToShoppingCart,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  child: CustomText(
                                    text: singleProduct.name,
                                    size: 12,
                                    color: Palette.col,
                                  ),
                                ),
                                Positioned(
                                    bottom: 1,
                                    child: singleProduct.prevprice.isNotEmpty
                                        ? SizedBox(
                                            width: 100,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  singleProduct.prevprice,
                                                  style: const TextStyle(
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      decorationThickness: 2,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.red,
                                                      fontFamily: 'merienda'),
                                                ),
                                                CustomText(
                                                  text:
                                                      "\$${singleProduct.price.toString()}",
                                                  color: Palette.col,
                                                  size: 12,
                                                )
                                              ],
                                            ),
                                          )
                                        : CustomText(
                                            text:
                                                "\$${singleProduct.price.toString()}",
                                            color: Palette.col,
                                            size: 12,
                                          )),
                              ],
                            ),
                          ),
                        );
                      })
                  : Center(
                      child: FadeInUp(
                        delay: const Duration(milliseconds: 200),
                        child: const Image(
                          image: AssetImage("assets/img/search.png"),
                          fit: BoxFit.cover,
                          height: 200,
                        ),
                      ),
                    ),
            )

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
          ],
        ),
      ),
    );
  }
}
