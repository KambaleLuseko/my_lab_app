import 'package:flutter/material.dart';
import 'package:my_lab_app/Resources/Components/dialogs.dart';
import 'package:my_lab_app/Resources/Constants/enums.dart';
import 'package:my_lab_app/Resources/Constants/global_variables.dart';
import 'package:my_lab_app/Resources/Providers/users_provider.dart';
import 'package:my_lab_app/Views/Order/new_request.page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<UserProvider>().getUserData();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          UserProvider.role == UserRolesEnum.student ||
              UserProvider.role == UserRolesEnum.visitor ||
              UserProvider.role == UserRolesEnum.group
          ? FloatingActionButton(
              backgroundColor: AppColors.kPrimaryColor,
              mini: true,
              shape: const CircleBorder(),
              child: const Icon(Icons.add),
              onPressed: () {
                Dialogs.showModal(
                  hasScroll: true,
                  title: "Nouvelle demande",
                  child: ClientRoomAccessRequest(),
                );
                // Navigation.pushNavigate(page: ClientRoomAccessRequest());
              },
            )
          : null,
      body: Column(children: []),
    );
  }
}
