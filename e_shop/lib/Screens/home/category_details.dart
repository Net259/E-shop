import 'package:animate_do/animate_do.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:e_shop/Controllers/firebase_firestore.dart';
import 'package:e_shop/Screens/home/detail_product.dart';
import 'package:e_shop/constants/colors.dart';
import 'package:e_shop/constants/route.dart';
import 'package:e_shop/models/category_model.dart';
import 'package:e_shop/models/product_model.dart';
import 'package:e_shop/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CategoryDetails extends StatefulWidget {
  final CategoryModel categoryModel;
  const CategoryDetails({
    Key? key,
    required this.categoryModel,
  }) : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  List<ProductModel> productModelList = [];

  bool isLoading = false;
  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    productModelList = await FirebaseFirestoreMethod.instance
        .getCategoryViewProduct(widget.categoryModel.id);
    productModelList.shuffle();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getCategoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
          appBar: AppBar(
            title: CustomText(
              text: widget.categoryModel.name,
              color: Colors.white,
              size: 16,
            ),
            backgroundColor: Palette.col,
          ),
          body: productModelList.isEmpty
              ? Center(
                  child: FadeInUp(
                    delay: const Duration(milliseconds: 200),
                    child: const Image(
                      image: AssetImage("assets/img/empty_order2.png"),
                      fit: BoxFit.cover,
                      height: 200,
                    ),
                  ),
                )
              : Column(
                  children: [
                    FadeInUp(
                      delay: const Duration(milliseconds: 450),
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: double.infinity,
                        height: 530,
                        child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: productModelList.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 0.70,
                            ),
                            itemBuilder: (context, index) {
                              ProductModel singleProduct =
                                  productModelList[index];
                              return GestureDetector(
                                onTap: (() => Routes.instance.push(
                                    widget:
                                        Details(singleProduct: singleProduct),
                                    context: context)),
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          width: 200,
                                          height: 120,
                                          margin: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  singleProduct.image),
                                              fit: BoxFit.cover,
                                            ),
                                            boxShadow: const [
                                              BoxShadow(
                                                offset: Offset(0, 4),
                                                blurRadius: 4,
                                                color:
                                                    Color.fromARGB(70, 0, 0, 0),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Text(
                                        singleProduct.name,
                                        style: const TextStyle(
                                            fontSize: 10,
                                            fontFamily: 'merienda',
                                            color: Palette.col),
                                      ),
                                    ),
                                    RichText(
                                        text: TextSpan(
                                            text: "\$",
                                            style: const TextStyle(
                                              color: Palette.col,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            children: [
                                          TextSpan(
                                            text:
                                                singleProduct.price.toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                                fontFamily: 'merienda',
                                                color: Palette.col),
                                          )
                                        ])),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                )),
    );
  }
}
