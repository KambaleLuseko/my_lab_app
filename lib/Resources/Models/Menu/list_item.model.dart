import 'package:flutter/material.dart';

class ListItemModel {
  final String title, value;
  final Widget? icon;
  ListItemModel({required this.title, required this.value, this.icon});

  static fromJSON(json) {
    return ListItemModel(
        title: json['title']?.toString() ?? "",
        value: json['value']?.toString() ?? "",
        icon: json['icon'] ?? Container());
  }
}
