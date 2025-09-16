import 'package:flutter/material.dart';
import 'package:my_lab_app/Resources/Components/build_table.dart';
import 'package:provider/provider.dart';

import '../../Resources/Components/dialogs.dart';
import '../../Resources/Constants/enums.dart';
import '../../Resources/Models/user.model.dart';
import '../../Resources/Providers/users_provider.dart';
import 'add_user.page.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({super.key});

  @override
  State<UsersListPage> createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<UserProvider>().getOffline();
      filteredData = context.read<UserProvider>().offlineData;
      setState(() {});
    });
  }

  String currentFilter = "Tous",
      statusFilter = 'Tous',
      countryFilter = 'Tous',
      cityFilter = 'Tous';
  List<UserModel> filteredData = [];

  @override
  Widget build(BuildContext context) {
    return Selector<UserProvider, List<UserModel>>(
      selector: (_, provider) => provider.offlineData,
      builder: (__, offlineData, _) {
        if (currentFilter.toLowerCase().contains('tous') &&
            statusFilter.toLowerCase().contains('tous')) {
          filteredData = offlineData;
        }
        // List<String> filters = offlineData
        //     .map((e) => (e.role ?? '').split('/').firstOrNull?.trim() ?? '')
        //     .toSet()
        //     .toList();
        // List<String> statusfilters = offlineData
        //     .map((e) => (e.role ?? ''))
        //     .toSet()
        //     .toList();

        return Column(
          children: [
            // Container(
            //   width: double.maxFinite,
            //   padding: const EdgeInsets.symmetric(vertical: 0),
            //   decoration: BoxDecoration(color: AppColors.kWhiteColor),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       IconButtonWidget(
            //         backColor: AppColors.kPrimaryColor,
            //         textColor: AppColors.kWhiteColor,
            //         callback: () {
            //           Dialogs.showBottomModalSheet(
            //             content: Padding(
            //               padding: const EdgeInsets.all(8.0),
            //               child: Column(
            //                 mainAxisSize: MainAxisSize.min,
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   TextWidgets.textBold(
            //                     title: "Categorie",
            //                     fontSize: 16,
            //                     textColor: AppColors.kBlackColor,
            //                   ),
            //                   Container(
            //                     width: double.maxFinite,
            //                     padding: const EdgeInsets.symmetric(
            //                       vertical: 8,
            //                     ),
            //                     decoration: BoxDecoration(
            //                       color: AppColors.kWhiteColor,
            //                     ),
            //                     child: Wrap(
            //                       children: [
            //                         ChipFilterWidget(
            //                           title: "Tous",
            //                           active:
            //                               currentFilter.toLowerCase() == 'tous',
            //                           backColor: AppColors.kTextFormBackColor,
            //                           textColor: AppColors.kBlackColor,
            //                           callback: (value) {
            //                             currentFilter = value;
            //                             statusFilter = value;
            //                             filteredData = offlineData;
            //                             setState(() {});
            //                             Navigator.pop(context);
            //                           },
            //                         ),
            //                         ...List.generate(
            //                           filters.length,
            //                           (index) => ChipFilterWidget(
            //                             active:
            //                                 currentFilter.toLowerCase() ==
            //                                 filters[index].toLowerCase(),
            //                             title: filters[index],
            //                             backColor: AppColors.kTextFormBackColor,
            //                             textColor: AppColors.kBlackColor,
            //                             callback: (value) {
            //                               currentFilter = value;
            //                               filterData(data: offlineData);
            //                               Navigator.pop(context);
            //                             },
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                   TextWidgets.textBold(
            //                     title: "Statut",
            //                     fontSize: 16,
            //                     textColor: AppColors.kBlackColor,
            //                   ),
            //                   Container(
            //                     width: double.maxFinite,
            //                     padding: const EdgeInsets.symmetric(
            //                       vertical: 8,
            //                     ),
            //                     decoration: BoxDecoration(
            //                       color: AppColors.kWhiteColor,
            //                     ),
            //                     child: Wrap(
            //                       children: [
            //                         ...List.generate(
            //                           statusfilters.length,
            //                           (index) => ChipFilterWidget(
            //                             active:
            //                                 statusFilter.toLowerCase() ==
            //                                 statusfilters[index].toLowerCase(),
            //                             title: statusfilters[index],
            //                             backColor: AppColors.kTextFormBackColor,
            //                             textColor: AppColors.kBlackColor,
            //                             callback: (value) {
            //                               statusFilter = value;
            //                               filterData(data: offlineData);
            //                               Navigator.pop(context);
            //                             },
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           );
            //         },
            //         icon: Icons.filter_list_rounded,
            //       ),
            //     ],
            //   ),
            // ),
            Flexible(
              child: BuildTable.generateTable(
                icon: Icons.person_3_rounded,
                columns: ["name", "phone", "accreditation", "address", "email"],
                rows: filteredData
                    .map(
                      (e) => {
                        ...e.toJson(),
                        "name": e.name,
                        "phone": e.phone,
                        "address": e.address,
                        "username": '',
                        "email": e.email ?? '',
                        "accreditation": e.role ?? '',
                      },
                    )
                    .toList(),
                editCallback: (value) {
                  Dialogs.showModal(
                    child: AddUserPage(
                      action: EnumActions.update,
                      data: UserModel.fromJson(value),
                    ),
                  );
                },
                deleteCallback: (value) {
                  context.read<UserProvider>().delete(
                    data: UserModel.fromJson(value),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  filterData({required List<UserModel> data}) {
    filteredData = data
        .where(
          (element) =>
              (currentFilter.toLowerCase() == 'tous'
                  ? element.role!.isNotEmpty
                  : (element.role ?? '').toLowerCase().startsWith(
                      currentFilter.toLowerCase(),
                    )) &&
              (statusFilter.toLowerCase() != 'tous'
                  ? (element.status ?? '').toLowerCase().startsWith(
                      statusFilter.toLowerCase(),
                    )
                  : (element.status ?? 'Active').isNotEmpty),
        )
        .toList();
    // print(data.length);
    // print(filteredData.length);
    setState(() {});
  }
}
