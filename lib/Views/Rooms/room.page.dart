import 'package:flutter/material.dart';
import 'package:my_lab_app/Views/Rooms/add_room.page.dart';
import 'package:my_lab_app/Views/Rooms/controller/room.provider.dart';
import 'package:my_lab_app/Views/Rooms/room.list.dart';
import 'package:my_lab_app/Views/parent_page.dart';
import 'package:provider/provider.dart';

class RoomPage extends StatelessWidget {
  const RoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ParentPage(
      title: "Salles",
      listWidget: RoomListPage(),
      newItem: AddNewRoomPage(),
      callback: () {
        context.read<RoomProvider>().get(isRefresh: true);
      },
    );
  }
}
