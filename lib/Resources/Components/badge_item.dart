import 'package:flutter/material.dart';

import 'texts.dart';

class BadgeWidget extends StatelessWidget {
  final String value;
  final Color textColor;
  final Color backColor;
  const BadgeWidget(
      {super.key,
      required this.value,
      required this.textColor,
      required this.backColor});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        // margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          color: backColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextWidgets.textNormal(
            title: value, fontSize: 14, textColor: textColor),
      ),
    );
  }
}
