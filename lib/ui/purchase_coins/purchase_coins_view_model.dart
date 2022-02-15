import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class PurchaseCoinsViewModel extends GetxController {
  /// Stream for listening to purchases.
  StreamSubscription<dynamic>? _subscription;

  /// Consumables they can purchase.
  List<ProductDetails> products = [];

  /// In-App Purchase instance.
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;

  /// Determine if in-app purchases are available.
  bool inAppPurchasesIsAvailable = false;

  @override
  void onInit() async {
    /// Determine if in app purchases are available.
    _load();

    super.onInit();
  }

  void _load() async {
    final Stream purchaseUpdated = _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription!.cancel();
    }, onError: (error) {
      // handle error here.
    });

    /// Determine if in app purchases are available.
    inAppPurchasesIsAvailable = await _inAppPurchase.isAvailable();

    /// Load products for sale via their products Ids.
    const Set<String> _kIds = <String>{
      'FIVE_COINS',
      'TEN_COINS',
      'FIFTEEN_COINS'
    };

    /// Query for the products.
    final ProductDetailsResponse response =
        await _inAppPurchase.queryProductDetails(_kIds);

    /// If no products found, handle error here.
    if (response.notFoundIDs.isNotEmpty) {
      // Handle the error.
    }

    /// Set the product details from the query.
    products = response.productDetails;

    /// Sort products by price.
    products.sort((a, b) => a.rawPrice.compareTo(b.rawPrice));

    update();
  }

  /// Make purchase of product.
  void purchase({required ProductDetails product}) async {
    try {
      /// Create purchase param from product.
      final PurchaseParam purchaseParam =
          PurchaseParam(productDetails: product);

      /// Proceed to buy product.
      await InAppPurchase.instance.buyConsumable(purchaseParam: purchaseParam);
    } catch (error) {
      debugPrint(error.toString());
    }

// From here the purchase flow will be handled by the underlying store.
// Updates will be delivered to the `InAppPurchase.instance.purchaseStream`.
  }

  // Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) async {
  //   var functions = await firebaseNotifier.functions;
  //   final callable = functions.httpsCallable('verifyPurchase');
  //   final results = await callable({
  //     'source': purchaseDetails.verificationData.source,
  //     'verificationData':
  //         purchaseDetails.verificationData.serverVerificationData,
  //     'productId': purchaseDetails.productID,
  //   });
  //   return results.data as bool;
  // }

  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (var purchaseDetails in purchaseDetailsList) {
      await _handlePurchase(purchaseDetails);
    }
    // notifyListeners();
    update();
  }

  Future<void> _handlePurchase(PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.status == PurchaseStatus.purchased) {
      // TODO: Send to server
      // var validPurchase = await _verifyPurchase(purchaseDetails);
      var validPurchase = true;

      if (validPurchase) {
        // Apply changes locally
        // switch (purchaseDetails.productID) {
        //   case storeKeySubscription:
        //     counter.applyPaidMultiplier();
        //     break;
        //   case storeKeyConsumable:
        //     counter.addBoughtDashes(1000);
        //     break;
        // }
      }
    }

    if (purchaseDetails.pendingCompletePurchase) {
      await _inAppPurchase.completePurchase(purchaseDetails);
    }
  }
}
