import 'package:flutter/material.dart';
import 'package:my_lab_app/Views/RoomManager/add_manager.page.dart';
import 'package:my_lab_app/Views/RoomManager/controller/room_manager.provider.dart';
import 'package:my_lab_app/Views/RoomManager/room_manager.list.dart';
import 'package:my_lab_app/Views/parent_page.dart';
import 'package:provider/provider.dart';

class RoomManagerPage extends StatelessWidget {
  const RoomManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ParentPage(
      title: "Gestion des salles",
      listWidget: RoomManagerListPage(),
      callback: () {
        context.read<RoomManagerProvider>().get(isRefresh: true);
      },
      newItem: AddRoomManagerPage(),
    );
  }
}
