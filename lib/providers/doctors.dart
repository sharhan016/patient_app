import 'dart:convert';
import 'package:patient_app/constants/constants.dart';
import 'package:patient_app/functions/jwt.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:patient_app/utils/methods.dart';

enum LoaderStatus { busy, idle }

class DoctorsProvider with ChangeNotifier {
  //Loader State
  static LoaderStatus _loaderStatus = LoaderStatus.idle;
  LoaderStatus get loaderStatus => _loaderStatus;
  void setLoaderStatus(LoaderStatus status) {
    _loaderStatus = status;
  }

  //Jwtprovider for language
  var jwtProvider = JWTProvider();

  List _doctorList;
  List get doctorList => _doctorList;

  Map _doctorData = {};
  Map get doctorData => _doctorData;

  List _specialty;
  List get speciality => [..._specialty];

  Future<String> getSpeciality() async {
    setLoaderStatus(LoaderStatus.busy);
     String token = await jwtProvider.token;
    var response = await http.get(
      '$url/consultation/all-specialitytags/',
      headers: {
        "Content-type": "application/json",
        "Authorization": "Token $token"
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      var specialyList = json.decode(response.body)['specialityTags'];
      setLoaderStatus(LoaderStatus.idle);
      _specialty = specialyList;
      notifyListeners();
    } else {
      print("GET SPECIALITY ELSE");
      return null;
    }
    return 'ok';
  }

  Future<String> getDoctorList(String number) async {
    setLoaderStatus(LoaderStatus.busy);
    String token = await jwtProvider.token;
    var response = await http.get(
      '$url/consultation/doctor-profiles/?speciality_tag_id=$number',
      headers: {
        "Content-type": "application/json",
        "Authorization": "Token $token"
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      var doctor = json.decode(response.body);
      print('In getDoctorLIST $doctor');
      setLoaderStatus(LoaderStatus.idle);
      _doctorList = doctor;

      notifyListeners();
    } else {
      print("GET DoctorLIST ELSE");
      return null;
    }
    return 'ok';
  }


  Future<String> getDoctorProfile(String number, slotdate) async {
    setLoaderStatus(LoaderStatus.busy);
    String token = await jwtProvider.token;
    print('IN GET DOCTOR PROFILE');
    var response = await http.get(
      '$url/consultation/doctor-public-profile/$number',
      headers: {
        "Content-type": "application/json",
        "Authorization": "Token $token"
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      var doctor = json.decode(response.body);
      setLoaderStatus(LoaderStatus.idle);
      _doctorData = doctor;
      print('In getDoctorProfile $_doctorData');
      var id = _doctorData['id'].toString();
      var slotDate = slotdate.toString();
      getTimeSlots(id, slotDate);

      notifyListeners();
    } else {
      print("GET DoctorProfile ELSE");
      return null;
    }
    return 'ok';
  }

  Future<String> bookAppoinment(String doctorId, String slotId, String slotdate) async{
    String token = await jwtProvider.token;
    Methods.showSnackBar("Please Wait", BuildContext);
    //String token = '13d17dbdfadb152bdc4de6928e370c09d294f45d';
    print('reached book appointment doctor= $doctorId  slot= $slotId');
    Map data = {"time_slot_id": slotId, "doctor_profile_id": doctorId};
    var response = await http.post(
      '$url/appointment/book-appointment/',
      headers: {
        //"Content-type": "application/json",
        "Authorization": "Token $token"
      },
      body: data
    );
    if(response.statusCode == 200){
      print('success in booking');
      Methods.showSnackBar("Successfully Booked", BuildContext);
      getTimeSlots(doctorId, slotdate);
    }
    else{
      print('ELSE in booking');
      Methods.showSnackBar("Error occured please try again", BuildContext);
    }
    return response.statusCode.toString();
  }


  List _timeslots = [];
  List get timeslots => [..._timeslots];
  List _availableSlots = [];
  List get availableSlots => _availableSlots;

  Future<String> getTimeSlots(String doctorId, String slotdate) async {
    print("REACHED GET TIME SLOTS, id= $doctorId , date= $slotdate");
  //  var slot = {
  //    "doctor_profile_id": doctorId,
  //     "start_date": slotdate
  //  };
  //  var data = json.encode(slot);
    setLoaderStatus(LoaderStatus.busy);
    notifyListeners();
    String token = await jwtProvider.token;
    // var uri = Uri.http('$url/appointment/get-timeslots/', data);
    // var response = await http.get('$uri', headers: {"Authorization": "Token $token"});
    String uri = "$url/appointment/get-timeslots/?doctor_profile_id=$doctorId&start_date=$slotdate";
    
    var response = await http.get('$uri',
      headers: {
        "Authorization": "Token $token"
      },
    );
    print('time response code '+response.statusCode.toString());
    if (response.statusCode == 200) {
      print("IN GET TIME SLOTS STATUS 200");
      var appoinments = json.decode(response.body)['Time slots'];
      _timeslots = appoinments;
      print(appoinments);
      setLoaderStatus(LoaderStatus.idle);
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
      print("GET DOCTOR TIME ELSE");
      setLoaderStatus(LoaderStatus.idle);
      notifyListeners();
      return 'NOT_SET';
    }
  }

}
// String systolic, dialtolic, bloodglucose, heartrate, ecg, temp, pulse, spo2 ;
  // String weight, nutrition, audiometry, retinascan, aptometry;