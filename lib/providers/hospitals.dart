// import 'dart:convert' as convert;
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';

// import '../functions/jwt.dart';
// import '../constants/constants.dart';

// enum LoaderStatus { busy, idle }

// class HospitalsProvider with ChangeNotifier {
//   //Jwtprovider for language
//   var jwtProvider = JWTProvider();

//   //Loader State
//   static LoaderStatus _loaderStatus = LoaderStatus.idle;
//   LoaderStatus get loaderStatus => _loaderStatus;
//   void setLoaderStatus(LoaderStatus status) {
//     _loaderStatus = status;
//   }

//   List _pvthospitals = [];

//   List get pvthospitals => [..._pvthospitals];

//   Future<void> updatePvtHospitals() async {
//     setLoaderStatus(LoaderStatus.busy);
//     String language = await jwtProvider.language;
//     String token = await jwtProvider.token;
//     var response = await http.get(
//       '$url/mixhospitals/?lang=$language',
//       headers: {
//         "Content-type": "application/json",
//         "Authorization": "token $token"
//       },
//     );
//     print('enter');
//     _pvthospitals = convert.json.decode(
//       convert.utf8.decode(response.bodyBytes),
//     );
//     setLoaderStatus(LoaderStatus.idle);
//     notifyListeners();
//   }

//   //Government Hospitals
//   List _govhospitals = [];

//   List get govhospitals => [..._govhospitals];

//   Future<void> updateGovHospitals() async {
//     setLoaderStatus(LoaderStatus.busy);
//     _govhospitals = [];
//     String language = await jwtProvider.language;
//     String token = await jwtProvider.token;
//     var response = await http.get(
//       '$url/governmenthospitals/?lang=$language',
//       headers: {
//         "Content-type": "application/json",
//         "Authorization": "token $token"
//       },
//     );
//     _govhospitals = convert.json.decode(
//       convert.utf8.decode(response.bodyBytes),
//     );
//     // setLoaderStatus(LoaderStatus.idle);
//     notifyListeners();
//   }
// }
