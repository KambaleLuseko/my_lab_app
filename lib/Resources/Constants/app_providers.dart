import 'package:provider/provider.dart';

import '../../main.dart';
import '../Providers/app_state_provider.dart';
import '../Providers/menu_provider.dart';
import '../Providers/users_provider.dart';

class AppProviders {
  static MenuProvider menuProvider =
      Provider.of<MenuProvider>(navKey.currentContext!, listen: false);
  static AppStateProvider appProvider =
      Provider.of<AppStateProvider>(navKey.currentContext!, listen: false);
  //Analyses providers
  static UserProvider usersProvider =
      Provider.of<UserProvider>(navKey.currentContext!, listen: false);
}
