import 'package:flutter/material.dart';
import 'package:my_lab_app/Views/parent_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ParentPage(
      hasTopTitle: false,
      title: 'Dashoard',
      listWidget: Container(),
    );
  }
}
