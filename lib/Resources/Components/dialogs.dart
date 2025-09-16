import 'package:flutter/material.dart';
import 'package:my_lab_app/Resources/Constants/global_variables.dart';

import '../../../../main.dart';
import '../Constants/enums.dart';
import '../Constants/navigators.dart';
import '../Constants/responsive.dart';
import 'button.dart';
import 'texts.dart';

class Dialogs {
  static showDialogNoAction({
    BuildContext? context,
    MessageType? dialogType = MessageType.warning,
    required String title,
    required String content,
    double heightFactor = 2,
  }) {
    return showDialog(
      context: navKey.currentContext!,
      barrierColor: AppColors.kBlackColor.withOpacity(0.4),
      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(0),
          // height: MediaQuery.of(context).size.height /
          //     (heightFactor == 2 ? 2 : heightFactor),
          width: Responsive.isMobile(context)
              ? MediaQuery.of(context).size.width
              : MediaQuery.of(context).size.width / 2.5,
          child: Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  top: 16.0,
                  right: 16.0,
                  bottom: 16.0,
                ),
                margin: const EdgeInsets.only(top: 50.0, bottom: 50),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: AppColors.kWhiteColor,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 1),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: AppColors.kWhiteColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        alignment: Alignment.bottomCenter,
                        child: Icon(
                          dialogType == MessageType.error
                              ? Icons.cancel_outlined
                              : dialogType == MessageType.success
                              ? Icons.check_circle_outline_outlined
                              : Icons.help_outline_rounded,
                          color: dialogType == MessageType.error
                              ? AppColors.kRedColor
                              : dialogType == MessageType.success
                              ? AppColors.kGreenColor
                              : AppColors.kPrimaryColor,
                          size: 64,
                        ),
                      ),
                    ),
                    TextWidgets.textBold(
                      align: TextAlign.center,
                      title: title,
                      fontSize: 18,
                      textColor: AppColors.kBlackColor,
                    ),
                    const SizedBox(height: 15),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(children: [Container(width: double.maxFinite)]),
                          TextWidgets.text300(
                            title: content,
                            fontSize: 14,
                            textColor: AppColors.kBlackColor,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            callback: () async {
                              Navigator.pop(navKey.currentContext!);
                            },
                            text: "Fermer",
                            backColor: dialogType == MessageType.error
                                ? AppColors.kRedColor
                                : dialogType == MessageType.success
                                ? AppColors.kGreenColor
                                : AppColors.kPrimaryColor,
                            textColor: AppColors.kWhiteColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static showDialogWithAction({
    BuildContext? context,
    MessageType? dialogType = MessageType.warning,
    required String title,
    required String content,
    double heightFactor = 2,
    var callback,
  }) {
    return showDialog(
      context: navKey.currentContext!,
      barrierColor: AppColors.kBlackColor.withOpacity(0.4),
      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(0),
          // height: MediaQuery.of(context).size.height /
          //     (heightFactor == 2 ? 2 : heightFactor),
          width: Responsive.isMobile(context)
              ? MediaQuery.of(context).size.width
              : MediaQuery.of(context).size.width / 2.5,
          child: Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  top: 16.0,
                  right: 16.0,
                  bottom: 16.0,
                ),
                margin: const EdgeInsets.only(top: 50.0, bottom: 50),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: AppColors.kWhiteColor,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 1),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: AppColors.kWhiteColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        alignment: Alignment.bottomCenter,
                        child: Icon(
                          dialogType == MessageType.error
                              ? Icons.cancel_outlined
                              : dialogType == MessageType.success
                              ? Icons.check_circle_outline_outlined
                              : Icons.help_outline_rounded,
                          color: dialogType == MessageType.error
                              ? AppColors.kRedColor
                              : dialogType == MessageType.success
                              ? AppColors.kGreenColor
                              : AppColors.kPrimaryColor,
                          size: 64,
                        ),
                      ),
                    ),
                    TextWidgets.textBold(
                      align: TextAlign.center,
                      title: title,
                      fontSize: 18,
                      textColor: AppColors.kBlackColor,
                    ),
                    const SizedBox(height: 15),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(children: [Container(width: double.maxFinite)]),
                          TextWidgets.text300(
                            title: content,
                            maxLines: 5,
                            align: TextAlign.center,
                            fontSize: 14,
                            textColor: AppColors.kBlackColor,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            callback: () async {
                              Navigator.pop(context);
                            },
                            text: "Fermer",
                            backColor: Colors.grey[200]!,
                            textColor: AppColors.kBlackColor,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomButton(
                            callback: () async {
                              Navigator.of(context, rootNavigator: true).pop();
                              await callback();
                            },
                            text: "Confirmer",
                            backColor: dialogType == MessageType.error
                                ? AppColors.kRedColor
                                : dialogType == MessageType.success
                                ? AppColors.kGreenColor
                                : AppColors.kPrimaryColor,
                            textColor: AppColors.kWhiteColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static showDialogWithActionCustomContent({
    BuildContext? context,
    MessageType? dialogType = MessageType.warning,
    required String title,
    required Widget content,
    double heightFactor = 2,
    var callback,
    bool? hasScroll = false,
  }) {
    return showDialog(
      context: navKey.currentContext!,
      barrierColor: AppColors.kBlackColor.withOpacity(0.4),
      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(0),
          // height: MediaQuery.of(context).size.height /
          //     (heightFactor == 2 ? 2 : heightFactor),
          width: Responsive.isMobile(context)
              ? MediaQuery.of(context).size.width
              : MediaQuery.of(context).size.width / 2.5,
          child: Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  top: 16.0,
                  right: 16.0,
                  bottom: 16.0,
                ),
                margin: const EdgeInsets.only(top: 50.0, bottom: 50),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: AppColors.kWhiteColor,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 1),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if (title.isNotEmpty)
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: AppColors.kWhiteColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          alignment: Alignment.bottomCenter,
                          child: Icon(
                            dialogType == MessageType.error
                                ? Icons.cancel_outlined
                                : dialogType == MessageType.success
                                ? Icons.check_circle_outline_outlined
                                : Icons.help_outline_rounded,
                            color: dialogType == MessageType.error
                                ? AppColors.kRedColor
                                : dialogType == MessageType.success
                                ? AppColors.kGreenColor
                                : AppColors.kPrimaryColor,
                            size: 64,
                          ),
                        ),
                      ),
                    if (title.isNotEmpty)
                      TextWidgets.textBold(
                        align: TextAlign.center,
                        title: title,
                        fontSize: 18,
                        textColor: AppColors.kBlackColor,
                      ),
                    const SizedBox(height: 15),
                    Flexible(
                      fit: FlexFit.loose,
                      child: hasScroll == false
                          ? SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [const Row(), content],
                              ),
                            )
                          : content,
                    ),
                    const SizedBox(height: 15),
                    if (callback != null)
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              callback: () async {
                                Navigator.pop(context);
                              },
                              text: "Fermer",
                              backColor: Colors.grey[200]!,
                              textColor: AppColors.kBlackColor,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: CustomButton(
                              callback: () {
                                Navigator.pop(context);
                                callback();
                              },
                              text: "Confirmer",
                              backColor: dialogType == MessageType.error
                                  ? AppColors.kRedColor
                                  : dialogType == MessageType.success
                                  ? AppColors.kGreenColor
                                  : dialogType == MessageType.info
                                  ? Colors.blue
                                  : AppColors.kPrimaryColor,
                              textColor: AppColors.kWhiteColor,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static showChoiceDialog({
    BuildContext? context,
    MessageType? dialogType = MessageType.warning,
    required String title,
    required Widget content,
    double heightFactor = 2,
    var callback,
  }) {
    return showDialog(
      context: context ?? navKey.currentContext!,
      barrierColor: AppColors.kBlackColor.withOpacity(0.4),
      // barrierDismissible: true,
      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(0),
          // height: MediaQuery.of(context).size.height /
          //     (heightFactor == 2 ? 2 : heightFactor),
          width: Responsive.isMobile(context)
              ? MediaQuery.of(context).size.width
              : MediaQuery.of(context).size.width / 2.5,
          child: Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8),
                // margin: const EdgeInsets.only(top: 8.0, bottom: 50),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: AppColors.kScaffoldColor,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 1),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextWidgets.textBold(
                      align: TextAlign.center,
                      title: title,
                      fontSize: 16,
                      maxLines: 2,
                      textColor: AppColors.kBlackColor,
                    ),
                    const SizedBox(height: 15),
                    Flexible(
                      fit: FlexFit.loose,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [const Row(), content],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static showBottomModalSheet({
    BuildContext? context,
    required Widget content,
    bool? hasScroll = false,
    bool? showOnCenter = false,
  }) {
    if (Responsive.isMobile(navKey.currentContext!) == false ||
        showOnCenter == true) {
      showDialogWithActionCustomContent(
        title: "",
        content: content,
        hasScroll: hasScroll,
      );
      return;
    }
    showModalBottomSheet(
      // isScrollControlled: true,
      backgroundColor: AppColors.kTransparentColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      context: navKey.currentContext!,
      barrierColor: AppColors.kBlackColor.withOpacity(0.4),
      builder: (builder) {
        return FractionallySizedBox(
          widthFactor: Responsive.isWeb(navKey.currentContext!) == false
              ? 1
              : 0.5,
          child: Container(
            padding: const EdgeInsets.only(bottom: 16),
            constraints: BoxConstraints(
              minHeight: 10,
              maxHeight:
                  MediaQuery.of(navKey.currentContext!).size.height / 1.7,
            ),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              color: AppColors.kWhiteColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: AppColors.kPrimaryColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                Flexible(fit: FlexFit.loose, child: content),
              ],
            ),
          ),
        );
      },
    );
  }

  static showModal({
    required Widget child,
    bool? hasAppBar = true,
    bool? hasScroll = false,
    String? title,
  }) async {
    Widget page = Scaffold(
      backgroundColor: AppColors.kScaffoldColor,
      appBar: hasAppBar == true
          ? AppBar(
              backgroundColor: AppColors.kPrimaryColor,
              title: Text(
                title ?? '',
                style: TextStyle(color: AppColors.kWhiteColor),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(navKey.currentContext!);
                },
                icon: Icon(Icons.arrow_back_ios, color: AppColors.kWhiteColor),
              ),
            )
          : null,
      body: child,
    );
    if (Responsive.isMobile(navKey.currentContext!) == false) {
      return await showDialog(
        barrierColor: AppColors.kBlackColor.withOpacity(0.5),

        // useRootNavigator: true,
        useSafeArea: true,
        context: navKey.currentContext!,
        builder: (context) => Scaffold(
          backgroundColor: AppColors.kTransparentColor,
          body: Dialog(
            clipBehavior: Clip.hardEdge,
            insetAnimationCurve: Curves.bounceInOut,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(16),
            ),
            // contentPadding: const EdgeInsets.all(0),
            surfaceTintColor: AppColors.kScaffoldColor,
            backgroundColor: AppColors.kScaffoldColor,
            child: Container(
              // padding: const EdgeInsets.symmetric(vertical: 8),
              constraints: BoxConstraints(
                minHeight: 200,
                maxHeight:
                    MediaQuery.of(navKey.currentContext!).size.height - 40,
              ),
              width: Responsive.isMobile(context)
                  ? MediaQuery.of(navKey.currentContext!).size.width - 40
                  : MediaQuery.of(navKey.currentContext!).size.width / 1.9,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidgets.textBold(
                          title: title ?? '',
                          fontSize: 18,
                          textColor: AppColors.kBlackColor,
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.close, color: AppColors.kBlackColor),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: hasScroll == false
                        ? ListView(
                            shrinkWrap: true,
                            controller: ScrollController(),
                            children: [child],
                          )
                        : child,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      Navigation.pushNavigate(page: page, isFullDialog: true);
    }
  }

  static showLargeModal({
    required Widget child,
    bool? hasAppBar = true,
    bool? hasScroll = false,
    String? title,
  }) {
    // Widget page = Scaffold(
    //     backgroundColor: AppColors.kScaffoldColor,
    //     appBar: hasAppBar == true ? AppBar() : null,
    //     body: child);
    // if (Responsive.isWeb(navKey.currentContext!)) {
    showDialog(
      barrierColor: AppColors.kBlackColor.withOpacity(0.5),
      // useRootNavigator: true,
      useSafeArea: true,
      context: navKey.currentContext!,
      builder: (context) => Scaffold(
        backgroundColor: AppColors.kTransparentColor,
        body: AlertDialog(
          // contentPadding: const EdgeInsets.all(0),
          backgroundColor: AppColors.kScaffoldColor,
          surfaceTintColor: AppColors.kScaffoldColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Container(
            constraints: BoxConstraints(
              minHeight: 200,
              maxHeight:
                  MediaQuery.of(navKey.currentContext!).size.height - 120,
            ),
            width: Responsive.isMobile(context)
                ? MediaQuery.of(navKey.currentContext!).size.width - 40
                : MediaQuery.of(navKey.currentContext!).size.width - 120,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    // color: AppColors.kTextFormWhiteColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextWidgets.textBold(
                          title: title ?? '',
                          fontSize: 24,
                          textColor: AppColors.kWhiteColor,
                        ),
                      ),
                      IconButtonWidget(
                        backColor: AppColors.kTransparentColor,
                        textColor: AppColors.kWhiteColor,
                        callback: () {
                          Navigator.pop(context);
                        },
                        icon: Icons.clear,
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: hasScroll == false
                      ? ListView(
                          shrinkWrap: true,
                          controller: ScrollController(),
                          children: [child],
                        )
                      : child,
                ),
              ],
            ),
          ),
        ),
      ),
    );
    // } else {
    //   // Navigation.pushNavigate(page: page, isFullDialog: true);
    // }
  }

  static showPositionedModal({
    required Widget child,
    bool? hasTopMargin = true,
  }) {
    // Widget page = Scaffold(
    //     backgroundColor: AppColors.kScaffoldColor,
    //     appBar: AppBar(
    //       backgroundColor: AppColors.kWhiteColor,
    //     ),
    //     body: child);
    if (Responsive.isWeb(navKey.currentContext!)) {
      showDialog(
        barrierDismissible: true,
        barrierColor: AppColors.kBlackColor.withOpacity(0.3),
        // useRootNavigator: true,
        useSafeArea: true,
        context: navKey.currentContext!,
        builder: (context) => Scaffold(
          backgroundColor: AppColors.kTransparentColor,
          body: Dialog(
            insetPadding: EdgeInsets.zero,
            // contentPadding: const EdgeInsets.all(0),
            backgroundColor: AppColors.kTransparentColor,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  top: 0,
                  bottom: 0,
                  right: 0,
                  left: MediaQuery.of(context).size.width / 1.8,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: double.maxFinite,
                      color: AppColors.kScaffoldColor,
                      constraints: const BoxConstraints(minHeight: 200),
                      // width: Responsive.isMobile(context)
                      //     ? MediaQuery.of(navKey.currentContext!)
                      //             .size
                      //             .width -
                      //         40
                      //     : MediaQuery.of(navKey.currentContext!)
                      //             .size
                      //             .width /
                      //         1.9,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Positioned(
                            top: hasTopMargin == true ? 48 : 0,
                            bottom: 0,
                            right: 0,
                            left: 0,
                            child: child,
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Card(
                                  elevation: 0,
                                  color: AppColors.kScaffoldColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(64),
                                  ),
                                  child: IconButtonWidget(
                                    backColor: AppColors.kTransparentColor,
                                    textColor: AppColors.kWhiteColor,
                                    callback: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icons.clear,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
