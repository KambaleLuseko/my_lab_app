import 'package:flutter/material.dart';
import 'package:my_lab_app/Resources/Constants/global_variables.dart';

showBottomModalSheet({
  required BuildContext context,
  required Function callback,
  required Widget content,
}) {
  showModalBottomSheet(
    // isDismissible: false,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
    ),
    context: context,
    builder: (builder) {
      return FractionallySizedBox(
        alignment: Alignment.bottomCenter,
        heightFactor: 0.6,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: AppColors.kScaffoldColor,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            Expanded(child: ListView(children: [content])),
          ],
        ),
      );
    },
  );
}
