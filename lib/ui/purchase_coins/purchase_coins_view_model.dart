import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:score_square/constants/globals.dart';
import 'package:score_square/models/user_model.dart';
import 'package:score_square/services/auth_service.dart';
import 'package:score_square/services/user_service.dart';

import '../../service_locator.dart';

class PurchaseCoinsViewModel extends GetxController {
  /// Stream for listening to purchases.
  StreamSubscription<dynamic>? _subscription;

  /// Consumables they can purchase.
  List<ProductDetails> products = [];

  /// In-App Purchase instance.
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;

  /// Determine if in-app purchases are available.
  bool inAppPurchasesIsAvailable = false;

  /// The user about to make the purchase.
  late UserModel _user;

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

    /// Query for the products.
    final ProductDetailsResponse response =
        await _inAppPurchase.queryProductDetails(inAppPurchaseProductIds);

    /// If no products found, handle error here.
    if (response.notFoundIDs.isNotEmpty) {
      // Handle the error.
    }

    /// Set the product details from the query.
    products = response.productDetails;

    /// Sort products by price.
    products.sort((a, b) => a.rawPrice.compareTo(b.rawPrice));

    /// Fetch current user.
    _user = await locator<AuthService>().getCurrentUser();

    update();
  }

  /// Make purchase of product.
  void purchaseProduct({required ProductDetails product}) async {
    try {
      /// Create purchase param from product.
      final PurchaseParam purchaseParam =
          PurchaseParam(productDetails: product);

      /// Proceed to buy product.
      await InAppPurchase.instance.buyConsumable(purchaseParam: purchaseParam);

      /// From here the purchase flow will be handled by the underlying store.
      /// Updates will be delivered to the `InAppPurchase.instance.purchaseStream`.
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  //TODO: Complete verify purchase method.
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
    for (PurchaseDetails purchaseDetails in purchaseDetailsList) {
      await _handlePurchase(purchaseDetails);
    }

    update();
  }

  Future<void> _handlePurchase(PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.status == PurchaseStatus.purchased) {
      // TODO: Send to server
      // var validPurchase = await _verifyPurchase(purchaseDetails);
      bool validPurchase = true;

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
      /// Complete the purchase.
      await _inAppPurchase.completePurchase(purchaseDetails);

      /// Add coins to users account.
      switch (purchaseDetails.productID) {
        case 'FIVE_COINS':
          await locator<UserService>().updateUser(
            uid: _user.uid!,
            data: {
              'coins': FieldValue.increment(5),
            },
          );
          break;
        case 'TEN_COINS':
          await locator<UserService>().updateUser(
            uid: _user.uid!,
            data: {
              'coins': FieldValue.increment(10),
            },
          );
          break;
        case 'FIFTEEN_COINS':
          await locator<UserService>().updateUser(
            uid: _user.uid!,
            data: {
              'coins': FieldValue.increment(15),
            },
          );
          break;
        default:
          break;
      }
    }

    return;
  }
}
