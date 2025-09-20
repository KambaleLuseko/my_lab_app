import 'package:flutter/material.dart';
import 'package:my_lab_app/Resources/Components/decorated_container.dart';
import 'package:my_lab_app/Resources/Components/texts.dart';
import 'package:my_lab_app/Resources/Constants/global_variables.dart';
import 'package:my_lab_app/Views/RoomManager/model/room_manager.model.dart';
import 'package:my_lab_app/Views/UserRoomAccess/model/user_access.model.dart';

class ResumeWidget extends StatelessWidget {
  const ResumeWidget({super.key, required this.access, required this.manager});
  final UserAccessModel? access;
  final RoomManagerModel? manager;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextWidgets.textBold(
          title: "Synthèse de la demande",
          fontSize: 18,
          textColor: AppColors.kBlackColor,
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              Container(
                margin: EdgeInsets.only(top: 24),
                child: TextWidgets.textBold(
                  title: "Demandeur",
                  fontSize: 16,
                  textColor: AppColors.kBlackColor,
                ),
              ),
              DecoratedContainer(
                applyMargin: false,
                backColor: AppColors.kScaffoldColor,
                child: Column(
                  children: [
                    TextWidgets.textHorizontalWithLabel(
                      title: "Nom",
                      value: access?.user?.name ?? '',
                      fontSize: 16,
                      textColor: AppColors.kBlackColor,
                    ),
                    TextWidgets.textHorizontalWithLabel(
                      title: "Email",
                      value: access?.user?.email ?? '',
                      fontSize: 16,
                      textColor: AppColors.kBlackColor,
                    ),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 24),

                child: TextWidgets.textBold(
                  title: "Objet",
                  fontSize: 16,
                  textColor: AppColors.kBlackColor,
                ),
              ),
              DecoratedContainer(
                applyMargin: false,
                backColor: AppColors.kScaffoldColor,
                child: Column(
                  children: [
                    TextWidgets.textHorizontalWithLabel(
                      title: "Labo",
                      value: "${access?.room?.name}",
                      fontSize: 16,
                      textColor: AppColors.kBlackColor,
                    ),
                    TextWidgets.textHorizontalWithLabel(
                      title: "Service",
                      value: access?.service?.name ?? '',
                      fontSize: 16,
                      textColor: AppColors.kBlackColor,
                    ),
                    TextWidgets.textHorizontalWithLabel(
                      title: "Gestionnaire",
                      value: " ${manager?.date ?? ''}",
                      fontSize: 16,
                      textColor: AppColors.kBlackColor,
                    ),
                    TextWidgets.textHorizontalWithLabel(
                      title: "Accesssibilite",
                      value:
                          "${access?.room?.openedAt} - ${access?.room?.closedAt}",
                      fontSize: 16,
                      textColor: AppColors.kBlackColor,
                    ),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 24),
                child: TextWidgets.textBold(
                  title: "Session",
                  fontSize: 16,
                  textColor: AppColors.kBlackColor,
                ),
              ),
              DecoratedContainer(
                applyMargin: false,
                backColor: AppColors.kScaffoldColor,
                child: Column(
                  children: [
                    TextWidgets.textHorizontalWithLabel(
                      title: "Date",
                      value: "${access?.date}",
                      fontSize: 16,
                      textColor: AppColors.kBlackColor,
                    ),
                    TextWidgets.textHorizontalWithLabel(
                      title: "Creneau",
                      value: "${access?.startTime} - ${access?.endTime}",
                      fontSize: 16,
                      textColor: AppColors.kBlackColor,
                    ),
                  ],
                ),
              ),

              // TextWidgets.textNormal(title: "Service: ${access?.service!.name}", fontSize: 16, textColor: AppColors.kBlackColor),
            ],
          ),
        ),
      ],
    );
  }
}
