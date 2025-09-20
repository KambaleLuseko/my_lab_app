import 'package:flutter/material.dart';
import 'package:my_lab_app/Views/Services/controller/service.provider.dart';
import 'package:my_lab_app/Views/Services/service.list.dart';
import 'package:my_lab_app/Views/parent_page.dart';
import 'package:provider/provider.dart';

class ServicePage extends StatelessWidget {
  const ServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ParentPage(
      title: "Services",
      listWidget: ServiceListPage(),
      callback: () {
        context.read<ServiceProvider>().get(isRefresh: true);
      },
    );
  }
}
