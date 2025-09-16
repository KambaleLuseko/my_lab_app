import 'package:flutter/material.dart';
import 'package:my_lab_app/Resources/Constants/global_variables.dart';

import '../../main.dart';

showDatePicketCustom({
  required Function callback,
  bool? isPastDate = true,
}) async {
  await showDatePicker(
    context: navKey.currentContext!,
    initialDate: DateTime.now(),
    firstDate: isPastDate == true
        ? DateTime.now().subtract(const Duration(days: 36500))
        : DateTime.now(),
    lastDate: isPastDate == true
        ? DateTime.now()
        : DateTime.now().add(const Duration(days: 36500)),
    builder: (BuildContext context, child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: AppColors.kPrimaryColor,
          buttonTheme: const ButtonThemeData(
            textTheme: ButtonTextTheme.primary,
          ),
          colorScheme: ColorScheme.light(
            primary: AppColors.kPrimaryColor,
          ).copyWith(secondary: AppColors.kPrimaryColor),
        ),
        child: child!,
      );
    },
  ).then((value) => callback(value)).catchError((error) {});
}

showDateRangeCustomer({required Function callback}) async {
  await showDateRangePicker(
    context: navKey.currentContext!,
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(const Duration(days: 365)),
    builder: (BuildContext context, child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: AppColors.kPrimaryColor,
          buttonTheme: const ButtonThemeData(
            textTheme: ButtonTextTheme.primary,
          ),
          colorScheme: ColorScheme.light(
            primary: AppColors.kPrimaryColor,
          ).copyWith(secondary: AppColors.kPrimaryColor),
        ),
        child: child!,
      );
    },
  ).then((value) => callback(value)).catchError((error) {});
}
