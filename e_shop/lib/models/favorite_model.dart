import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/models/product_model.dart';

class FavoriteModel {
  FavoriteModel({
    required this.products,
    required this.fDate,
    required this.fId,
  });

  final DateTime fDate;
  List<ProductModel> products;
  String fId;

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> productMap = json["products"];
    Timestamp timestamp = json["fDate"];
    DateTime fDate = timestamp.toDate();
    return FavoriteModel(
      fId: json["fId"],
      products: productMap.map((e) => ProductModel.fromJson(e)).toList(),
      fDate: fDate,
    );
  }

  // static Widget fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> doc) {}
}
