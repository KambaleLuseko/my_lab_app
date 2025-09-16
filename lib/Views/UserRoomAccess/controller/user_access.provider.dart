import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:my_lab_app/Resources/Components/dialogs.dart';
import 'package:my_lab_app/Resources/Constants/app_providers.dart';
import 'package:my_lab_app/Resources/Constants/enums.dart';
import 'package:my_lab_app/Resources/Constants/global_variables.dart';
import 'package:my_lab_app/Resources/Helpers/local_data.helper.dart';
import 'package:my_lab_app/Resources/Helpers/sync_online_local.dart';
import 'package:my_lab_app/Resources/Providers/app_state_provider.dart';
import 'package:my_lab_app/Views/UserRoomAccess/model/user_access.model.dart';
import 'package:my_lab_app/main.dart';
import 'package:provider/provider.dart';

class UserAccessProvider extends ChangeNotifier {
  final String keyName = 'user_access';

  List<UserAccessModel> offlineData = [];

  save({
    required UserAccessModel data,
    EnumActions? action = EnumActions.save,
    required Function callback,
  }) async {
    if (data.date!.isEmpty ||
        data.userUuid!.isEmpty ||
        data.roomUuid!.isEmpty) {
      ToastNotification.showToast(
        msg: "Veuillez remplir tous les champs",
        msgType: MessageType.error,
        title: "Erreur",
      );
      return;
    }
    if (data.startTime == null || data.endTime == null) {
      ToastNotification.showToast(
        msg: "Veuillez choisir le crenau de travail",
        msgType: MessageType.error,
        title: 'Erreur',
      );
    }
    Response res;
    if (action == EnumActions.update) {
      res = await AppProviders.appProvider.httpPut(
        url: "${BaseUrl.userAccessRooms}/${data.id}",
        body: data.toJson(),
      );
    } else {
      res = await AppProviders.appProvider.httpPost(
        url: BaseUrl.userAccessRooms,
        body: data.toJson(),
      );
    }
    if (res.statusCode == 200 || res.statusCode == 201) {
      if (action == EnumActions.update) {
        ToastNotification.showToast(
          msg: "Information modifiée avec succès",
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

      UserAccessModel savedData = UserAccessModel.fromJson(
        jsonDecode(res.body),
      );
      LocalDataHelper.saveData(key: keyName, value: savedData.toJson());
      ToastNotification.showToast(
        msg: ToastNotification.handleErrorMessage(
          message:
              jsonDecode(res.body)['message'] ??
              "Information ajoutée avec succès",
        ),
        msgType: MessageType.success,
        title: "Success",
      );
      callback();
      getOffline(isRefresh: true);
    }
    if (res.statusCode == 500) {
      // LocalDataHelper.saveData(key: keyName, value: data.toJson());
      ToastNotification.showToast(
        msg: ToastNotification.handleErrorMessage(
          message: jsonDecode(res.body)['message'] ?? 'Une erreur est survenue',
        ),
        msgType: MessageType.info,
        title: "Information",
      );
      return;
    }
    if (res.statusCode > 299 && res.statusCode != 500) {
      ToastNotification.showToast(
        msg: ToastNotification.handleErrorMessage(
          message:
              jsonDecode(res.body)['message'] ??
              'Une erreur est survenue, Veuillez réessayer',
        ),
        msgType: MessageType.error,
        title: "Erreur",
      );
      return;
    }
  }

  delete({required UserAccessModel data}) {
    Dialogs.showDialogWithAction(
      title: 'Confirmation',
      content:
          "Vous êtes sur le point de supprimer ${data.user ?? ''}.\nVoulez-vous continuer?",
      callback: () async {
        Response? res = await AppProviders.appProvider.httpDelete(
          url: "${BaseUrl.userAccessRooms}/${data.id ?? ''}",
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
            msg: ToastNotification.handleErrorMessage(
              message:
                  jsonDecode(res.body)['message'] ??
                  'Une erreur est survenue, Veuillez réessayer',
            ),
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
    offlineData = List<UserAccessModel>.from(
      data.map((item) => UserAccessModel.fromJson(item)).toList(),
    );
    notifyListeners();
  }

  get({bool? isRefresh = false}) async {
    if (isRefresh == false && offlineData.isNotEmpty) return;
    String url = BaseUrl.userAccessRooms;

    url = '$url?getUser=true&getRoom=true';
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
    List<UserAccessModel> dataList = List<UserAccessModel>.from(
      data.map((item) {
        UserAccessModel singleItem = UserAccessModel.fromJson(item);
        return singleItem;
      }).toList(),
    );
    // print(dataList.map((e) => e.toJson()).toList());
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

  approveRequest({
    required List<UserAccessModel> data,
    required Function callback,
  }) async {
    Response? res = await navKey.currentContext!
        .read<AppStateProvider>()
        .httpPost(
          url: '${BaseUrl.userAccessRooms}/approve',
          body: {"data": jsonEncode(data.map((e) => e.toJson()).toList())},
        );
    if (res.statusCode == 200 || res.statusCode == 201) {
      ToastNotification.showToast(
        msg: ToastNotification.handleErrorMessage(
          message:
              jsonDecode(res.body)['message'] ??
              "Information ajoutée avec succès",
        ),
        msgType: MessageType.success,
        title: "Success",
      );
      callback();
      get(isRefresh: true);
    } else if (res.statusCode == 500) {
      // LocalDataHelper.saveData(key: keyName, value: data.toJson());
      ToastNotification.showToast(
        msg: ToastNotification.handleErrorMessage(
          message: jsonDecode(res.body)['message'] ?? 'Une erreur est survenue',
        ),
        msgType: MessageType.info,
        title: "Information",
      );
      return;
    } else if (res.statusCode > 299 && res.statusCode != 500) {
      ToastNotification.showToast(
        msg: ToastNotification.handleErrorMessage(
          message:
              jsonDecode(res.body)['message'] ??
              'Une erreur est survenue, Veuillez réessayer',
        ),
        msgType: MessageType.error,
        title: "Erreur",
      );
      return;
    }
  }
}
