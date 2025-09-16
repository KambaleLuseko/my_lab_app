import 'package:flutter/material.dart';
import 'package:my_lab_app/Resources/Constants/global_variables.dart';
import 'package:my_lab_app/Resources/Constants/responsive.dart';

import '../../../main.dart';
import '../Constants/enums.dart';

// enum MessageType { error, success, info, warning }

class NotificationHelper {
  static showToast({
    required String message,
    MessageType msgType = MessageType.warning,
  }) {
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: msgType == MessageType.error
            ? AppColors.kRedColor
            : msgType == MessageType.success
            ? AppColors.kGreenColor
            : msgType == MessageType.info
            ? AppColors.kPrimaryColor
            : AppColors.kRedColor,
        content: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: msgType == MessageType.error
                ? AppColors.kRedColor
                : msgType == MessageType.success
                ? AppColors.kGreenColor
                : msgType == MessageType.info
                ? AppColors.kPrimaryColor
                : AppColors.kRedColor,
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
                      ? Icons.info
                      : Icons.warning_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(message, style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    // ScaffoldMessenger(
    //   child: SnackBar(content: Text(message), backgroundColor: backColor),
    // );
  }
}
