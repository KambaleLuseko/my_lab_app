import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:my_lab_app/Resources/Components/dialogs.dart';
import 'package:my_lab_app/Resources/Constants/app_providers.dart';
import 'package:my_lab_app/Resources/Constants/enums.dart';
import 'package:my_lab_app/Resources/Constants/global_variables.dart';
import 'package:my_lab_app/Resources/Helpers/local_data.helper.dart';
import 'package:my_lab_app/Resources/Helpers/sync_online_local.dart';
import 'package:my_lab_app/Views/Rooms/model/room.model.dart';

class RoomProvider extends ChangeNotifier {
  String keyName = 'rooms';
  List<RoomModel> offlineData = [];

  save({
    required RoomModel data,
    EnumActions? action = EnumActions.save,
    required Function callback,
  }) async {
    if (data.name!.isEmpty || data.capacity! <= 0) {
      ToastNotification.showToast(
        msg: "Veuillez remplir tous les champs",
        msgType: MessageType.error,
        title: "Erreur",
      );
      return;
    }
    if (data.openedAt == null || data.closedAt == null) {
      ToastNotification.showToast(
        msg: "Veuillez remplir tous les champs",
        msgType: MessageType.error,
        title: 'Erreur',
      );
    }
    Response res;
    if (action == EnumActions.update) {
      res = await AppProviders.appProvider.httpPut(
        url: "${BaseUrl.rooms}/${data.id}",
        body: data.toJson(),
      );
    } else {
      res = await AppProviders.appProvider.httpPost(
        url: BaseUrl.rooms,
        body: data.toJson(),
      );
    }
    if (res.statusCode == 200 || res.statusCode == 201) {
      if (action == EnumActions.update) {
        ToastNotification.showToast(
          msg: "Utilisateur modifié avec succès",
          msgType: MessageType.success,
          title: "Success",
        );
        offlineData.where((element) => element.id == data.id).firstOrNull ==
            data;
        LocalDataHelper.saveData(value: data.toJson(), key: keyName);
        callback();
        getOffline(isRefresh: true);
        return;
      }

      RoomModel savedData = RoomModel.fromJson(jsonDecode(res.body));
      LocalDataHelper.saveData(key: keyName, value: savedData.toJson());
      ToastNotification.showToast(
        msg: jsonDecode(res.body)['message'] ?? "Salle ajoutée avec succès",
        msgType: MessageType.success,
        title: "Success",
      );
      callback();
      getOffline(isRefresh: true);
    }
    if (res.statusCode == 500) {
      // LocalDataHelper.saveData(key: keyName, value: data.toJson());
      ToastNotification.showToast(
        msg: jsonDecode(res.body)['message'] ?? 'Une erreur est survenue',
        msgType: MessageType.info,
        title: "Information",
      );
      return;
    }
    if (res.statusCode > 299 && res.statusCode != 500) {
      ToastNotification.showToast(
        msg:
            jsonDecode(res.body)['message'] ??
            'Une erreur est survenue, Veuillez réessayer',
        msgType: MessageType.error,
        title: "Erreur",
      );
      return;
    }
  }

  delete({required RoomModel data}) {
    Dialogs.showDialogWithAction(
      title: 'Confirmation',
      content:
          "Vous êtes sur le point de supprimer ${data.name ?? ''}.\nVoulez-vous continuer?",
      callback: () async {
        Response? res = await AppProviders.appProvider.httpDelete(
          url: "${BaseUrl.rooms}/${data.id ?? ''}",
        );
        if (res.statusCode == 200) {
          LocalDataHelper.deleteOne(key: keyName, data: data.toJson());
          ToastNotification.showToast(
            msgType: MessageType.success,
            msg: 'Information désactivée avec succès',
          );
          getOffline(isRefresh: true);
        } else {
          ToastNotification.showToast(
            msg: jsonDecode(res.body)['message'] is List
                ? jsonDecode(res.body)['message'].join(',').toString()
                : jsonDecode(res.body)['message'] ??
                      'Une erreur est survenue, Veuillez réessayer',
          );
        }
      },
    );
  }

  getOffline({bool? isRefresh = false}) async {
    if (isRefresh == false && offlineData.isNotEmpty) return;
    List data = await LocalDataHelper.getData(key: keyName);
    if (data.isEmpty && isRefresh == false) {
      get(isRefresh: isRefresh);
      return;
    }
    // print(data.length);
    offlineData = List<RoomModel>.from(
      data.map((item) => RoomModel.fromJson(item)).toList(),
    );
    notifyListeners();
  }

  get({bool? isRefresh = false}) async {
    if (isRefresh == false && offlineData.isNotEmpty) return;
    String url = BaseUrl.rooms;

    url = url;
    var response = await AppProviders.appProvider.httpGet(url: url);
    List data = [];
    if (response.statusCode == 200) {
      data = jsonDecode(response.body)['data'];
    }
    if (data.isEmpty) {
      offlineData = [];
      notifyListeners();
      return;
    }
    List<RoomModel> dataList = List<RoomModel>.from(
      data.map((item) {
        RoomModel singleItem = RoomModel.fromJson(item);
        return singleItem;
      }).toList(),
    );
    // print(dataList.length);
    LocalDataHelper.clearLocalData(key: keyName);
    getOffline(isRefresh: true);
    offlineData = dataList;
    SyncOnlineLocalHelper.insertNewDataOffline(
      onlineData: dataList.map((e) => e.toJson()).toList(),
      offlineData: offlineData.map((e) => e.toJson()).toList(),
      key: keyName,
      callback: () {
        getOffline(isRefresh: true);
      },
    );
    notifyListeners();
  }
}
