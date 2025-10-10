import 'package:flutter/material.dart';
import 'package:my_lab_app/Resources/Constants/enums.dart';
import 'package:my_lab_app/Resources/Providers/users_provider.dart';
import 'package:my_lab_app/Views/Home/home.page.dart';
import 'package:my_lab_app/Views/RoomManager/room_manager.page.dart';
import 'package:my_lab_app/Views/Rooms/room.page.dart';
import 'package:my_lab_app/Views/Services/service.page.dart';
import 'package:my_lab_app/Views/UserRoomAccess/user_access.page.dart';
import 'package:my_lab_app/Views/Users/user.page.dart';

import '../Models/Menu/menu.model.dart';

class MenuProvider extends ChangeNotifier {
  initDefaultMenus() {
    menus.clear();
    notifyListeners();
    menus = [
      MenuModel(
        title: "Accueil",
        page: const HomePage(),
        icon: Icons.dashboard_rounded,
      ),

      if (UserProvider.role == UserRolesEnum.admin)
        MenuModel(
          title: "Utilisateurs",
          page: const UserPage(),
          icon: Icons.people_rounded,
        ),
      if (UserProvider.role == UserRolesEnum.admin)
        MenuModel(
          title: "Laboratoires",
          page: const RoomPage(),
          icon: Icons.house_siding_rounded,
        ),
      if (UserProvider.role == UserRolesEnum.admin)
        MenuModel(
          title: "Services",
          page: const ServicePage(),
          icon: Icons.category,
        ),
      if (UserProvider.role == UserRolesEnum.admin)
        MenuModel(
          title: "Gestion des labos",
          page: const RoomManagerPage(),
          icon: Icons.home_repair_service_rounded,
        ),
      // if (UserProvider.role == UserRolesEnum.agent ||
      //     UserProvider.role == UserRolesEnum.admin)
      MenuModel(
        title: "Accès aux labos",
        page: const UserAccessRoomPage(),
        icon: Icons.lock_clock,
      ),
      MenuModel(
        title: "Profile",
        page: Container(),
        icon: Icons.person_rounded,
      ),
    ];
    notifyListeners();
  }

  List<MenuModel> menus = [];

  resetMenu() {
    activePage = MenuModel(
      title: "Accueil",
      page: HomePage(),
      icon: Icons.home,
    );
    notifyListeners();
  }

  MenuModel activePage = MenuModel(
    title: "Accueil",
    page: HomePage(),
    icon: Icons.home,
  );

  getActivePage() => activePage;

  setActivePage({required MenuModel newPage}) {
    activePage = newPage;
    notifyListeners();
  }
}
