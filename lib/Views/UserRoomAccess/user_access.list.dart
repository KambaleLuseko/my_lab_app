import 'package:flutter/material.dart';
import 'package:my_lab_app/Resources/Components/build_table.dart';
import 'package:my_lab_app/Resources/Components/dialogs.dart';
import 'package:my_lab_app/Resources/Providers/users_provider.dart';
import 'package:my_lab_app/Views/RoomManager/controller/room_manager.provider.dart';
import 'package:my_lab_app/Views/Rooms/controller/room.provider.dart';
import 'package:my_lab_app/Views/UserRoomAccess/controller/user_access.provider.dart';
import 'package:my_lab_app/Views/UserRoomAccess/model/user_access.model.dart';
import 'package:provider/provider.dart';

class UserAccessRoomListPage extends StatefulWidget {
  const UserAccessRoomListPage({super.key});

  @override
  State<UserAccessRoomListPage> createState() => _UserAccessRoomListPageState();
}

class _UserAccessRoomListPageState extends State<UserAccessRoomListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserAccessProvider>().getOffline();
      context.read<UserProvider>().getOffline(isRefresh: true);
      context.read<RoomProvider>().getOffline(isRefresh: true);
      context.read<RoomManagerProvider>().getOffline(isRefresh: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Selector<UserAccessProvider, List<UserAccessModel>>(
      selector: (_, provider) => provider.offlineData,
      builder: (_, data, __) {
        return Column(
          children: [
            Flexible(
              child: BuildTable.generateTable(
                icon: Icons.door_sliding_outlined,
                columns: [
                  "name",
                  "salle",
                  "statut",
                  'services',
                  'date',
                  "debut",
                  "fin",
                ],

                rows: data
                    .map(
                      (e) => {
                        ...e.toJson(),
                        "name": e.user?.name ?? '',
                        "salle":
                            '${e.room?.name} (${e.startTime ?? ''}-${e.endTime ?? ''})',
                        "date": e.date,
                        "debut": e.startTime ?? '',
                        "fin": e.endTime ?? '',
                        "statut": e.status ?? '',
                        "services": e.service?.name ?? '',
                      },
                    )
                    .toList(),
                editCallback: (value) {
                  UserAccessModel item = UserAccessModel.fromJson(value);
                  if (item.status?.toLowerCase().trim() != 'pending') {
                    Dialogs.showDialogNoAction(
                      title: "Information",
                      content: "Cette demande a déjà etait traitée",
                    );
                    return;
                  }
                  Dialogs.showDialogWithAction(
                    title: "Confirmation",
                    content:
                        "Vous allez approuver l'acces de ${item.user?.name} au labo ${item.room?.name}.\nCliquez pour confirmer",
                    callback: () {
                      context.read<UserAccessProvider>().approveRequest(
                        data: [item],
                        callback: () {},
                      );
                    },
                  );
                },
                editIcon: Icons.approval_rounded,
              ),
            ),
          ],
        );
      },
    );
  }
}
