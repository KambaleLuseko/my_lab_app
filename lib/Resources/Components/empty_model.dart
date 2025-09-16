import 'package:flutter/material.dart';

import 'texts.dart';

class EmptyModel extends StatelessWidget {
  final Color color;
  final String? text;

  const EmptyModel({
    super.key,
    required this.color,
    this.text = "Aucune donnée trouvée",
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.delete_outline_rounded, size: 40, color: color),
          const SizedBox(height: 20),
          TextWidgets.text300(
            title: text ?? "Aucune donnée trouvée",
            fontSize: 14,
            align: TextAlign.center,
            maxLines: 3,
            textColor: color,
          ),
        ],
      ),
    );
  }
}
