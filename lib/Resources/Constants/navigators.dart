import 'package:flutter/cupertino.dart';

import '../../main.dart';

class Navigation {
  static pushNavigate({required Widget page, bool? isFullDialog = false}) {
    Navigator.push(
      navKey.currentContext!,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionDuration: const Duration(seconds: 0),
      ),
    );
  }

  static pushReplaceNavigate({required Widget page}) {
    Navigator.pushReplacement(
      navKey.currentContext!,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionDuration: const Duration(seconds: 0),
      ),
    );
  }

  static pushRemove({required Widget page}) {
    Navigator.pushAndRemoveUntil(
      navKey.currentContext!,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionDuration: const Duration(seconds: 0),
      ),
      (route) => false,
    );
  }
}
