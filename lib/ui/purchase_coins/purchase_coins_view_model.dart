import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:score_square/models/product.dart';

class PurchaseCoinsViewModel extends GetxController {
  /// Consumables they can purchase.
  List<Product> consumables = [
    Product(coins: 10, cost: 10.0),
    Product(coins: 20, cost: 20.0),
    Product(coins: 30, cost: 30.0),
  ];

  /// Make purchase of product.
  void purchase({required Product product}) {
    debugPrint('Purchase ${product.coins}');
  }
}
