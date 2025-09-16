import 'package:flutter/material.dart';

import 'texts.dart';

class DecoratedContainer extends StatelessWidget {
  final Color? backColor;
  final Widget child;
  final bool? applyMargin;
  const DecoratedContainer({
    super.key,
    this.backColor = Colors.grey,
    required this.child,
    this.applyMargin = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          applyMargin == false
              ? null
              : const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 24),
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: backColor!,
      ),
      child: child,
    );
  }
}

class ChipFilterWidget extends StatelessWidget {
  const ChipFilterWidget({
    super.key,
    required this.title,
    this.backColor = Colors.white,
    this.textColor = Colors.black,
    this.callback,
    this.active = false,
  });
  final Color? backColor, textColor;
  final String title;
  final Function(String)? callback;
  final bool? active;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (callback == null) return;
        callback!(title);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: backColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (active == true) Icon(Icons.check, color: textColor, size: 14),
            if (active == true) const SizedBox(width: 8),
            TextWidgets.text300(
              title: title,
              fontSize: 14,
              textColor: textColor!,
            ),
          ],
        ),
      ),
    );
  }
}
