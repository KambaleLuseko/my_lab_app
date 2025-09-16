import 'package:flutter/material.dart';
import 'package:my_lab_app/Resources/Components/button.dart';
import 'package:my_lab_app/Resources/Components/empty_model.dart';
import 'package:my_lab_app/Resources/Components/list_item.dart';
import 'package:my_lab_app/Resources/Components/shimmer_placeholder.dart';
import 'package:my_lab_app/Resources/Components/texts.dart';
import 'package:my_lab_app/Resources/Constants/global_variables.dart';
import 'package:my_lab_app/Resources/Constants/responsive.dart';
import 'package:my_lab_app/Resources/Providers/app_state_provider.dart';
import 'package:my_lab_app/main.dart';
import 'package:provider/provider.dart';

class BuildTable {
  static generateTable({
    required List<String> columns,
    required List<Map> rows,
    Color? textColor = Colors.black,
    Color? backColor,
    Function(Map)? editCallback,
    Function(Map)? deleteCallback,
    Function(Map)? itemClickCallback,
    bool? keepMidleFields = false,
    IconData? icon,
    IconData? editIcon,
    ScrollController? scrollCtrller,
  }) {
    backColor = AppColors.kScaffoldColor;
    Color rowColor = AppColors.kWhiteColor;
    if (Responsive.isMobile(navKey.currentContext!)) {
      return navKey.currentContext?.watch<AppStateProvider>().isAsync == true &&
              rows.isEmpty
          ? ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return const ListItemPlaceholder();
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemCount: 10,
            )
          : rows.isEmpty
          ? EmptyModel(color: AppColors.kBlackColor)
          : ListView.builder(
              controller: scrollCtrller,
              shrinkWrap: true,
              itemCount: rows.length,
              itemBuilder: (context, index) {
                return ListItem(
                  icon: icon ?? rows[index]['icon'] as IconData?,
                  title: rows[index][columns[0]]?.toString() ?? '',
                  subtitle: rows[index][columns[1]]?.toString() ?? '',
                  textColor: textColor,
                  backColor: backColor,
                  keepMidleFields: true,
                  data: rows[index],

                  middleFields: ListItemModel(
                    title: columns[2].toString(),
                    value:
                        rows[index][columns[2]]
                            ?.toString()
                            .split('/')
                            .firstOrNull ??
                        '',
                  ),
                  detailsFields: [
                    ...List.generate(
                      columns.sublist(2).isEmpty
                          ? 0
                          : columns.sublist(2).length,
                      (colIndex) {
                        return ListItemModel(
                          title: columns.sublist(2)[colIndex].toUpperCase(),
                          value:
                              rows[index][columns.sublist(2)[colIndex]]
                                  ?.toString() ??
                              '',
                        );
                      },
                    ),
                  ],
                  updateCallback: editCallback,
                  deleteCallback: deleteCallback,
                  updateIcon: editIcon,
                  hasDelete: deleteCallback != null ? true : false,
                  hasUpdate: editCallback != null ? true : false,
                );
              },
            );
    }
    return navKey.currentContext?.watch<AppStateProvider>().isAsync == true &&
            rows.isEmpty
        ? ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return const ListItemPlaceholder();
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemCount: 10,
          )
        : rows.isEmpty
        ? EmptyModel(color: AppColors.kBlackColor)
        : ListView(
            controller: scrollCtrller,
            shrinkWrap: true,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DataTable(
                      // dataRowHeight: 48,
                      showCheckboxColumn: false,
                      dividerThickness: 0.2,
                      border: TableBorder(
                        bottom: BorderSide(
                          color: AppColors.kBlackColor.withAlpha(24),
                          width: 0.5,
                        ),
                        // top: BorderSide(
                        //   color: AppColors.kBlackColor.withAlpha(48),
                        //   width: 0.5,
                        // ),
                        // left: BorderSide(
                        //   color: AppColors.kBlackColor.withAlpha(48),
                        //   width: 0.5,
                        // ),
                        // right: BorderSide(
                        //   color: AppColors.kBlackColor.withAlpha(48),
                        //   width: 0.5,
                        // ),
                      ),
                      columns: [
                        ...columns.map(
                          (e) => DataColumn(
                            label: TextWidgets.textBold(
                              title: e.toUpperCase().replaceAll('_', ''),
                              fontSize: 16,
                              textColor: textColor!,
                            ),
                          ),
                        ),
                        if (editCallback != null || deleteCallback != null)
                          DataColumn(
                            label: TextWidgets.textBold(
                              title: "ACTIONS",
                              fontSize: 16,
                              textColor: textColor!,
                            ),
                          ),
                      ],
                      rows: rows.map((row) {
                        rowColor = rowColor == AppColors.kWhiteColor
                            ? AppColors.kPrimaryColor.withAlpha(16)
                            : AppColors.kWhiteColor;
                        return DataRow(
                          color: WidgetStateProperty.all<Color>(rowColor),
                          onSelectChanged: (value) {
                            if (itemClickCallback != null) {
                              // print(row);
                              itemClickCallback(row);
                            }
                          },
                          cells: [
                            ...columns.map((col) {
                              return DataCell(
                                TextWidgets.text300(
                                  title: row[col]?.toString() ?? '',
                                  fontSize: 14,
                                  textColor: textColor!,
                                ),
                              );
                            }),
                            if (editCallback != null || deleteCallback != null)
                              DataCell(
                                Row(
                                  children: [
                                    if (editCallback != null)
                                      IconButtonWidget(
                                        backColor: AppColors.kGreenColor,
                                        textColor: AppColors.kWhiteColor,
                                        callback: () {
                                          // print(row);
                                          editCallback(row);
                                        },
                                        icon: Icons.border_color_rounded,
                                      ),
                                    if (deleteCallback != null)
                                      IconButtonWidget(
                                        backColor: AppColors.kRedColor,
                                        textColor: AppColors.kWhiteColor,
                                        callback: () {
                                          deleteCallback(row);
                                        },
                                        icon: Icons.delete,
                                      ),
                                  ],
                                ),
                              ),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidgets.textNormal(
                      title: "${rows.length} element(s)",
                      fontSize: 12,
                      textColor: textColor!,
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}
