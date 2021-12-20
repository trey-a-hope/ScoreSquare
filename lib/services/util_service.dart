import 'package:flutter/material.dart';

abstract class IUtilService {
  void heroToImage({
    required BuildContext context,
    required String imgUrl,
    required String tag,
  });
}

class UtilService extends IUtilService {
  @override
  void heroToImage({
    required BuildContext context,
    required String imgUrl,
    required String tag,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) {
          return _DetailScreen(imgUrl: imgUrl, tag: tag);
        },
      ),
    );
  }
}

class _DetailScreen extends StatelessWidget {
  const _DetailScreen({Key? key, required this.tag, required this.imgUrl})
      : super(key: key);

  final String tag;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: tag,
            child: Image.network(
              imgUrl,
            ),
          ),
        ),
      ),
    );
  }
}
