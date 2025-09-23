import 'package:flutter/material.dart';
import 'package:my_lab_app/Resources/Components/button.dart';
import 'package:my_lab_app/Resources/Components/decorated_container.dart';
import 'package:my_lab_app/Resources/Components/dialogs.dart';
import 'package:my_lab_app/Resources/Components/text_fields.dart';
import 'package:my_lab_app/Resources/Components/texts.dart';
import 'package:my_lab_app/Resources/Constants/enums.dart';
import 'package:my_lab_app/Resources/Constants/global_variables.dart';
import 'package:my_lab_app/Resources/Helpers/date_parser.dart';
import 'package:my_lab_app/Resources/Models/user.model.dart';
import 'package:my_lab_app/Resources/Providers/users_provider.dart';
import 'package:my_lab_app/Views/RoomManager/add_manager.page.dart';
import 'package:my_lab_app/Views/RoomManager/controller/room_manager.provider.dart';
import 'package:my_lab_app/Views/RoomManager/model/room_manager.model.dart';
import 'package:my_lab_app/Views/Rooms/controller/room.provider.dart';
import 'package:my_lab_app/Views/Rooms/model/room.model.dart';
import 'package:my_lab_app/Views/Services/model/service.model.dart';
import 'package:my_lab_app/Views/UserRoomAccess/controller/user_access.provider.dart';
import 'package:my_lab_app/Views/UserRoomAccess/model/user_access.model.dart';
import 'package:provider/provider.dart';

class AddUserAccessRoomP extends StatefulWidget {
  const AddUserAccessRoomP({super.key});

  @override
  State<AddUserAccessRoomP> createState() => Add_UserAccessRoomPState();
}

class Add_UserAccessRoomPState extends State<AddUserAccessRoomP> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().getOffline(isRefresh: true);
      context.read<RoomProvider>().getOffline(isRefresh: true);
      context.read<RoomManagerProvider>().getOffline(isRefresh: true);
    });
  }

  UserModel? user;
  RoomModel? room;
  RoomManagerModel? roomManager;
  ServiceModel? service;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Center(
            child: TextWidgets.textBold(
              title: "Ajouter un accès",
              fontSize: 16,
              textColor: AppColors.kBlackColor,
            ),
          ),
          const SizedBox(height: 24),
          ItemSelectorWidget(
            icon: Icons.person,
            displayColumn: 'name',
            secondaryColumn: 'email',
            title: 'Demandeur',
            data: context
                .read<UserProvider>()
                .offlineData
                .where(
                  (e) =>
                      e.role?.toLowerCase() == 'etudiant' ||
                      e.role?.toLowerCase() == 'visiteur',
                )
                .map((e) => e.toJson())
                .toList(),
            callback: (item) {
              setState(() {
                user = UserModel.fromJson(item);
              });
            },
          ),
          ItemSelectorWidget(
            icon: Icons.home,
            displayColumn: 'name',
            secondaryColumn: 'capacity',
            metric: 'personnes',
            title: 'Salle',
            data: context
                .read<RoomProvider>()
                .offlineData
                .map((e) => e.toJson())
                .toList(),
            callback: (item) {
              setState(() {
                room = RoomModel.fromJson(item);
                roomManager = null;
              });
            },
          ),
          if (room != null)
            ItemSelectorWidget(
              icon: Icons.watch_later_outlined,
              displayColumn: 'manager',
              secondaryColumn: 'dateEvent',
              // metric: 'personnes',
              title: 'Date',
              data: context
                  .read<RoomManagerProvider>()
                  .offlineData
                  .where((e) => e.roomUuid == room?.uuid)
                  .toList()
                  .map(
                    (e) => {
                      ...e.toJson(),
                      'manager': e.user?.name ?? '',
                      'dateEvent': parseDate(
                        date: e.date ?? '',
                      ).toString().substring(0, 10),
                      'date': e.date,
                      'id': e.id,
                      'user_uuid': e.userUuid,
                      'room_uuid': e.roomUuid,
                      'uuid': e.uuid,
                      'user': e.user?.toJson(),
                    },
                  )
                  .toList(),
              callback: (item) {
                setState(() {
                  roomManager = RoomManagerModel.fromJson(item);
                });
              },
            ),
          if (roomManager != null)
            ItemSelectorWidget(
              icon: Icons.category_rounded,
              displayColumn: 'name',
              secondaryColumn: 'description',
              // metric: 'personnes',
              title: 'Service',
              data: roomManager!.services!
                  .toList()
                  .map((e) => e.toJson())
                  .toList(),
              callback: (item) {
                setState(() {
                  service = ServiceModel.fromJson(item);
                });
              },
            ),
          GestureDetector(
            onTap: () => _pickTime(context, true),
            child: AbsorbPointer(
              child: TextFormFieldWidget(
                editCtrller: _openedAtController,
                labelText: 'Debut',
                hintText: "eg: 10:00",
                backColor: AppColors.kTextFormBackColor,
                textColor: AppColors.kBlackColor,
              ),
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () => _pickTime(context, false),
            child: AbsorbPointer(
              child: TextFormFieldWidget(
                editCtrller: _closedAtController,
                labelText: 'Fin',
                hintText: "eg: 16:00",
                backColor: AppColors.kTextFormBackColor,
                textColor: AppColors.kBlackColor,
              ),
            ),
          ),

          CustomButton(
            text: "Enregistrer",
            backColor: AppColors.kPrimaryColor,
            textColor: AppColors.kWhiteColor,
            callback: () {
              if (user?.uuid == null ||
                  room?.uuid == null ||
                  _openedAtController.text.trim().isEmpty ||
                  _closedAtController.text.trim().isEmpty) {
                ToastNotification.showToast(
                  msg: "Veuillez remplir tous les champs",
                  msgType: MessageType.error,
                  title: 'Erreur',
                );
                return;
              }
              if (roomManager?.date == null) {
                ToastNotification.showToast(
                  msg:
                      "Veuillez choisir un creneau pour la salle ${room?.name}",
                  msgType: MessageType.error,
                  title: 'Erreur',
                );
                return;
              }
              if (TimeOfDay(
                hour: int.parse(_openedAtController.text.split(':').first),
                minute: int.parse(_openedAtController.text.split(':').last),
              ).isBefore(
                TimeOfDay(
                  hour: int.parse(room!.openedAt!.split(':').first),
                  minute: int.parse(room!.openedAt!.split(':').last),
                ),
              )) {
                ToastNotification.showToast(
                  msg:
                      "La salle ouvre a ${room?.openedAt}.\nL'heure de debut doit etre superieur a l'heure d'ouverture de la salle",
                  msgType: MessageType.error,
                  title: 'Erreur',
                );
                return;
              }

              if (TimeOfDay(
                hour: int.parse(_closedAtController.text.split(':').first),
                minute: int.parse(_closedAtController.text.split(':').last),
              ).isAfter(
                TimeOfDay(
                  hour: int.parse(room!.closedAt!.split(':').first),
                  minute: int.parse(room!.closedAt!.split(':').last),
                ),
              )) {
                ToastNotification.showToast(
                  msg:
                      "La salle ferme a ${room?.closedAt}.\nL'heure de fin doit etre inferieur a l'heure de fermeture de la salle",
                  msgType: MessageType.error,
                  title: 'Erreur',
                );
                return;
              }
              Dialogs.showBottomModalSheet(
                content: ListView(
                  shrinkWrap: true,
                  children: [
                    DecoratedContainer(
                      applyMargin: true,
                      backColor: AppColors.kTransparentColor,
                      child: Column(
                        children: [
                          TextWidgets.textHorizontalWithLabel(
                            title: "Demandeur",
                            fontSize: 14,
                            textColor: AppColors.kBlackColor,
                            value: user?.name ?? '',
                          ),
                          TextWidgets.textHorizontalWithLabel(
                            title: "Salle",
                            fontSize: 14,
                            textColor: AppColors.kBlackColor,
                            value: room?.name ?? '',
                          ),
                          TextWidgets.textHorizontalWithLabel(
                            title: "Service",
                            fontSize: 14,
                            textColor: AppColors.kBlackColor,
                            value: service?.name ?? '',
                          ),
                          TextWidgets.textHorizontalWithLabel(
                            title: "Gestionnaire",
                            fontSize: 14,
                            textColor: AppColors.kBlackColor,
                            value: roomManager?.user?.name ?? '',
                          ),
                          TextWidgets.textHorizontalWithLabel(
                            title: "Date",
                            fontSize: 14,
                            textColor: AppColors.kBlackColor,
                            value: parseDate(
                              date: roomManager?.date ?? '',
                            ).toString().substring(0, 10),
                          ),
                          TextWidgets.textHorizontalWithLabel(
                            title: "Crenau",
                            fontSize: 14,
                            textColor: AppColors.kBlackColor,
                            value:
                                '${_openedAtController.text.trim()} - ${_closedAtController.text.trim()}',
                          ),
                          const SizedBox(height: 16),
                          CustomButton(
                            text: "Valider",
                            backColor: AppColors.kPrimaryColor,
                            textColor: AppColors.kWhiteColor,
                            callback: () {
                              UserAccessModel data = UserAccessModel(
                                userUuid: user?.uuid,
                                roomUuid: roomManager?.roomUuid,
                                date: roomManager?.date,
                                startTime: _openedAtController.text.trim(),
                                endTime: _closedAtController.text.trim(),
                                status: 'Pending',
                                serviceUuid: service?.uuid,
                              );
                              Navigator.pop(context);
                              context.read<UserAccessProvider>().save(
                                data: data,
                                callback: () {
                                  Navigator.pop(context);
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  final _openedAtController = TextEditingController();
  final _closedAtController = TextEditingController();

  // Pickers will handle time selection
  TimeOfDay? _selectedOpenedTime;
  TimeOfDay? _selectedClosedTime;

  Future<void> _pickTime(BuildContext context, bool isOpenedAt) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
      context: context,
      initialTime: isOpenedAt
          ? _selectedOpenedTime ?? TimeOfDay.now()
          : _selectedClosedTime ?? TimeOfDay.now(),
    );
    if (pickedTime != null) {
      final MaterialLocalizations localizations = MaterialLocalizations.of(
        context,
      );

      // Explicitly format the picked time into a 24-hour string
      final String formattedTime = localizations.formatTimeOfDay(
        pickedTime,
        alwaysUse24HourFormat: true,
      );

      if (isOpenedAt) {
        setState(() {
          _selectedOpenedTime = pickedTime;
          _openedAtController.text = formattedTime;
        });
      } else {
        setState(() {
          _selectedClosedTime = pickedTime;
          _closedAtController.text = formattedTime;
        });
      }
    }
  }
}
