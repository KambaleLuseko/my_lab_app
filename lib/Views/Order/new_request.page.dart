import 'package:flutter/material.dart';
import 'package:my_lab_app/Resources/Components/button.dart';
import 'package:my_lab_app/Resources/Components/dialogs.dart';
import 'package:my_lab_app/Resources/Constants/enums.dart';
import 'package:my_lab_app/Resources/Constants/global_variables.dart';
import 'package:my_lab_app/Resources/Providers/users_provider.dart';
import 'package:my_lab_app/Views/Order/widgets/choose_rooms.widget.dart';
import 'package:my_lab_app/Views/Order/widgets/choose_time.widget.dart';
import 'package:my_lab_app/Views/Order/widgets/resume.widget.dart';
import 'package:my_lab_app/Views/RoomManager/model/room_manager.model.dart';
import 'package:my_lab_app/Views/Services/model/service.model.dart';
import 'package:my_lab_app/Views/UserRoomAccess/controller/user_access.provider.dart';
import 'package:my_lab_app/Views/UserRoomAccess/model/user_access.model.dart';
import 'package:provider/provider.dart';

class ClientRoomAccessRequest extends StatefulWidget {
  const ClientRoomAccessRequest({super.key});

  @override
  State<ClientRoomAccessRequest> createState() =>
      _ClientRoomAccessRequestState();
}

class _ClientRoomAccessRequestState extends State<ClientRoomAccessRequest> {
  PageController _pageCtrller = PageController();
  @override
  void initState() {
    super.initState();

    chooseRoomWidget = ChooseRoomWidget(
      callback: (value, serv) {
        room = value;
        service = serv;
        setState(() {});
      },
    );
    _pageCtrller = PageController(initialPage: 0);
    access = UserAccessModel();
    resumeWidget = ResumeWidget(access: access, manager: room);
    pages = [chooseRoomWidget, chooseAccessTimeWidget, resumeWidget];
    setState(() {});
  }

  RoomManagerModel? room;
  UserAccessModel? access;
  ServiceModel? service;
  late ChooseRoomWidget chooseRoomWidget;
  late ChooseAccessTimeWidget chooseAccessTimeWidget = ChooseAccessTimeWidget(
    startTime: access?.startTime ?? "",
    endTime: access?.endTime ?? "",
  );
  late ResumeWidget resumeWidget;
  int currentPage = 0;

  changePage(int page) {
    _pageCtrller.animateToPage(
      page,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  List<Widget> pages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.kScaffoldColor,
      // appBar: AppBar(
      //   backgroundColor: AppColors.kWhiteColor,
      //   title: Text("Nouvelle demande"),
      // ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              physics: BouncingScrollPhysics(),
              controller: _pageCtrller,
              children: [
                chooseRoomWidget,
                chooseAccessTimeWidget,
                ResumeWidget(access: access, manager: room),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: "Precedent",
                    backColor: AppColors.kTextFormBackColor,
                    textColor: AppColors.kBlackColor,
                    callback: () {
                      if (currentPage > 0) {
                        currentPage--;
                        changePage(currentPage);
                        setState(() {});
                      }
                    },
                  ),
                ),
                Expanded(
                  child: CustomButton(
                    text: currentPage >= pages.length - 1
                        ? "Confirmer"
                        : "Suivant",
                    backColor: AppColors.kPrimaryColor,
                    textColor: AppColors.kWhiteColor,
                    callback: () {
                      if (currentPage <= pages.length - 1) {
                        ///
                        /// First page data validation
                        ///
                        if (currentPage == 0) {
                          if (room == null || service == null) {
                            ToastNotification.showToast(
                              msg: "Veuillez choisir la salle et le service",
                              msgType: MessageType.error,
                              title: 'Données invalides',
                            );
                          }
                          access
                            ?..roomUuid = room?.roomUuid
                            ..room = room?.room
                            ..service = service
                            ..serviceUuid = service?.uuid
                            ..date = room?.date
                            ..userUuid = context
                                .read<UserProvider>()
                                .userLogged
                                ?.user
                                .uuid
                            ..user = context
                                .read<UserProvider>()
                                .userLogged
                                ?.user;
                          resumeWidget = ResumeWidget(
                            access: access,
                            manager: room,
                          );
                          currentPage++;
                          changePage(currentPage);
                          setState(() {});
                        }
                        ///
                        /// Second page data validation
                        ///
                        else if (currentPage == 1) {
                          if (chooseAccessTimeWidget.startTime.isEmpty) {
                            ToastNotification.showToast(
                              msg:
                                  "Veuillez choisir l'heure de debut de la session",
                              msgType: MessageType.error,
                              title: 'Heure invalide',
                            );
                          }
                          if (chooseAccessTimeWidget.endTime.isEmpty) {
                            ToastNotification.showToast(
                              msg:
                                  "Veuillez choisir l'heure de fin de la session",
                              msgType: MessageType.error,
                              title: 'Heure invalide',
                            );
                          }
                          if (TimeOfDay(
                            hour: int.parse(
                              chooseAccessTimeWidget.startTime.split(':').first,
                            ),
                            minute: int.parse(
                              chooseAccessTimeWidget.startTime.split(':').last,
                            ),
                          ).isBefore(
                            TimeOfDay(
                              hour: int.parse(
                                room!.room!.openedAt!.split(':').first,
                              ),
                              minute: int.parse(
                                room!.room!.openedAt!.split(':').last,
                              ),
                            ),
                          )) {
                            ToastNotification.showToast(
                              msg:
                                  "La salle ouvre a ${room!.room!.openedAt}.\nL'heure de debut doit etre superieur a l'heure d'ouverture de la salle",
                              msgType: MessageType.error,
                              title: 'Erreur',
                            );
                            return;
                          }

                          if (TimeOfDay(
                            hour: int.parse(
                              chooseAccessTimeWidget.startTime.split(':').first,
                            ),
                            minute: int.parse(
                              chooseAccessTimeWidget.startTime.split(':').last,
                            ),
                          ).isAfter(
                            TimeOfDay(
                              hour: int.parse(
                                room!.room!.closedAt!.split(':').first,
                              ),
                              minute: int.parse(
                                room!.room!.closedAt!.split(':').last,
                              ),
                            ),
                          )) {
                            ToastNotification.showToast(
                              msg:
                                  "La salle ferme a ${room!.room!.closedAt}.\nL'heure de fin doit etre inferieur a l'heure de fermeture de la salle",
                              msgType: MessageType.error,
                              title: 'Erreur',
                            );
                            return;
                          }
                          access
                            ?..startTime = chooseAccessTimeWidget.startTime
                            ..endTime = chooseAccessTimeWidget.endTime;
                          currentPage++;
                          changePage(currentPage);
                          setState(() {});
                        } else {
                          Dialogs.showDialogWithAction(
                            title: "Confirmation",
                            content:
                                "Nous allons enregistrer votre demande d'accès, veuillez confirmer!",
                            callback: () {
                              context.read<UserAccessProvider>().save(
                                data: access!,
                                callback: () {
                                  Navigator.pop(context);
                                },
                              );
                            },
                          );
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
