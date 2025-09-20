import 'package:flutter/material.dart';
import 'package:my_lab_app/Resources/Components/dialogs.dart';
import 'package:my_lab_app/Resources/Components/texts.dart';
import 'package:my_lab_app/Resources/Constants/global_variables.dart';
import 'package:my_lab_app/Resources/Helpers/date_parser.dart';
import 'package:my_lab_app/Views/RoomManager/controller/room_manager.provider.dart';
import 'package:my_lab_app/Views/RoomManager/model/room_manager.model.dart';
import 'package:my_lab_app/Views/Services/model/service.model.dart';
import 'package:provider/provider.dart';

class ChooseRoomWidget extends StatefulWidget {
  ChooseRoomWidget({super.key, required this.callback});
  RoomManagerModel? room;
  Function(RoomManagerModel, ServiceModel) callback;
  @override
  State<ChooseRoomWidget> createState() => _ChooseRoomWidgetState();
}

class _ChooseRoomWidgetState extends State<ChooseRoomWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextWidgets.textBold(
          title: "Choisissez un laboratoire",
          fontSize: 18,
          textColor: AppColors.kBlackColor,
        ),
        const SizedBox(height: 32),
        Expanded(
          child: Selector<RoomManagerProvider, List<RoomManagerModel>>(
            selector: (_, provider) => provider.offlineData,
            builder: (_, data, __) {
              return GridView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.3,
                ),
                itemBuilder: (context, index) {
                  RoomManagerModel item = data[index];
                  return GestureDetector(
                    onTap: () {
                      // widget.room = item;
                      Dialogs.showChoiceDialog(
                        title: "Choisissez un service",
                        content: Column(
                          children: [
                            ...List.generate(item.services!.length, (
                              servIndex,
                            ) {
                              return Container(
                                margin: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.kWhiteColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ListTile(
                                  // tileColor: AppColors.kWhiteColor,
                                  onTap: () {
                                    widget.room = item;
                                    setState(() {});

                                    Navigator.pop(context);
                                    widget.callback(
                                      item,
                                      item.services![servIndex],
                                    );
                                  },
                                  title: TextWidgets.textBold(
                                    title: item.services?[servIndex].name ?? '',
                                    fontSize: 16,
                                    textColor: AppColors.kBlackColor,
                                  ),
                                  subtitle: TextWidgets.text300(
                                    title:
                                        item.services?[servIndex].description ??
                                        '',
                                    fontSize: 12,
                                    textColor: AppColors.kBlackColor,
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: widget.room?.uuid == item.uuid
                            ? AppColors.kGreyColor.withAlpha(144)
                            : AppColors.kTextFormBackColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Icon(Icons.house_siding_rounded, size: 48),
                          Row(
                            children: [
                              Expanded(
                                child: TextWidgets.textBold(
                                  maxLines: 2,
                                  title: item.room?.name ?? '',
                                  fontSize: 16,
                                  textColor: AppColors.kBlackColor,
                                ),
                              ),
                              Icon(
                                Icons.check_circle_rounded,
                                color: widget.room?.uuid == item.uuid
                                    ? AppColors.kPrimaryColor
                                    : Colors.transparent,
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          TextWidgets.textWithIcon(
                            applyPadding: false,
                            icon: Icons.calendar_month,
                            title: parseDate(
                              date: item.date ?? '',
                            ).toString().substring(0, 10),
                            fontSize: 14,
                            textColor: AppColors.kBlackColor,
                          ),
                          const SizedBox(height: 8),
                          TextWidgets.textWithIcon(
                            applyPadding: false,
                            icon: Icons.watch_later,
                            title:
                                "${item.room?.openedAt ?? ''} - ${item.room?.closedAt ?? ''}",
                            fontSize: 14,
                            textColor: AppColors.kBlackColor.withAlpha(180),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
