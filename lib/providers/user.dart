import 'dart:convert' as convert;
import 'package:patient_app/constants/constants.dart';
import 'package:patient_app/functions/jwt.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';


enum LoaderStatus { busy, idle }



class UserProvider with ChangeNotifier {
  //Loader State
  static LoaderStatus _loaderStatus = LoaderStatus.idle;
  LoaderStatus get loaderStatus => _loaderStatus;
  void setLoaderStatus(LoaderStatus status) {
    _loaderStatus = status;
  }

  //Jwtprovider for language
  var jwtProvider = JWTProvider();

  var _userConsultationData = [];

  List get userConsultationData => [..._userConsultationData];

  List _prescriptionRecord = [];
  List get prescriptionRecord => [..._prescriptionRecord];

  String _name;
  String get name => _name;

  Future<String> getUserConsultationRecord() async {
    _userConsultationData = [];
    String token = await jwtProvider.token;
    _name = await jwtProvider.name;
    //String token = 'e4f7db126dc27f75185315d13ad5ea6f980ee286';
    setLoaderStatus(LoaderStatus.busy);
    notifyListeners();
    var response = await http.get(
      '$url/consultation/consultations-data/',
      headers: {
        "Content-type": "application/json",
        "Authorization": "token $token"
      },
    );
    var decodedResponse = convert.jsonDecode(response.body)['consultation_data'];
    _userConsultationData = decodedResponse;
      setLoaderStatus(LoaderStatus.idle);
      notifyListeners();

    
    //Something must be returned for the Future in Profile section
    return 'data';
  }

  Future<String> getUserPrescriptionRecord() async {
    String token = await jwtProvider.token;
    setLoaderStatus(LoaderStatus.busy);
    notifyListeners();
    var response = await http.get(
      '$url/consultation/prescriptions/',
      headers: {
        "Content-type": "application/json",
        "Authorization": "token $token"
      },
    );
    var decodedResponse = convert.jsonDecode(response.body)['prescription'];
    _prescriptionRecord = decodedResponse;
      setLoaderStatus(LoaderStatus.idle);
      notifyListeners();
    return 'data';
  }

  //Only for getting token
  Future<String> loginuser(String number, String password) async {
    var response = await http.post(
      '$url/api/v1/login/',
      headers: {
        "Content-type": "application/json",
      },
      body: convert.jsonEncode({
        "phone": number,
        "password": password
      }),
    );
    var decodedResponse = convert.jsonDecode(response.body);
    print(decodedResponse);
    return decodedResponse['key'];
  }

  Future<String> createUser(String email, password, number, name, age, address, lat, long) async {
    print('$url/api/v1/createuser/');
    var response = await http.post(
      '$url/api/v1/createuser/',
      headers: {
        "Content-type": "application/json",
      },
      body: convert.jsonEncode({
        "email": email,
        "password": password,
        "phone": number,
        "name": name,
        "age": age,
        "address": address,
        "latitude": lat,
        "longitude": long,
        "role": "P"
      }),
    );
    var decodedResponse = convert.jsonDecode(response.body);
    print('IN CREATE USER RESPONSE $decodedResponse');
    if(decodedResponse['key'] == null){
    return 'ERROR';   
    }
    else{
      return decodedResponse['key']; 
    }
  }

  Future<String> sendSymptomForm(String systolic, diatolic, bloodglucose, heartrate, ecg, temp, pulse, spo2, weight, nutrition, audiometry, retinascan, optometry, doctorID) async {
    String token = await jwtProvider.token;
    try {
      print('Systolic $systolic  Weight  $weight');
      var response = await http.post(
        '$url/consultation/general-symptoms/',
        headers: {
          'Content-type': 'multipart/form-data',
          "Authorization": "token $token"
        },
        body: convert.jsonEncode({
          "systolic": systolic,
          "diatolic": diatolic,
          "blood_glucose": bloodglucose,
          "heart_rate": heartrate,
          "ecg": ecg,
          "ecg_report": null,
          "temp": temp,
          "pulse": pulse,
          "spo2": spo2,
          "weight": weight,
          "nutrition": nutrition,
          "nutrition_report": null,
          "audiometry": audiometry,
          "audiometry_report": null,
          "retina_scan": retinascan,
          "optometry": optometry,
          "assigned_doctor_id": "3",
        })
      );
       var decodedResponse = convert.jsonDecode(response.body);
       print('IN SYMPTOMS SENDING RESPONSE $decodedResponse');
    } catch (e) {
      print('provider form error  $e');
    }
    return 'res';
  }




}


//8921500799
