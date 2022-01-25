import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ErrorView extends StatelessWidget {
  final String error;

  const ErrorView({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            MdiIcons.emoticonSad,
            color: Colors.grey,
            size: 200,
          ),
          Text(
            'Error: $error\n\nPlease restart app and try again.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
