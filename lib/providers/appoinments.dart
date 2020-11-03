import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../functions/jwt.dart';
import '../constants/constants.dart';

enum LoaderStatus { busy, idle }

class AppoinmentsProvider with ChangeNotifier {
  var jwtProvider = JWTProvider();

  //Loader State
  static LoaderStatus _loaderStatus = LoaderStatus.idle;
  LoaderStatus get loaderStatus => _loaderStatus;
  void setLoaderStatus(LoaderStatus status) {
    _loaderStatus = status;
  }

  List _appoinments = [];
  List get appoinments => [..._appoinments];

  Future<void> updateAppoinments(DateTime day) async {
    setLoaderStatus(LoaderStatus.busy);
    print(day);
    String token = '828c8c5cfc3f7f51d6b172681cc06fb42a7c4cff';
    var response = await http.get(
      '$url/appointment/get-timeslots/',
      headers: {
        "Content-type": "application/json",
        "Authorization": "Token $token"
      },
    );
    if (response.statusCode == 200) {
      var appoinments = json.decode(response.body)['Appointment'];
      setLoaderStatus(LoaderStatus.idle);
      _appoinments = appoinments;
      notifyListeners();
      //return appoinments;+
    } else {
// use snackbar
      return null;
    }
  }
}
