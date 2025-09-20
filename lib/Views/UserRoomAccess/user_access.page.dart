import 'package:flutter/material.dart';
import 'package:my_lab_app/Resources/Constants/enums.dart';
import 'package:my_lab_app/Resources/Constants/global_variables.dart';
import 'package:my_lab_app/Resources/Providers/users_provider.dart';
import 'package:my_lab_app/Views/RoomManager/controller/room_manager.provider.dart';
import 'package:my_lab_app/Views/Rooms/controller/room.provider.dart';
import 'package:my_lab_app/Views/Services/controller/service.provider.dart';
import 'package:my_lab_app/Views/UserRoomAccess/add_user_access.page.dart';
import 'package:my_lab_app/Views/UserRoomAccess/controller/user_access.provider.dart';
import 'package:my_lab_app/Views/UserRoomAccess/user_access.list.dart';
import 'package:my_lab_app/Views/parent_page.dart';
import 'package:provider/provider.dart';

class UserAccessRoomPage extends StatelessWidget {
  const UserAccessRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ParentPage(
      title: "Acces aux salles",
      callback: () async {
        await context.read<UserAccessProvider>().get(isRefresh: true);
        await context.read<RoomProvider>().get(isRefresh: true);
        await context.read<RoomManagerProvider>().get(isRefresh: true);

        await context.read<ServiceProvider>().get(isRefresh: true);
        await context.read<UserProvider>().get(isRefresh: true);
        ToastNotification.showToast(
          msg: "Chargement des données terminé",
          msgType: MessageType.success,
        );
      },
      newItem: AddUserAccessRoomP(),
      listWidget: UserAccessRoomListPage(),
    );
  }
}
