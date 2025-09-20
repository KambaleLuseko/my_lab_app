import 'package:flutter/material.dart';
import 'package:my_lab_app/Resources/Components/build_table.dart';
import 'package:my_lab_app/Resources/Providers/users_provider.dart';
import 'package:my_lab_app/Views/RoomManager/controller/room_manager.provider.dart';
import 'package:my_lab_app/Views/RoomManager/model/room_manager.model.dart';
import 'package:my_lab_app/Views/Rooms/controller/room.provider.dart';
import 'package:provider/provider.dart';

class RoomManagerListPage extends StatefulWidget {
  const RoomManagerListPage({super.key});

  @override
  State<RoomManagerListPage> createState() => _RoomManagerListPageState();
}

class _RoomManagerListPageState extends State<RoomManagerListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RoomManagerProvider>().getOffline();
      context.read<UserProvider>().getOffline(isRefresh: true);
      context.read<RoomProvider>().getOffline(isRefresh: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Selector<RoomManagerProvider, List<RoomManagerModel>>(
      selector: (_, provider) => provider.offlineData,
      builder: (_, data, __) {
        return Column(
          children: [
            Flexible(
              child: BuildTable.generateTable(
                icon: Icons.door_sliding_outlined,
                columns: [
                  "name",
                  "capacite",
                  'date',
                  "statut",

                  // "ouverture",
                  // "fermeture",
                ],
                rows: data
                    .map(
                      (e) => {
                        ...e.toJson(),
                        "name": e.user?.name ?? '',
                        "capacite":
                            '${e.room?.name} - ${e.room?.capacity} personnes',
                        "date": e.date?.toString() ?? '',
                        "statut": e.status ?? '',
                      },
                    )
                    .toList(),
                // editCallback: (value) {},
                // deleteCallback: (value) {},
              ),
            ),
          ],
        );
      },
    );
  }
}
