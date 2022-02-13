import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:score_square/constants/app_themes.dart';
import 'package:score_square/ui/settings/settings_view_model.dart';
import 'package:score_square/widgets/basic_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsViewModel>(
      init: SettingsViewModel(),
      builder: (context) => BasicPage(
        title: 'Settings',
        leftIconButton: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Get.back();
          },
        ),
        child: ListView(
          children: [
            ListTile(
              onTap: () {
                Get.toNamed('/purchase_coins');
              },
              leading: const Icon(Icons.attach_money),
              subtitle: const Text('Exchange cash for coins.'),
              title: Text(
                'Purchase Coins',
                style: AppThemes.textTheme.headline4,
              ),
              trailing: const Icon(Icons.chevron_right),
            ),
          ],
        ),
      ),
    );
  }
}
