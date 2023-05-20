import 'package:animate_do/animate_do.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:e_shop/Controllers/firebase_firestore.dart';
import 'package:e_shop/Screens/home/category_details.dart';
import 'package:e_shop/Screens/home/detail_product.dart';
import 'package:e_shop/constants/colors.dart';
import 'package:e_shop/constants/route.dart';
import 'package:e_shop/models/category_model.dart';
import 'package:e_shop/models/product_model.dart';
import 'package:e_shop/provider/app_provider.dart';
import 'package:e_shop/widgets/card_in_all_product.dart';
import 'package:e_shop/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import '../../widgets/card_in_new_product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryModel> categoriesList = [];
  List<ProductModel> productModelList = [];

  bool isLoading = false;
  @override
  void initState() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserInfoFirebase();
    getCategoryList();
    super.initState();
  }

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    categoriesList = await FirebaseFirestoreMethod.instance.getCategories();
    productModelList = await FirebaseFirestoreMethod.instance.getProducts();

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

//////////////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'assets/img/2.jpg',
      'assets/img/6.jpg',
      'assets/img/5.jpg',
      'assets/img/4.jpeg',
      'assets/img/3.jpg',
      'assets/img/7.jpg',
      'assets/img/8.jpg',
    ];

    final List<Widget> imageSliders = imgList
        .map((item) => Container(
              margin: const EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  child: Stack(
                    children: <Widget>[
                      Image.asset(
                        item,
                        fit: BoxFit.cover,
                        width: 1000,
                        height: 1000,
                      ),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 20.0),
                        ),
                      ),
                    ],
                  )),
            ))
        .toList();
//////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///
    return ThemeSwitchingArea(
      child: Scaffold(
        body: isLoading
            ? Center(
                child: Container(
                  height: 100,
                  width: 100,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Palette.col),
                  ),
                ),
              )
            : ListView(
                children: [
                  Column(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          aspectRatio: 1.5,
                          viewportFraction: 0.9,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          autoPlay: true,
                        ),
                        items: imageSliders,
                      ),

//////////////////////////////////////////////////////////////////////////////////////////////////////////
                      const Padding(
                        padding: EdgeInsets.only(top: 10, left: 18, bottom: 8),
                        child: SizedBox(
                          height: 22,
                          width: double.infinity,
                          child: CustomText(
                            text: "Categories",
                            color: Palette.col,
                            size: 16,
                          ),
                        ),
                      ),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: categoriesList
                              .map(
                                (e) => Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      Routes.instance.push(
                                          widget:
                                              CategoryDetails(categoryModel: e),
                                          context: context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 4,
                                                    color: Colors.grey,
                                                    spreadRadius: 4)
                                              ],
                                            ),
                                            child: CircleAvatar(
                                              radius: 40,
                                              backgroundImage:

                                                  // AssetImage(e.image),
                                                  NetworkImage(
                                                e.image,
                                              ),
                                              backgroundColor: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            e.name,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'merienda',
                                                color: Palette.col),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
//////////////////////////////////////////////////////////////////////////////////////////////////////////

                      const Padding(
                        padding: EdgeInsets.only(top: 10, left: 18, bottom: 8),
                        child: SizedBox(
                          height: 18,
                          width: double.infinity,
                          child: CustomText(
                            text: "New Products",
                            color: Palette.col,
                            size: 16,
                          ),
                        ),
                      ),

                      FadeInUp(
                        delay: const Duration(milliseconds: 250),
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          width: double.infinity,
                          height: 265,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              ProductModel singleProduct =
                                  productModelList[index];
                              return GestureDetector(
                                  onTap: () {
                                    Routes.instance.push(
                                        widget: Details(
                                          singleProduct: singleProduct,
                                        ),
                                        context: context);
                                  },
                                  child: card(productModelList[index]));
                            },
                          ),
                        ),
                      ),
//////////////////////////////////////////////////////////////////////////////////////////////////////////

                      const Padding(
                        padding: EdgeInsets.only(top: 10, left: 18, bottom: 8),
                        child: SizedBox(
                          height: 18,
                          width: double.infinity,
                          child: CustomText(
                            text: "All Products",
                            color: Palette.col,
                            size: 16,
                          ),
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: double.infinity,
                        child: SingleChildScrollView(
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: productModelList.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.70,
                            ),
                            itemBuilder: (context, index) {
                              ProductModel singleProduct =
                                  productModelList[index];
                              return GestureDetector(
                                  onTap: () {
                                    Routes.instance.push(
                                      widget:
                                          Details(singleProduct: singleProduct),
                                      context: context,
                                    );
                                  },
                                  child: cardAll(
                                      productModelList[index], context));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
