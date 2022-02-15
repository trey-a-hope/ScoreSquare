import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:score_square/constants/globals.dart';
import 'package:score_square/services/modal_service.dart';
import 'package:score_square/ui/purchase_coins/purchase_coins_view_model.dart';
import 'package:score_square/widgets/basic_page.dart';

import '../../service_locator.dart';

class PurchaseCoinsPage extends StatelessWidget {
  const PurchaseCoinsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PurchaseCoinsViewModel>(
      init: PurchaseCoinsViewModel(),
      builder: (model) => BasicPage(
        title: 'Purchase Coins',
        leftIconButton: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Get.back();
          },
        ),
        child: model.inAppPurchasesIsAvailable
            ? Column(
                children: [
                  Image.asset(
                    blackManPhone,
                    height: Get.height * 0.4,
                  ),
                  const Center(
                    child: Text(
                      'Need to re-up on coins? You\'ve come to the right place!',
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: <Widget>[
                      for (ProductDetails product in model.products) ...[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Card(
                              elevation: 2.0,
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    product.title,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    product.description,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      bool? confirm =
                                          await locator<ModalService>()
                                              .showConfirmation(
                                        context: context,
                                        title: 'Purchase ${product.title}',
                                        message:
                                            '${product.price} will be charged to your card on file. This purchase is non-refundable.',
                                      );

                                      if (confirm == null || confirm == false) {
                                        return;
                                      }

                                      model.purchase(product: product);
                                    },
                                    child: Text(product.price),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ]
                    ],
                  ),
                ],
              )
            : const Center(
                child: Text('Sorry, in app purchases not available.'),
              ),
      ),
    );
  }
}
