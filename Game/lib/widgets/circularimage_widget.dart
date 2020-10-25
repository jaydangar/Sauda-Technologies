import 'package:flutter/material.dart';
import 'package:game/utils/const.dart';

class CircularImageWidget extends StatelessWidget {
  final String assetPath;
  final double size;
  final VoidCallback onClickAction;

  CircularImageWidget(
      {this.size = 50,
      this.assetPath = ConstUtils.appIconImagePath,
      this.onClickAction});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClickAction,
      child: ClipOval(
        child: Image(
          height: size,
          image: Image.asset(
            assetPath,
          ).image,
        ),
      ),
    );
  }
}
