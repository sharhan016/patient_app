import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../functions/jwt.dart';
import '../constants/constants.dart';

enum LoaderProgress { busy, idle }

class TimeSlotProvider with ChangeNotifier {
  var jwtProvider = JWTProvider();

  //Loader State
  static LoaderProgress _loaderStatus = LoaderProgress.idle;
  LoaderProgress get loaderStatus => _loaderStatus;
  void setLoaderStatus(LoaderProgress status) {
    _loaderStatus = status;
  }

  List _timeslots = [];
  List get timeslots => [..._timeslots];
  List _availableSlots = [];
  List get availableSlots => _availableSlots;

  Future<String> getTimeSlots(String doctorId, slotdate) async {
    print("REACHED GET TIME SLOTS, id= $doctorId , date= $slotdate");
    Map data = {"doctor_profile_id": doctorId, "start_date": slotdate};
    setLoaderStatus(LoaderProgress.busy);
    notifyListeners();
    String token = await jwtProvider.token;
    var response = await http.post(
      '$url/appointment/get-timeslots/',
      headers: {
        "Authorization": "Token $token"
      },
      body: data
    );
    if (response.statusCode == 200) {
      print("IN GET TIME SLOTS STATUS 200");
      var appoinments = json.decode(response.body)['Timeslots'];
      _timeslots = appoinments;
      setLoaderStatus(LoaderProgress.idle);
      notifyListeners();
      _availableSlots = [];
      for(var i=0; i<appoinments.length; i++){
        if(appoinments[i]['is_booked'] == false){
          
        _availableSlots.add(appoinments[i]['is_booked']);
        }
      }
      print(availableSlots);
      notifyListeners();
      
      return 'ok';
    } else {
      print("GET TIME ELSE");
      setLoaderStatus(LoaderProgress.idle);
      notifyListeners();
      return 'NOT_SET';
    }
  }

  Future<void> getAvailableSlots(timeslots) async {
    List _isBooked = [];
   // print('In GET $timeslots');
    _isBooked = timeslots['is_booked'];
    print('IS BOOKED:: $_isBooked');
  }

}
