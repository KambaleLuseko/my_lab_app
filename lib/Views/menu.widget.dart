import 'package:flutter/material.dart';
import 'package:my_lab_app/main.dart';
import 'package:provider/provider.dart';

import '../../../Resources/Components/applogo.dart';
import '../../../Resources/Components/texts.dart';
import '../../../Resources/Constants/global_variables.dart';
import '../../../Resources/Constants/responsive.dart';
import '../../../Resources/Models/Menu/menu.model.dart';
import '../../../Resources/Models/user.model.dart';
import '../../../Resources/Providers/menu_provider.dart';
import '../../../Resources/Providers/users_provider.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({super.key});

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.kWhiteColor,
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Consumer<MenuProvider>(
        builder: (context, menuStateProvider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(height: 20),
              Selector<UserProvider, AuthModel?>(
                selector: (_, provider) => provider.userLogged,
                builder: (context, userLogged, _) {
                  return Card(
                    margin: const EdgeInsets.all(0),
                    color: AppColors.kScaffoldColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 40),
                          AppLogo(size: Size(180, 120)),
                          // Container(
                          //   width: 60,
                          //   height: 60,
                          //   alignment: Alignment.center,
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(1000),
                          //     border: Border.all(
                          //       color: AppColors.kPrimaryColor,
                          //       width: 2,
                          //     ),
                          //   ),
                          //   child: const Stack(
                          //     children: [AppLogo(size: Size(80, 80))],
                          //   ),
                          // ),
                          // TextWidgets.textBold(
                          //   title: userLogged != null
                          //       ? userLogged.user.uuid?.toUpperCase() ?? ''
                          //       : '',
                          //   fontSize: 16,
                          //   textColor: AppColors.kBlackColor,
                          // ),
                          TextWidgets.textBold(
                            title: userLogged?.user.name ?? appaName,
                            fontSize: 16,
                            textColor: AppColors.kBlackColor,
                          ),
                          const SizedBox(height: 10),
                          TextWidgets.text300(
                            title:
                                userLogged?.user.email ??
                                'contact@${appaName.toLowerCase().replaceAll(' ', '')}',
                            fontSize: 12,
                            textColor: AppColors.kBlackColor,
                          ),
                          TextWidgets.text300(
                            title: userLogged?.user.role?.toUpperCase() ?? '',
                            fontSize: 12,
                            textColor: AppColors.kBlackColor,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: menuStateProvider.menus.length,
                  itemBuilder: (context, int index) {
                    return MenuItem(
                      menu: MenuModel(
                        title: menuStateProvider.menus[index].title,
                        page: menuStateProvider.menus[index].page,
                        icon: menuStateProvider.menus[index].icon,
                      ),
                    );
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.read<UserProvider>().logOut(password: '1234');
                },
                child: Container(
                  decoration: BoxDecoration(color: AppColors.kWhiteColor),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        !Responsive.isWeb(context)
                            ? Icon(
                                Icons.exit_to_app_sharp,
                                color: AppColors.kRedColor,
                              )
                            : Container(),
                        !Responsive.isWeb(context)
                            ? const SizedBox(width: 16.0)
                            : Container(),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.zero,
                            child: Text(
                              "Deconnexion",
                              style: TextStyle(
                                color: AppColors.kRedColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class MenuItem extends StatefulWidget {
  final MenuModel menu;
  const MenuItem({super.key, required this.menu});

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  bool isButtonHovered = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<MenuProvider>(
      builder: (context, menuStateProvider, child) {
        return GestureDetector(
          onTap: () {
            if (!Responsive.isWeb(context)) {
              Navigator.pop(context);
            }
            menuStateProvider.setActivePage(newPage: widget.menu);
          },
          child: MouseRegion(
            // cursor: MouseCursor.,
            onHover: (value) => setState(() {
              isButtonHovered = true;
            }),
            onEnter: (value) => setState(() {
              isButtonHovered = true;
            }),
            onExit: (value) => setState(() {
              isButtonHovered = false;
            }),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
              decoration: BoxDecoration(
                color: menuStateProvider.activePage.title == widget.menu.title
                    ? AppColors.kPrimaryColor.withOpacity(0.10)
                    : AppColors.kTransparentColor,
                borderRadius: BorderRadius.circular(
                  !Responsive.isWeb(context) ? 0 : 10,
                ),
              ),
              // menuStateProvider.currentMenu == widget.title || isButtonHovered
              //     ? widget.textColor
              //     : widget.backColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        !Responsive.isWeb(context)
                            ? Icon(
                                widget.menu.icon,
                                color:
                                    menuStateProvider.activePage.title ==
                                        widget.menu.title
                                    ? AppColors.kBlackColor
                                    : AppColors.kBlackColor,
                              )
                            : Container(),
                        !Responsive.isWeb(context)
                            ? const SizedBox(width: 16.0)
                            : Container(),
                        Container(
                          padding: EdgeInsets.zero,
                          child: Text(
                            widget.menu.title,
                            style: TextStyle(
                              color:
                                  menuStateProvider.activePage.title ==
                                      widget.menu.title
                                  ? AppColors.kBlackColor
                                  : AppColors.kBlackColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // !Responsive.isWeb(context)
                  //     ? const Divider(
                  //         height: 2,
                  //         color: Colors.black45,
                  //         thickness: 0.5,
                  //       )
                  //     : Container()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
