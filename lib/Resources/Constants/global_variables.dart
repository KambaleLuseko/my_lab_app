import 'package:flutter/material.dart';

import '../../main.dart';
import '../Components/texts.dart';
import 'enums.dart';
import 'responsive.dart';

double kDefaultPadding = 20;

double clusterZoomLevel = 14;

class AppColors {
  static Color kPrimaryColor = const Color.fromARGB(255, 10, 32, 67);
  static Color kSecondaryColor = Colors.green;
  // static Color kPrimaryColor = const Color.fromARGB(
  //     255, 151, 189, 73); // const Color.fromRGBO(24, 24, 24, 1);
  // static Color kSecondaryColor = const Color.fromARGB(255, 54, 126, 220);
  static Color kScaffoldColor = const Color.fromARGB(255, 231, 231, 231);
  // static Color kScaffoldColor = const Color.fromRGBO(235, 235, 235, 1);
  static Color kAccentColor = const Color.fromARGB(255, 86, 163, 245);
  static Color kBlackColor = const Color.fromRGBO(24, 24, 24, 1);
  static Color kItemBackColor = kPrimaryColor.withOpacity(0.6);

  // static Color kBlackColor = Colors.black;
  static Color kBlackLightColor = const Color.fromRGBO(40, 40, 40, 1);
  static Color kWhiteColor = Colors.white;
  static Color kWhiteDarkColor = Colors.grey.shade400;
  static Color kGreenColor = Colors.green;
  static Color kBlueColor = Colors.blue;
  static Color kRedColor = Colors.red;
  static Color kGreyColor = Colors.grey;
  static Color kWarningColor = Colors.deepOrange;

  // static Color kYellowColor = const Color.fromRGBO(255, 184, 57, 1);
  static Color kYellowColor = const Color.fromRGBO(255, 185, 35, 1);
  static Color kTextFormWhiteColor = Colors.white.withOpacity(0.05);
  static Color kTextFormBackColor = Colors.black.withOpacity(0.08);
  static Color kTransparentColor = Colors.transparent;
}

class BaseUrl {
  static String appName = "Smart Delivery";
  static String appContact = "+243 000 000 000";
  static String ip = "http://127.0.0.1:8000/api";
  // static String ip = "http://192.168.1.250:3000";
  // static String ip = "https://smart-delivery-api.onrender.com";
  // static String ip = "http://167.86.68.113:3000"; //IP
  static String apiUrl = ip;
  // static String graphqlEndpoint = "$apiUrl/graphql";
  // static String getLogin = '$apiUrl/user/login/';
  static String authentication = '$apiUrl/authentication';
  static String signIn = '$apiUrl/authentication/signin';
  static String signUp = '$apiUrl/authentication/signup';
  static String user = '$apiUrl/users';
  static String rooms = '$apiUrl/salles';
  static String roomManagers = '$apiUrl/room-manager';
  static String userAccessRooms = '$apiUrl/user-room-access';

  ///
  static String stats = '$apiUrl/stats/';

  //=================User========================
}

class ToastNotification {
  static showToast({
    required String msg,
    String? title = "Information",
    MessageType? msgType = MessageType.warning,
  }) {
    try {
      ScaffoldMessenger.of(navKey.currentContext!).removeCurrentSnackBar();
      ScaffoldMessenger.of(navKey.currentContext!).showSnackBar(
        SnackBar(
          elevation: 5,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 5),
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          margin: Responsive.isWeb(navKey.currentContext!)
              ? EdgeInsets.only(
                  left: MediaQuery.of(navKey.currentContext!).size.width / 1.3,
                  right: 8,
                  bottom: 8,
                )
              : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: msgType == MessageType.error
              ? AppColors.kRedColor
              : msgType == MessageType.success
              ? AppColors.kGreenColor
              : msgType == MessageType.info
              ? AppColors.kBlueColor
              : AppColors.kWarningColor,
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: msgType == MessageType.error
                  ? AppColors.kRedColor
                  : msgType == MessageType.success
                  ? AppColors.kGreenColor
                  : msgType == MessageType.info
                  ? AppColors.kBlueColor
                  : AppColors.kWarningColor,
              // msgType == MessageType.error
              //     ? AppColors.kRedColor.withOpacity(0.1)
              //     : msgType == MessageType.success
              //         ? AppColors.kGreenColor.withOpacity(0.1)
              //         : AppColors.kWarningColor.withOpacity(0.1),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Container(
                  width: 35,
                  height: 35,
                  // padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    // color: AppColors.kWhiteColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    msgType == MessageType.error
                        ? Icons.cancel
                        : msgType == MessageType.success
                        ? Icons.check_circle
                        : msgType == MessageType.info
                        ? Icons.help_outlined
                        : Icons.warning_rounded,
                    color: AppColors.kWhiteColor,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextWidgets.textBold(
                        title: title!,
                        fontSize: 14,
                        textColor: AppColors.kWhiteColor,
                      ),
                      TextWidgets.textNormal(
                        maxLines: 3,
                        title: msg,
                        fontSize: 12,
                        textColor: AppColors.kWhiteColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } catch (e) {}
  }

  static handleErrorMessage({dynamic message}) {
    if (message is List) {
      return message.join(', ');
    } else {
      return message;
    }
  }
}
