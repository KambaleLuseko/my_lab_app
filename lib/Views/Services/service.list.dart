import 'package:flutter/material.dart';
import 'package:my_lab_app/Resources/Components/build_table.dart';
import 'package:my_lab_app/Views/Services/controller/service.provider.dart';
import 'package:my_lab_app/Views/Services/model/service.model.dart';
import 'package:provider/provider.dart';

class ServiceListPage extends StatefulWidget {
  const ServiceListPage({super.key});

  @override
  State<ServiceListPage> createState() => _ServiceListPageState();
}

class _ServiceListPageState extends State<ServiceListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ServiceProvider>().getOffline();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Selector<ServiceProvider, List<ServiceModel>>(
      selector: (_, provider) => provider.offlineData,
      builder: (_, data, __) {
        return Column(
          children: [
            Flexible(
              child: BuildTable.generateTable(
                icon: Icons.person_3_rounded,
                columns: ["name", "salle", "capacite", "overture", "fermeture"],
                rows: data
                    .map(
                      (e) => {
                        ...e.toJson(),
                        "name": e.name,
                        "capacite": '${e.room?.capacity ?? 0} pers',
                        "salle": e.room?.name,
                        "overture": e.room?.openedAt,
                        "fermeture": e.room?.closedAt,
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
