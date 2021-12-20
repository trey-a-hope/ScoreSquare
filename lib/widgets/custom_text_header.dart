import 'package:flutter/material.dart';

class CustomTextHeader extends StatelessWidget {
  final String text;

  const CustomTextHeader({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        'Create Game',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 21,
        ),
      ),
    );
  }
}
