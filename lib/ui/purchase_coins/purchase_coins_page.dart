import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:score_square/models/product.dart';
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
        child: ListView.builder(
          itemCount: model.consumables.length,
          itemBuilder: (context, index) {
            Product product = model.consumables[index];
            return ListTile(
              title: Text(
                '${product.coins} coins',
              ),
              trailing: ElevatedButton(
                child: Text('${product.cost}'),
                onPressed: () async {
                  // bool? confirm =
                  //     await locator<ModalService>().showConfirmation(
                  //   context: context,
                  //   title: 'Purchase ${product.coins} coins',
                  //   message: 'Are you sure?',
                  // );
                  //
                  // if (confirm == null || confirm == false) {
                  //   return;
                  // }

                  model.purchase(product: product);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
