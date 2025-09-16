import 'package:flutter/material.dart';
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
      callback: () {
        context.read<UserAccessProvider>().get(isRefresh: true);
      },
      newItem: AddUserAccessRoomP(),
      listWidget: UserAccessRoomListPage(),
    );
  }
}
