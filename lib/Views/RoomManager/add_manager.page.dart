import 'package:flutter/material.dart';
import 'package:my_lab_app/Resources/Components/button.dart';
import 'package:my_lab_app/Resources/Components/date_picket.dart';
import 'package:my_lab_app/Resources/Components/dialogs.dart';
import 'package:my_lab_app/Resources/Components/list_item.dart';
import 'package:my_lab_app/Resources/Components/text_fields.dart';
import 'package:my_lab_app/Resources/Components/texts.dart';
import 'package:my_lab_app/Resources/Constants/enums.dart';
import 'package:my_lab_app/Resources/Constants/global_variables.dart';
import 'package:my_lab_app/Resources/Models/user.model.dart';
import 'package:my_lab_app/Resources/Providers/users_provider.dart';
import 'package:my_lab_app/Views/RoomManager/controller/room_manager.provider.dart';
import 'package:my_lab_app/Views/RoomManager/model/room_manager.model.dart';
import 'package:my_lab_app/Views/Rooms/controller/room.provider.dart';
import 'package:my_lab_app/Views/Rooms/model/room.model.dart';
import 'package:provider/provider.dart';

class AddRoomManagerPage extends StatefulWidget {
  const AddRoomManagerPage({super.key});

  @override
  State<AddRoomManagerPage> createState() => _AddRoomManagerPageState();
}

class _AddRoomManagerPageState extends State<AddRoomManagerPage> {
  final _dateCtrller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  UserModel? manager;
  RoomModel? room;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Center(
            child: TextWidgets.textBold(
              title: "Ajouter un gestionnaire",
              fontSize: 16,
              textColor: AppColors.kBlackColor,
            ),
          ),
          const SizedBox(height: 24),
          ItemSelectorWidget(
            icon: Icons.person,
            displayColumn: 'name',
            secondaryColumn: 'email',
            title: 'Gestionnaire',
            data: context
                .read<UserProvider>()
                .offlineData
                .map((e) => e.toJson())
                .toList(),
            callback: (item) {
              setState(() {
                manager = UserModel.fromJson(item);
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
              });
            },
          ),
          GestureDetector(
            onTap: () async {
              await showDatePicketCustom(
                isPastDate: false,
                callback: (value) {
                  if (value == null) return;
                  _dateCtrller.text = value.toString().substring(0, 10);
                  setState(() {});
                },
              );
            },
            child: TextFormFieldWidget(
              editCtrller: _dateCtrller,
              isEnabled: false,
              isBordered: false,
              isObsCured: false,
              hintText: 'eg: 2025-05-05',
              labelText: 'Date ouverture',
              textColor: AppColors.kBlackColor,
              backColor: AppColors.kTextFormBackColor,
            ),
          ),
          CustomButton(
            text: 'Enregistrer',
            backColor: AppColors.kPrimaryColor,
            textColor: AppColors.kWhiteColor,
            callback: () {
              if (_dateCtrller.text.isEmpty ||
                  DateTime.tryParse(_dateCtrller.text.trim()) == null ||
                  manager == null ||
                  room == null) {
                ToastNotification.showToast(
                  msg: "Veuillez remplir tous les champs",
                  msgType: MessageType.error,
                );
                return;
              }
              if (room?.uuid == null || manager?.uuid == null) {
                ToastNotification.showToast(
                  msg: "Veuillez remplir tous les champs",
                  msgType: MessageType.error,
                );
                return;
              }
              context.read<RoomManagerProvider>().save(
                data: RoomManagerModel(
                  roomUuid: room!.uuid,
                  userUuid: manager!.uuid,
                  date: _dateCtrller.text,
                  // room: room,
                  // user: manager,
                ),
                callback: () {
                  Navigator.pop(context);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class ItemSelectorWidget extends StatefulWidget {
  const ItemSelectorWidget({
    super.key,
    required this.title,
    required this.data,
    required this.callback,
    this.displayColumn,
    this.secondaryColumn,
    this.metric,
    this.icon,
  });
  final String title;
  final List<Map> data;
  final Function(Map) callback;
  final String? displayColumn, secondaryColumn, metric;
  final IconData? icon;
  @override
  State<ItemSelectorWidget> createState() => _ItemSelectorWidgetState();
}

class _ItemSelectorWidgetState extends State<ItemSelectorWidget> {
  Map? selectedItem;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Dialogs.showChoiceDialog(
          title: widget.title,
          content: Column(
            children: [
              ...List.generate(widget.data.length, (index) {
                Map item = widget.data[index];
                return GestureDetector(
                  onTap: () async {
                    selectedItem = item;
                    widget.callback(item);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  child: ListItem(
                    icon: widget.icon,
                    title: item[widget.displayColumn ?? 'name'] ?? '',
                    subtitle:
                        (item[widget.secondaryColumn ?? 'email'] ?? '') +
                        " ${(widget.metric ?? "")}",
                    backColor: AppColors.kTextFormBackColor,
                    textColor: AppColors.kBlackColor,
                    detailsFields: [],
                  ),
                );
              }),
            ],
          ),
        );
      },
      child: AbsorbPointer(
        child: ListItem(
          icon: widget.icon,
          title: selectedItem?[widget.displayColumn] ?? widget.title,
          subtitle:
              selectedItem?[widget.secondaryColumn] ??
              'Choisissez un.e ${widget.title.toLowerCase()}',
          backColor: AppColors.kTextFormBackColor,
          textColor: AppColors.kBlackColor,
          detailsFields: [],
        ),
      ),
    );
  }
}
