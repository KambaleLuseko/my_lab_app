// import 'dart:convert';

// import 'package:flutter/material.dart';

// // import 'package:place_picker/place_picker.dart';

// import '../../Views/Order/model/location.model.dart';
// import '../Constants/global_variables.dart';
// import 'texts.dart';

// class CustomSearchDelegate extends SearchDelegate<String> {
//   final List data;
//   final String searchColumn;
//   final String? secondSearchColumn, auxilaryColumn;
//   String? subtitle;
//   final IconData icon;
//   final bool canSearchMap;
//   final bool? canReturnQuery;
//   LocationModel? previousLocation;
//   CustomSearchDelegate({
//     required this.data,
//     required this.searchColumn,
//     required this.icon,
//     this.subtitle,
//     required this.canSearchMap,
//     this.canReturnQuery,
//     this.previousLocation,
//     this.secondSearchColumn,
//     this.auxilaryColumn,
//   });

//   @override
//   String get searchFieldLabel => "Search here...";
//   LocationModel? pickedLocation;

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: const Icon(Icons.clear),
//         onPressed: () {
//           query = "";
//         },
//       ),
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: const Icon(Icons.arrow_back_ios),
//       onPressed: () {
//         if (canReturnQuery != null && canReturnQuery == true) {
//           close(context, jsonEncode(query));
//           return;
//         }
//         close(context, "");
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return const Column();
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     final suggestions =
//         query.isEmpty
//             ? data
//             : data
//                 .where(
//                   (element) =>
//                       element[searchColumn].toString().toLowerCase().contains(
//                         query.toLowerCase(),
//                       ) ||
//                       element[secondSearchColumn ?? '']
//                           .toString()
//                           .toLowerCase()
//                           .contains(query.toLowerCase()) ||
//                       element[auxilaryColumn ?? '']
//                           .toString()
//                           .toLowerCase()
//                           .contains(query.toLowerCase()),
//                 )
//                 .toList();
//     return ListView(
//       children: [
//         ListView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: suggestions.length,
//           itemBuilder:
//               (content, index) => Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: AppColors.kWhiteColor,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: ListTile(
//                   onTap: () {
//                     Map sentData = {"isMap": false};
//                     sentData.addAll(suggestions[index]);
//                     close(context, jsonEncode(sentData));
//                   },
//                   leading: Icon(icon),
//                   title: TextWidgets.textBold(
//                     title: suggestions[index][searchColumn],
//                     fontSize: 14,
//                     textColor: AppColors.kBlackColor,
//                   ),
//                   subtitle: Text(suggestions[index][subtitle] ?? ''),
//                   trailing:
//                       auxilaryColumn != null && auxilaryColumn!.isNotEmpty
//                           ? Text(suggestions[index][auxilaryColumn] ?? '')
//                           : null,
//                 ),
//               ),
//         ),
//         pickedLocation != null
//             ? const Divider(color: Colors.black54)
//             : Container(),
//         pickedLocation != null
//             ? ListTile(
//               onTap: () {
//                 Map sentData = {
//                   "isMap": true,
//                   "lat": pickedLocation!.lat.toString(),
//                   "long": pickedLocation!.long.toString(),
//                 };
//                 close(context, jsonEncode(sentData));
//               },
//               leading: const Icon(Icons.check_circle_outline_rounded),
//               title: const Text(
//                 "Position récupérée",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text(
//                 "${pickedLocation!.lat} - ${pickedLocation!.long}",
//               ),
//               trailing: Icon(
//                 Icons.arrow_forward_ios_rounded,
//                 color: AppColors.kGreyColor,
//               ),
//               tileColor: AppColors.kBlackLightColor,
//             )
//             : Container(),
//       ],
//     );
//   }
// }
