import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:score_square/ui/purchase_coins/purchase_coins_view_model.dart';
import 'package:score_square/widgets/basic_page.dart';

class PurchaseCoinsPage extends StatelessWidget {
  const PurchaseCoinsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PurchaseCoinsViewModel>(
      init: PurchaseCoinsViewModel(),
      builder: (context) => BasicPage(
        title: 'Purchase Coins',
        leftIconButton: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Get.back();
          },
        ),
        child: const Center(
          child: Text('Purchase Coins'),
        ),
      ),
    );
  }
}
