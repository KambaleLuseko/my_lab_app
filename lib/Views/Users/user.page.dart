import 'package:flutter/material.dart';
import 'package:my_lab_app/Views/parent_page.dart';
import 'package:provider/provider.dart';

import '../../Resources/Providers/users_provider.dart';
import '../../Views/Users/user_list.page.dart';
import 'add_user.page.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final TextEditingController _searchCtrller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchCtrller.addListener(() {
      // searchList(
      //   data: context
      //       .read<UserProvider>()
      //       .offlineData
      //       .map((partner) => partner.toJSON())
      //       .toList(),
      //   firstSearchColumn: 'name',
      //   secondSearchColumn: 'description',
      //   value: _searchCtrller.text.trim(),
      //   callback: (data) {
      //     // List<UserModel> validData = List<UserModel>.from(data
      //     //     .map((singleData) => UserModel.fromJSON(singleData))
      //     //     .toList());
      //     // context.read<UserProvider>().validateSearch(data: validData);
      //   },
      // );
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    return ParentPage(
      title: 'Utilisateurs',
      listWidget: const UsersListPage(),
      newItem: const AddUserPage(),
      callback: () {
        context.read<UserProvider>().get(isRefresh: true);
      },
    );
    //  Column(
    //   children: [
    //     Container(
    //         decoration:
    //             BoxDecoration(color: AppColors.kWhiteColor.withOpacity(0.6)),
    //         padding: const EdgeInsets.all(16.0),
    //         child: Flex(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             mainAxisSize: MainAxisSize.min,
    //             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             direction: Responsive.isMobile(context)
    //                 ? Axis.vertical
    //                 : Axis.horizontal,
    //             children: [
    //               TextWidgets.textBold(
    //                   title: "Nos employés",
    //                   fontSize: 18,
    //                   textColor: AppColors.kPrimaryColor),
    //               if (!Responsive.isMobile(context))
    //                 Expanded(child: Container()),
    //               Flexible(
    //                 flex: !Responsive.isWeb(context) ? 2 : 1,
    //                 fit: FlexFit.loose,
    //                 child: SearchTextFormFieldWidget(
    //                     backColor: AppColors.kTextFormBackColor,
    //                     hintText: 'Recherchez ici',
    //                     editCtrller: _searchCtrller,
    //                     inputType: TextInputType.phone,
    //                     textColor: AppColors.kBlackColor,
    //                     maxLines: 1),
    //               )
    //             ])),
    //     const Expanded(
    //       child: Padding(
    //         padding: EdgeInsets.all(8.0),
    //         child: UsersListPage(),
    //       ),
    //     ),
    //   ],
    // );
  }
}
