import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:my_lab_app/Resources/Constants/navigators.dart';
import 'package:my_lab_app/Resources/Models/user.model.dart';
import 'package:my_lab_app/Views/Auth/login.page.dart';

import '../../main.dart';
import '../Components/dialogs.dart';
import '../Constants/app_providers.dart';
import '../Constants/enums.dart';
import '../Constants/global_variables.dart';
import '../Helpers/local_data.helper.dart';
import '../Helpers/sync_online_local.dart';

class UserProvider extends ChangeNotifier {
  String keyName = 'users';
  List<UserModel> offlineData = [];

  save({
    required UserModel data,
    EnumActions? action = EnumActions.save,
    required Function callback,
  }) async {
    if (data.name!.isEmpty || data.phone!.isEmpty) {
      ToastNotification.showToast(
        msg: "Veuillez remplir tous les champs",
        msgType: MessageType.error,
        title: "Erreur",
      );
      return;
    }
    if (data.promotion == null || data.anneeAcademique == null) {
      ToastNotification.showToast(
        msg: "Veuillez remplir tous les champs",
        msgType: MessageType.error,
        title: 'Erreur',
      );
      return;
    }
    if (data.anneeAcademique!.isEmpty) {
      if (data.role?.toLowerCase() == 'groupe' &&
          int.tryParse(data.anneeAcademique!) == null) {
        ToastNotification.showToast(
          msg: "Veuillez saisir un nombre d'etudiants valide",
          msgType: MessageType.error,
          title: 'Erreur',
        );
        return;
      }
      ToastNotification.showToast(
        msg: data.role?.toLowerCase() == 'groupe'
            ? "Veuillez saisir le nombre d'etudiants"
            : "Veuillez specifier l'annee academique",
        msgType: MessageType.error,
        title: 'Erreur',
      );
      return;
    }
    Response res;
    if (action == EnumActions.update) {
      res = await AppProviders.appProvider.httpPut(
        url: "${BaseUrl.user}/${data.id}",
        body: data.toJson(),
      );
    } else {
      res = await AppProviders.appProvider.httpPost(
        url: BaseUrl.user,
        body: data.toJson(),
      );
    }
    // print(res.body);
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

      UserModel savedData = UserModel.fromJson(jsonDecode(res.body));
      // savedData.syncStatus = 1;
      // userLogged?.society?.assets?.add(savedData);
      if (savedData.role?.toLowerCase() != 'client') {
        LocalDataHelper.saveData(key: keyName, value: savedData.toJson());
      }

      ToastNotification.showToast(
        msg: jsonDecode(res.body)['message'] ?? "Compte créé avec succès",
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

  delete({required UserModel data}) {
    Dialogs.showDialogWithAction(
      title: 'Confirmation',
      content:
          "Vous êtes sur le point de supprimer ${data.name ?? ''}.\nVoulez-vous continuer?",
      callback: () async {
        Response? res = await AppProviders.appProvider.httpDelete(
          url: "${BaseUrl.user}/${data.id ?? ''}",
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
    offlineData = List<UserModel>.from(
      data.map((item) => UserModel.fromJson(item)).toList(),
    );
    notifyListeners();
  }

  get({bool? isRefresh = false}) async {
    if (isRefresh == false && offlineData.isNotEmpty) return;
    String url = BaseUrl.user;

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
    List<UserModel> dataList = List<UserModel>.from(
      data.map((item) {
        UserModel singleItem = UserModel.fromJson(item);
        return singleItem;
      }).toList(),
    );

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

  // validateSearch({required List<UserModel> data}) {
  //   filteredData = data;
  //   notifyListeners();
  // }

  login({required Map data, required Function callback}) async {
    if (data['email'].isEmpty || data['password'].isEmpty) {
      ToastNotification.showToast(
        msg: "Veuillez remplir tous les champs",
        msgType: MessageType.error,
        title: "Erreur",
      );
      return;
    }
    // if (data['username'] == 'gen@g.com' && data['password'] == '1234') {
    //   callback();
    //   return;
    // }
    // print(query);
    Response res;
    res = await AppProviders.appProvider.httpPost(
      url: '${BaseUrl.user}/login',
      body: {...data},
    );
    // print(res.body);
    // return;
    if (res.statusCode == 200) {
      // print(res.body);
      Map decoded = jsonDecode(res.body);
      AuthModel authUser = AuthModel.fromJSON(decoded);
      // print(authUser.toJson());
      // if ((authUser.user.statut?.toLowerCase() ?? '').startsWith('active') ==
      //     false) {
      //   Navigation.pushNavigate(
      //       page: OTPPage(
      //           verificationWay: 'email',
      //           verificationValue: authUser.user.email ?? '',
      //           user: authUser.user,
      //           callback: () {
      //             prefs.setString("loggedUser", jsonEncode(authUser.toJson()));
      //             ToastNotification.showToast(
      //                 msg: "Connexion effectuée avec succès",
      //                 msgType: MessageType.success,
      //                 title: "Success");
      //             notifyListeners();
      //             callback();
      //             return;
      //           }));
      //   return;
      // }
      prefs.setString("loggedUser", jsonEncode(authUser.toJSON()));
      ToastNotification.showToast(
        msg: "Connexion effectuée avec succès",
        msgType: MessageType.success,
        title: "Success",
      );
      notifyListeners();
      callback();
      return;
    }
    // print(res.statusCode);
    // print(res.body);
    ToastNotification.showToast(
      msg: jsonDecode(res.body)['message'],
      msgType: MessageType.error,
      title: "Error",
    );
  }

  refreshUserData() async {
    Response res;
    res = await AppProviders.appProvider.httpGet(
      url: "${BaseUrl.user}/refresh/${userLogged?.user.uuid}",
    );
    // print(res.body);
    if (res.statusCode == 200) {
      // print(res.body);
      Map decoded = jsonDecode(res.body);
      AuthModel authUser = AuthModel.fromJSON(decoded);
      prefs.setString("loggedUser", jsonEncode(authUser.toJSON()));
      notifyListeners();
      updateLocalData();
      ToastNotification.showToast(
        msg: "Informations actualisées avec succès",
        msgType: MessageType.success,
        title: "Success",
      );
      return;
    }
    // print(res.statusCode);
    // print(res.body);
    ToastNotification.showToast(
      msg: jsonDecode(res.body)['message'],
      msgType: MessageType.error,
      title: "Error",
    );
  }

  AuthModel? userLogged;

  static UserRolesEnum? role;

  getUserData() async {
    userLogged = null;
    // prefs.clear();
    String? loggedUser = prefs.getString('loggedUser');
    userLogged = loggedUser != null
        ? AuthModel.fromJSON(jsonDecode(loggedUser))
        : null;
    // getOffline();
    // print(userLogged?.toJson());
    String stringRole = userLogged?.user.role?.toLowerCase() ?? '';
    if (stringRole.toLowerCase().contains('admin')) {
      role = UserRolesEnum.admin;
    } else if (stringRole.toLowerCase().contains('agent')) {
      role = UserRolesEnum.agent;
    } else if (stringRole.toLowerCase().contains('root')) {
      role = UserRolesEnum.root;
    } else if (stringRole.toLowerCase().contains('etudiant')) {
      role = UserRolesEnum.student;
    } else {
      role = UserRolesEnum.group;
    }

    // offlineData = userLogged?.society?.assets ?? [];
    // print(userLogged?.toJson());
    // print(role);
    // print(stringRole);
    notifyListeners();
  }

  logOut({required String password}) async {
    prefs.clear();
    offlineData.clear();

    await LocalDataHelper.resetLocalData();
    userLogged = null;
    ToastNotification.showToast(
      msg: "Deconnecté",
      msgType: MessageType.success,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigation.pushRemove(page: const LoginPage());
    });
    notifyListeners();
  }

  requestCode({required String email, required Function callback}) async {
    var response = await AppProviders.appProvider.httpPost(
      url: "${BaseUrl.authentication}/forgot-password",
      body: {"email": email},
    );
    // print(response.body);
    if (response.statusCode == 200) {
      ToastNotification.showToast(
        msg: 'Un code de confirmation a été envoyé à votre adresse mail',
        msgType: MessageType.success,
        title: "Information",
      );
      callback();
    }
    if (response.statusCode == 500) {
      ToastNotification.showToast(
        msg:
            jsonDecode(response.body)['message'] ??
            'Une erreur est survenue, veuillez réessayer',
        msgType: MessageType.info,
        title: "Information",
      );
    }
    if (response.statusCode != 200 && response.statusCode != 500) {
      ToastNotification.showToast(
        msg:
            jsonDecode(response.body)['message'] ??
            "L'adresse mail fournit n'a pas été trouvée",
        msgType: MessageType.error,
        title: "Erreur",
      );
      return;
    }
  }

  resetPassword({
    required String email,
    required String code,
    required String password,
    required Function callback,
  }) async {
    var response = await AppProviders.appProvider.httpPost(
      url: "${BaseUrl.authentication}/reset-password",
      body: {"email": email, "code": code, "password": password},
    );
    // print(response.body);
    if (response.statusCode == 200) {
      ToastNotification.showToast(
        msg: 'Mot de passe réinitialisé avec succès',
        msgType: MessageType.success,
        title: "Information",
      );
      callback();
    }
    if (response.statusCode == 500) {
      ToastNotification.showToast(
        msg:
            jsonDecode(response.body)['message'] ??
            'Une erreur est survenue, veuillez réessayer',
        msgType: MessageType.info,
        title: "Information",
      );
    }
    if (response.statusCode != 200 && response.statusCode != 500) {
      ToastNotification.showToast(
        msg:
            jsonDecode(response.body)['message'] ??
            "L'adresse mail fournit n'a pas été trouvée",
        msgType: MessageType.error,
        title: "Erreur",
      );
      return;
    }

    notifyListeners();
  }

  validateCode({
    required String email,
    required String code,
    required Function callback,
  }) async {
    var response = await AppProviders.appProvider.httpPost(
      url: "${BaseUrl.authentication}/confirm-email",
      body: {"email": email, "code": code},
    );

    // return;
    if (response.statusCode == 200) {
      ToastNotification.showToast(
        msg: 'Adresse mail validée avec succès',
        msgType: MessageType.success,
        title: "Information",
      );
      callback();
    }
    if (response.statusCode == 500) {
      ToastNotification.showToast(
        msg:
            jsonDecode(response.body)?['message'] ??
            'Une erreur est survenue, veuillez réessayer',
        msgType: MessageType.info,
        title: "Information",
      );
    }
    if (response.statusCode != 200 && response.statusCode != 500) {
      ToastNotification.showToast(
        msg: jsonDecode(response.body)?['message'] ?? "Une erreur est survenue",
        msgType: MessageType.error,
        title: "Erreur",
      );
      return;
    }

    notifyListeners();
  }

  updateLocalData() {
    // navKey.currentContext?.read<SocietyProvider>().getOnline(isRefresh: true);
    // navKey.currentContext?.read<SocietyProvider>().getOnlineStreets(
    //   isRefresh: true,
    // );
    // navKey.currentContext?.read<MemberProvider>().getOnline(isRefresh: true);
    // navKey.currentContext?.read<PackPricingProvider>().getOnline(
    //   isRefresh: true,
    // );
    // navKey.currentContext?.read<PackDimensionProvider>().getOnline(
    //   isRefresh: true,
    // );
  }
}
