import 'package:flutter/material.dart';
import 'package:game/utils/const.dart';

import 'circularimage_widget.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final bool isCenter;
  final Widget action;

  AppBarWidget(
      {this.title = ConstUtils.appName,
      this.isCenter,
      this.action});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircularImageWidget(),
      ),
      actions: [
        this.action
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
