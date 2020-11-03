// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import '../functions/jwt.dart';
// import '../models/symptoms.dart';
// import '../constants/constants.dart';

// enum LoaderStatus { busy, idle }

// class SymptomsProvider with ChangeNotifier {
//   //Loader State
//   static LoaderStatus _loaderStatus = LoaderStatus.idle;
//   LoaderStatus get loaderStatus => _loaderStatus;
//   void setLoaderStatus(LoaderStatus status) {
//     _loaderStatus = status;
//   }

//   //Jwtprovider for language
//   // var jwtProvider = JWTProvider();

//   // Future<String> updateUserQuarantineymptoms() async {
//   //   setLoaderStatus(LoaderStatus.busy);
//   //   String language = await jwtProvider.language;
//   //   String token = await jwtProvider.token;
//   //   var response = await http.get(
//   //     '$url/userquarantineymptoms/?lang=$language',
//   //     headers: {
//   //       "Content-type": "application/json;charset=utf-8",
//   //       "Authorization": "token $token"
//   //     },
//   //   );
//   //   setLoaderStatus(LoaderStatus.idle);
//   //   notifyListeners();
//   //   return 'true';
//   // }

//   // bool tested = false;
//   // bool testPositive = false;
//   // bool qaurantined = false;
//   // bool datcough = false;
//   // bool difficultyBreathing = false;
//   // bool shakingChills = true;
//   // String coughfrequency;
//   // String bodyTemperature;

//   // Symptoms _symptoms;

//   // Symptoms get symptoms => _symptoms;

//   // updateValue(ordernumber, value) {
//   //   switch (ordernumber) {
//   //     case 2:
//   //       this.testPositive = value;
//   //       break;
//   //     case 1:
//   //       this.tested = value;
//   //       break;
//   //     case 5:
//   //       this.coughfrequency = value;
//   //       break;
//   //     case 6:
//   //       this.datcough = value;
//   //       break;
//   //     case 7:
//   //       this.difficultyBreathing = value;
//   //       break;
//   //     case 8:
//   //       this.shakingChills = value;
//   //       break;
//   //     case 3:
//   //       this.qaurantined = value;
//   //       break;
//   //     case 4:
//   //       this.bodyTemperature = value;
//   //       break;
//   //     default:
//   //       notifyListeners();
//   //   }
//   //   notifyListeners();
//   // }

//   // getValue(ordernumber) {
//   //   print(ordernumber);
//   //   switch (ordernumber) {
//   //     case 2:
//   //       return testPositive;
//   //       break;
//   //     case 1:
//   //       return tested;
//   //       break;
//   //     case 5:
//   //       return coughfrequency;
//   //       break;
//   //     case 6:
//   //       return datcough;
//   //       break;
//   //     case 7:
//   //       return difficultyBreathing;
//   //       break;
//   //     case 8:
//   //       return shakingChills;
//   //       break;
//   //     case 3:
//   //       return qaurantined;
//   //       break;
//   //     case 4:
//   //       return bodyTemperature;
//   //       break;
//   //     default:
//   //       print('default');
//   //   }
//   // }

//   bool _english = true;

//   bool get english => _english;

//   changeLang(bool) {
//     _english = bool;
//     notifyListeners();
//   }

//   Symptoms _symptoms = new Symptoms(
//     tested: false,
//     testPositive: false,
//     qaurantined: false,
//     datcough: false,
//     difficultyBreathing: false,
//     shakingChills: true,
//     coughfrequency: false,
//     bodyTemperature: false,
//   );

//   Symptoms get symptoms => _symptoms;

//   updateTested(bool value) {
//     this._symptoms.tested = value;
//     notifyListeners();
//   }

//   updateQaurantined(bool value) {
//     this._symptoms.qaurantined = value;
//     notifyListeners();
//   }

//   updateTestPositive(bool value) {
//     this._symptoms.testPositive = value;
//     notifyListeners();
//   }

//   updateDatcough(bool value) {
//     this._symptoms.datcough = value;
//     notifyListeners();
//   }

//   updateDifficultyBreathing(bool value) {
//     this._symptoms.difficultyBreathing = value;
//     notifyListeners();
//   }

//   updateShakingChills(bool value) {
//     this._symptoms.shakingChills = value;
//     notifyListeners();
//   }

//   updateCoughFrequency(bool value) {
//     this._symptoms.coughfrequency = value;
//     notifyListeners();
//   }

//   updateBodyTemperature(bool value) {
//     this._symptoms.bodyTemperature = value;
//     notifyListeners();
//   }
// }
