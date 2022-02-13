import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:score_square/ui/main/main_view_model.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainViewModel>(
      init: MainViewModel(),
      builder: (controller) => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
