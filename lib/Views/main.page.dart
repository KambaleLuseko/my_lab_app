import 'package:flutter/material.dart';
import 'package:my_lab_app/Resources/Components/texts.dart';
import 'package:my_lab_app/Resources/Constants/global_variables.dart';
import 'package:my_lab_app/Resources/Constants/responsive.dart';
import 'package:my_lab_app/Resources/Providers/menu_provider.dart';
import 'package:my_lab_app/Views/menu.widget.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      context.read<MenuProvider>().initDefaultMenus();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(88),
        child: AppBarWidget(),
      ),
      drawerScrimColor: AppColors.kPrimaryColor.withOpacity(0.1),
      backgroundColor: AppColors.kScaffoldColor,
      key: _scaffoldKey,
      drawerEnableOpenDragGesture: true,
      drawer: Drawer(elevation: 1, child: MenuWidget()),
      body: SafeArea(
        child: Row(
          children: [
            // if (Responsive.isWeb(context))
            //   Container(
            //       width: 50,
            //       padding: const EdgeInsets.all(0),
            //       child: const MenuWidget()),
            // if (Responsive.isWeb(context)) const SizedBox(width: 8),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    top: Responsive.isWeb(context) ? 0 : 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Column(
                      children: [
                        Expanded(
                          child: context.watch<MenuProvider>().activePage.page,
                        ),
                      ],
                    ),
                  ),
                  // if (Responsive.isWeb(context))
                  //   const Positioned(
                  //     top: 0,
                  //     right: 0,
                  //     left: 0,
                  //     child: AppBarWidget(),
                  //   ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: Responsive.isMobile(context)
      //     ? const EdgeInsets.only(top: 64)
      //     : EdgeInsets.zero,
      padding: EdgeInsets.all(16),
      width: double.maxFinite,
      alignment: Alignment.bottomCenter,
      height: 88,
      decoration: BoxDecoration(color: AppColors.kPrimaryColor.withOpacity(1)),
      child: Row(
        children: [
          if (Responsive.isWeb(context) == false)
            Container(
              padding: const EdgeInsets.all(8),
              constraints: const BoxConstraints(maxWidth: 60, maxHeight: 60),
              decoration: BoxDecoration(color: AppColors.kPrimaryColor),
              alignment: Alignment.center,
              child: IconButton(
                onPressed: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
                icon: Icon(Icons.sort_rounded, color: AppColors.kWhiteColor),
              ),
            ),
          // const SizedBox(width: 16),
          // const AppLogo(size: Size(80, 50)),
          const SizedBox(width: 8),
          Expanded(
            child: TextWidgets.textBold(
              title: context.select<MenuProvider, String>(
                (value) => value.activePage.title,
              ),
              fontSize: 25,
              textColor: AppColors.kWhiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
