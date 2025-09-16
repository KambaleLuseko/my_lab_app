import 'package:flutter/material.dart';
import 'package:my_lab_app/Resources/Components/build_table.dart';
import 'package:my_lab_app/Views/Rooms/controller/room.provider.dart';
import 'package:my_lab_app/Views/Rooms/model/room.model.dart';
import 'package:provider/provider.dart';

class RoomListPage extends StatefulWidget {
  const RoomListPage({super.key});

  @override
  State<RoomListPage> createState() => _RoomListPageState();
}

class _RoomListPageState extends State<RoomListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RoomProvider>().getOffline();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Selector<RoomProvider, List<RoomModel>>(
      selector: (_, provider) => provider.offlineData,
      builder: (_, data, __) {
        return Column(
          children: [
            Flexible(
              child: BuildTable.generateTable(
                icon: Icons.person_3_rounded,
                columns: [
                  "name",
                  "capacite",
                  "statut",
                  "ouverture",
                  "fermeture",
                ],
                rows: data
                    .map(
                      (e) => {
                        ...e.toJson(),
                        "name": e.name,
                        "capacite": '${e.capacity} personnes',
                        "ouverture": e.openedAt,
                        "fermeture": e.closedAt,
                        "statut": e.status ?? '',
                      },
                    )
                    .toList(),
                editCallback: (value) {},
                deleteCallback: (value) {},
              ),
            ),
          ],
        );
      },
    );
  }
}
