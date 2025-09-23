import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:my_lab_app/Resources/Constants/enums.dart';
import 'package:my_lab_app/Resources/Constants/global_variables.dart';
import 'package:my_lab_app/Resources/Providers/users_provider.dart';
import 'package:my_lab_app/main.dart';
import 'package:provider/provider.dart';

class AppStateProvider extends ChangeNotifier {
  bool isAsync = false, isApiReachable = false;
  changeAppState() async {
    isAsync = !isAsync;
    setHeaders();
  }

  setHeaders() {
    headers = {
      'Accept': 'application/json',
      // 'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${navKey.currentContext?.read<UserProvider>().userLogged?.token}',
    };
    // print(headers);
    notifyListeners();
  }

  Map<String, String> headers = {};
  checkApiConnectivity() async {
    await httpGet(url: BaseUrl.apiUrl).then((response) {
      if (response.statusCode == 200) {
        isApiReachable = true;
      } else {
        isApiReachable = false;
      }
    });
    notifyListeners();
  }

  changeConnectionState({required bool connectionState}) {
    isApiReachable = connectionState;
    notifyListeners();
  }

  int timeOut = 30;

  Future<Response> httpPost({required String url, required Map body}) async {
    // debugPrint(jsonEncode(body));
    // print("post $url");
    // print(headers);
    Map<String, String> headersData = headers;
    if (url.contains('login')) {
      headersData.remove('Authorization');
      print(headersData);
    }
    try {
      // print('changing state');
      changeAppState();
      Response response = await http
          .post(Uri.parse(url), body: (body), headers: headersData)
          .timeout(Duration(seconds: timeOut));
      changeAppState();
      // print(response.body);
      // print('changing state');
      if (response.statusCode == 401) {
        navKey.currentContext?.read<UserProvider>().logOut();
        ToastNotification.showToast(
          msg: "Veuillez vous reconnecter car votre session a expirée",
          msgType: MessageType.error,
        );
        return Response(
          jsonEncode({
            'data': [],
            'message': "Veuillez vous reconnecter car votre session a expirée",
          }),
          401,
        );
      }
      return response;
    } on TimeoutException {
      isApiReachable = false;
      changeAppState();
      return Response(
        jsonEncode({
          'data': [],
          'message': "Echec de connexion, veuillez réessayer",
        }),
        500,
      );
    } on SocketException {
      isApiReachable = false;
      changeAppState();
      return Response(
        jsonEncode({
          'data': [],
          'message': "Verifiez votre connexion puis réessayez",
        }),
        500,
      );
    } catch (error) {
      print(error.toString());
      isApiReachable = false;
      changeAppState();
      ToastNotification.showToast(
        msg: "Echec de connexion, veuillez réessayer",
        msgType: MessageType.error,
      );
      return Response(
        jsonEncode({
          'data': [],
          'message': "Erreur inattendue, veuillez réessayer",
        }),
        500,
      );
    }
  }

  Future<Response> httpPut({required String url, required Map body}) async {
    // print("put $url");
    try {
      changeAppState();
      Response response = await http
          .put(Uri.parse(url), body: (body), headers: headers)
          .timeout(Duration(seconds: timeOut));
      changeAppState();
      return response;
    } on TimeoutException {
      isApiReachable = false;
      changeAppState();
      return Response(
        jsonEncode({
          'data': [],
          'message': "Echec de connexion, veuillez réessayer",
        }),
        500,
      );
    } on SocketException {
      isApiReachable = false;
      changeAppState();
      return Response(
        jsonEncode({
          'data': [],
          'message': "Verifiez votre connexion, veuillez réessayer",
        }),
        500,
      );
    } catch (error) {
      // print(error.toString());
      isApiReachable = false;
      changeAppState();
      return Response(
        jsonEncode({
          'data': [],
          'message': "Erreur inattendue, veuillez réessayer",
        }),
        500,
      );
    }
  }

  Future<Response> httpPatch({required String url, required Map body}) async {
    // print("put $url");
    try {
      changeAppState();
      Response response = await http
          .patch(Uri.parse(url), body: (body), headers: headers)
          .timeout(Duration(seconds: timeOut));
      changeAppState();
      return response;
    } on TimeoutException {
      isApiReachable = false;
      changeAppState();
      return Response(
        jsonEncode({
          'data': [],
          'message': "Echec de connexion, veuillez réessayer",
        }),
        500,
      );
    } on SocketException {
      isApiReachable = false;
      changeAppState();
      return Response(
        jsonEncode({
          'data': [],
          'message': "Verifiez votre connexion, veuillez réessayer",
        }),
        500,
      );
    } catch (error) {
      // print(error.toString());
      isApiReachable = false;
      changeAppState();
      return Response(
        jsonEncode({
          'data': [],
          'message': "Erreur inattendue, veuillez réessayer",
        }),
        500,
      );
    }
  }

  Future<Response> httpDelete({required String url}) async {
    // print("delete $url");
    changeAppState();
    try {
      Response response = await http
          .delete(Uri.parse(url), headers: headers)
          .timeout(Duration(seconds: timeOut));
      // print(response.body);
      changeAppState();
      return response;
    } on TimeoutException {
      isApiReachable = false;
      changeAppState();
      return Response(
        jsonEncode({
          'data': [],
          'message': "Echec de connexion, veuillez réessayer",
        }),
        500,
      );
    } on SocketException {
      isApiReachable = false;
      changeAppState();
      return Response(
        jsonEncode({
          'data': [],
          'message': "Verifiez votre connexion, veuillez réessayer",
        }),
        500,
      );
    } catch (error) {
      // print(error.toString());
      isApiReachable = false;
      changeAppState();
      return Response(
        jsonEncode({
          'data': [],
          'message': "Erreur inattendue, veuillez réessayer",
        }),
        500,
      );
    }
  }

  Future<Response> httpGet({required String url}) async {
    // print("get $url");
    // print(headers);
    changeAppState();
    try {
      final response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(Duration(seconds: timeOut));
      changeAppState();
      // print(response.statusCode);
      if (response.statusCode == 401) {
        navKey.currentContext?.read<UserProvider>().logOut();
        ToastNotification.showToast(
          msg: "Veuillez vous reconnecter car votre session a expirée",
          msgType: MessageType.error,
        );
        return Response(
          jsonEncode({
            'data': [],
            'message': "Veuillez vous reconnecter car votre session a expirée",
          }),
          401,
        );
      }
      return response;
    } on TimeoutException {
      isApiReachable = false;
      changeAppState();
      return Response(
        jsonEncode({
          'data': [],
          'message': "Echec de connexion, veuillez réessayer",
        }),
        500,
      );
    } on SocketException {
      isApiReachable = false;
      changeAppState();
      return Response(
        jsonEncode({
          'data': [],
          'message': "Verifiez votre connexion, veuillez réessayer",
        }),
        500,
      );
    } catch (error) {
      // print(error.toString());
      isApiReachable = false;
      changeAppState();
      return Response(
        jsonEncode({
          'data': [],
          'message': "Erreur inattendue, veuillez réessayer",
        }),
        500,
      );
    }
  }

  Future<bool> syncData({required String url, required Map body}) async {
    try {
      // print('changing state');
      changeAppState();
      await http
          .post(Uri.parse(url), body: jsonEncode(body), headers: headers)
          .timeout(Duration(seconds: timeOut));
      changeAppState();
      // print(response.body);
      // print('changing state');
      return true;
    } on TimeoutException {
      changeAppState();
      return false;
    } on SocketException {
      changeAppState();
      return false;
    } catch (error) {
      changeAppState();
      return false;
    }
  }

  Map stats = {
    "countStore": 0,
    "countCategories": 0,
    "countUsers": 0,
    "countProducts": 0,
  };
  // getStats() async {
  //   await httpGet(
  //           url:
  //               "${BaseUrl.stats}all/${navKey.currentContext!.read<UserProvider>().enterpriseData?.uuid}")
  //       .then((response) {
  //     if (response.statusCode == 200) {
  //       // print(response.body);
  //       stats = (jsonDecode(response.body)['data']);
  //       notifyListeners();
  //     }
  //   }).catchError((err) {
  //     // print(err.toString());
  //   });
  // }

  // List<ProvisionModel> weeklyData = [];
  List<Map> weeks = [];
  double sumSell = 0, sumBuy = 0;
  static String startDate = DateTime.now()
      .subtract(const Duration(days: 7))
      .toString()
      .split(' ')[0];
  List dates = getDaysInBetween(
    DateTime.parse(startDate),
    DateTime.now(),
  ).map((e) => {"date": e, 'amountSell': 0, 'amountBuy': 0}).toList();
  getWeeklyTransactions() async {
    await httpGet(url: "")
        // "${BaseUrl.stats}week/$startDate/enterprise/${navKey.currentContext!.read<UserProvider>().enterpriseData?.uuid}")
        .then((response) {
          if (response.statusCode == 200) {
            // print(response.body);
            List data = jsonDecode(response.body)['data'];
            dates = getDaysInBetween(
              DateTime.parse(startDate),
              DateTime.now(),
            ).map((e) => {"date": e, 'amountSell': 0, 'amountBuy': 0}).toList();
            for (int iData = 0; iData < data.length; iData++) {
              String pattern = ' ';
              if (data[iData]['description'].toString().toLowerCase() ==
                  'vente') {
                sumSell +=
                    double.parse(data[iData]['unitPrice'].toString()) *
                    double.parse(data[iData]['quantity'].toString());
              }
              if (data[iData]['description'].toString().toLowerCase() ==
                      'approvisionnement' ||
                  data[iData]['description'].toString().toLowerCase() ==
                      'expense') {
                sumBuy +=
                    double.parse(data[iData]['unitPrice'].toString()) *
                    double.parse(data[iData]['quantity'].toString());
              }

              for (int kDates = 0; kDates < dates.length; kDates++) {
                if (data[iData]['description'].toString().toLowerCase() ==
                    'vente') {
                  if (dates[kDates]['date'].toString().split(' ')[0].trim() ==
                      DateTime.parse(
                        data[iData]['createdAt'],
                      ).toString().split(pattern)[0].trim()) {
                    dates[kDates]['amountSell'] =
                        double.parse(dates[kDates]['amountSell'].toString()) +
                        (double.parse(data[iData]['unitPrice'].toString()) *
                            double.parse(data[iData]['quantity'].toString()));
                  }
                }
                if (data[iData]['description'].toString().toLowerCase() ==
                        'approvisionnement' ||
                    data[iData]['description'].toString().toLowerCase() ==
                        'expense') {
                  if (dates[kDates]['date'].toString().split(' ')[0].trim() ==
                      DateTime.parse(
                        data[iData]['createdAt'],
                      ).toString().split(pattern)[0].trim()) {
                    dates[kDates]['amountBuy'] =
                        double.parse(dates[kDates]['amountBuy'].toString()) +
                        (double.parse(data[iData]['unitPrice'].toString()) *
                            double.parse(data[iData]['quantity'].toString()));
                  }
                }
              }
            }
            notifyListeners();
          }
        })
        .catchError((err) {
          // print(err.toString());
        });
  }

  static List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(
        DateTime.parse(
          startDate.add(Duration(days: i)).toString().split(' ')[0].toString(),
        ),
      );
    }
    return days;
  }
}
