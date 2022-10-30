import 'package:flutter/material.dart';

AppBar buildAppBar(
  BuildContext context,
  bool haveBackButton, {
  Widget? backbuton,
  IconData? rightIcon,
  String? title,
  VoidCallback? functionRightButton,
}) {
  return AppBar(
    leading: haveBackButton ? backbuton : null,
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: title != null ? Text(title.toString()) : null,
    actions: [
      rightIcon != null
          ? IconButton(
              icon: Icon(rightIcon),
              onPressed: functionRightButton,
            )
          : const SizedBox()
    ],
  );
}
