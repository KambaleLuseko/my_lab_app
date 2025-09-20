import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_lab_app/Resources/Constants/global_variables.dart';
import 'package:my_lab_app/Resources/Providers/menu_provider.dart';
import 'package:my_lab_app/Resources/Providers/users_provider.dart';
import 'package:my_lab_app/Views/Auth/login.page.dart';
import 'package:my_lab_app/Views/RoomManager/controller/room_manager.provider.dart';
import 'package:my_lab_app/Views/Rooms/controller/room.provider.dart';
import 'package:my_lab_app/Views/Services/controller/service.provider.dart';
import 'package:my_lab_app/Views/UserRoomAccess/controller/user_access.provider.dart';
import 'package:my_lab_app/Views/main.page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Resources/Providers/app_state_provider.dart';

late SharedPreferences prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.kPrimaryColor,
      statusBarColor: AppColors.kPrimaryColor, // or any color you want
      statusBarIconBrightness: Brightness.light, // For light (white) icons
    ),
  );
  prefs = await SharedPreferences.getInstance();
  await Hive.initFlutter();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppStateProvider()),
        ChangeNotifierProvider(create: (_) => MenuProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => RoomProvider()),
        ChangeNotifierProvider(create: (_) => RoomManagerProvider()),
        ChangeNotifierProvider(create: (_) => UserAccessProvider()),
        ChangeNotifierProvider(create: (_) => ServiceProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

String appaName = 'My Lab';
List<String> storeNames = ['users', 'rooms', 'room_managers', 'user_access'];

final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();

    return MaterialApp(
      title: appaName,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: AppColors.kPrimaryColor,
          secondary: AppColors.kSecondaryColor,
          // ...
        ),
        fontFamily: 'Lato', // Police globale
        textTheme: TextTheme(
          displayLarge: TextStyle(fontWeight: FontWeight.w700, fontSize: 24.0),
          bodyLarge: TextStyle(fontSize: 18.0, color: Colors.black87),
        ),
      ),
      home: prefs.getString('loggedUser') == null ? LoginPage() : MainPage(),
      navigatorKey: navKey,
      debugShowCheckedModeBanner: false,
    );
  }
}
