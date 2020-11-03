import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:patient_app/components/customAppBar.dart';
import 'package:patient_app/components/symptomcard.dart';
import 'package:patient_app/constants/constants.dart' as constant;
import 'package:patient_app/functions/jwt.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:patient_app/localization/localization.dart';

class SymptomScreen extends StatefulWidget {

  final String doctorId;
  SymptomScreen({@required this.doctorId});

  @override
  _SymptomScreenState createState() => _SymptomScreenState();
}

class _SymptomScreenState extends State<SymptomScreen> {
  File file, _ecgimagefile, _ecgreportfile, _nutritionfile, _audiometryfile;
  int _bpValue = 1;
  int _bgValue = 1;
  bool loading = false;
  bool ecgimagepresent = false;
  bool ecgreportpresent = false;
  bool nutritionreportpresent = false;
  bool audiometryreportpresent = false;
  
  String systolic = "00", diatolic = "00", bloodglucose= "00", heartrate= "00", ecg= "00", temp= "00", pulse= "00", spo2= "00", weight= "00", nutrition= "00", audiometry= "00", retinascan= "00", optometry= "00"; 
  var jwtProvider = JWTProvider();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print(widget.doctorId);
    return Scaffold(
      appBar: CustomAppBarComponent(
        title: DemoLocalization.of(context).translate('symptoms'),
        leadingWidget: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        trailingWidget: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.transparent,
          ),
          onPressed: () {},
        ),
      ),
      body: Form(
            key: _formKey,
             child: Padding(
          padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 90,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(7.0),
                    // color: Theme.of(context).primaryColor
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DemoLocalization.of(context).translate('bp'),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Row(
                          children: [
                            Container(
                                width: 30,
                                height: 15,
                                child: TextFormField(
                                    autofocus: false,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      ),
                                    onSaved: (String value) {
                                        systolic = value;
                                      },
                                    )),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 5.0, right: 5.0),
                              child: Text(
                                " / ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                            ),
                            Container(
                                width: 30,
                                height: 15,
                                child: TextFormField(
                                    autofocus: false,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      ),
                                    onChanged: (String value) {
                                        diatolic = value;
                                      },
                                    )),
                            Text(
                              'mm of hg',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 12),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5.0),
                              padding: EdgeInsets.only(left: 5.0),
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Theme.of(context).primaryColor,
                              ),
                              //width: 20,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                    value: _bpValue,
                                    items: [
                                      DropdownMenuItem(
                                        child: Text(DemoLocalization.of(context).translate('systolic')),
                                        value: 1,
                                      ),
                                      DropdownMenuItem(
                                        child: Text(DemoLocalization.of(context).translate('other'),),
                                        value: 2,
                                      ),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _bpValue = value;
                                      });
                                    }),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SymptomCard(
                  title: DemoLocalization.of(context).translate('bg'),
                  row: Row(
                    children: [
                      Container(width: 70, height: 20, child: TextFormField(
                          autofocus: false,
                                  //keyboardType: TextInputType.phone,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      //hintText: "00",
                                      //border: InputBorder.none,
                                      ),
                                    onChanged: (String value) {
                                        bloodglucose = value;
                                      },
                      )),
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        padding: EdgeInsets.only(left: 5.0),
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Theme.of(context).primaryColor,
                        ),
                        //width: 20,
                        child: DropdownButton(
                            value: _bgValue,
                            items: [
                              DropdownMenuItem(
                                child: Text("mmol / L"),
                                value: 1,
                              ),
                              DropdownMenuItem(
                                child: Text(DemoLocalization.of(context).translate('other'),),
                                value: 2,
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _bgValue = value;
                              });
                            }),
                      ),
                    ],
                  ),
                ),
                SymptomCard(
                  title: DemoLocalization.of(context).translate('hr'),
                  row: Row(
                    children: [
                      Container(width: 70, height: 20, child: TextFormField(
                      autofocus: false,
                      //keyboardType: TextInputType.phone,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          //border: InputBorder.none,
                          ),
                        onChanged: (String value) {
                            heartrate = value;
                          },
                      )),
                      SizedBox(
                        width: 10,
                      ),
                      Text(DemoLocalization.of(context).translate('bpm'),),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
                SymptomCard(
                  title: DemoLocalization.of(context).translate('ecg'),
                  row: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(width: 70, height: 15, child: TextFormField(
                        autofocus: false,
                                  //keyboardType: TextInputType.phone,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      //border: InputBorder.none,
                                      ),
                                    onSaved: (String value) {
                                        ecg = value;
                                      },
                      )),
                      SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          uploadButton(context,DemoLocalization.of(context).translate('uploadImage'),'image'),
                          SizedBox(width: 2),
                          uploadButton(context,DemoLocalization.of(context).translate('attachreport'),'ecgreport'),
                        ],
                      )
                    ],
                  ),
                ),
                SymptomCard(
                  title: DemoLocalization.of(context).translate('temp'),
                  row: Row(
                    children: [
                      Container(width: 70, height: 20, child: TextFormField(
                        autofocus: false,
                                  //keyboardType: TextInputType.phone,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      //border: InputBorder.none,
                                      ),
                                    onChanged: (String value) {
                                        temp = value;
                                      },
                      )),
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        padding: EdgeInsets.only(left: 5.0),
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Theme.of(context).primaryColor,
                        ),
                        //width: 20,
                        child: DropdownButton(
                            value: _bgValue,
                            items: [
                              DropdownMenuItem(
                                child: Text(DemoLocalization.of(context).translate('celcius'),),
                                value: 1,
                              ),
                              DropdownMenuItem(
                                child: Text(DemoLocalization.of(context).translate('other'),),
                                value: 2,
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _bgValue = value;
                              });
                            }),
                      ),
                    ],
                  ),
                ),
                SymptomCard(
                  title: DemoLocalization.of(context).translate('pulse'),
                  row: Row(
                    children: [
                      Container(width: 70, height: 20, child: TextFormField(
                        autofocus: false,
                                  //keyboardType: TextInputType.phone,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      //border: InputBorder.none,
                                      ),
                                    onChanged: (String value) {
                                        pulse = value;
                                      },
                      )),
                      SizedBox(
                        width: 10,
                      ),
                      Text(DemoLocalization.of(context).translate('bpm'),),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
                SymptomCard(
                  title: DemoLocalization.of(context).translate('os'),
                  row: Row(
                    children: [
                      Container(width: 70, height: 20, child: TextFormField(
                        autofocus: false,
                                  //keyboardType: TextInputType.phone,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      //border: InputBorder.none,
                                      ),
                                    onChanged: (String value) {
                                        spo2 = value;
                                      },
                      )),
                      SizedBox(
                        width: 10,
                      ),
                      Text('%'),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
                SymptomCard(
                  title: DemoLocalization.of(context).translate('weight'),
                  row: Row(
                    children: [
                      Container(width: 70, height: 20, child: TextFormField(
                        autofocus: false,
                                  //keyboardType: TextInputType.phone,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      //border: InputBorder.none,
                                      ),
                                    onChanged: (String value) {
                                        weight = value;
                                      },
                      )),
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        padding: EdgeInsets.only(left: 5.0),
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Theme.of(context).primaryColor,
                        ),
                        //width: 20,
                        child: DropdownButton(
                            value: _bgValue,
                            items: [
                              DropdownMenuItem(
                                child: Text(DemoLocalization.of(context).translate('kg'),),
                                value: 1,
                              ),
                              DropdownMenuItem(
                                child: Text(DemoLocalization.of(context).translate('other'),),
                                value: 2,
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _bgValue = value;
                              });
                            }),
                      ),
                    ],
                  ),
                ),
                SymptomCard(
                  title: DemoLocalization.of(context).translate('nutrition'),
                  row: Row(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Container(width: 70,
                           height: 20, 
                           child: TextFormField(
                            autofocus: false,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                //border: InputBorder.none,
                                ),
                              onChanged: (String value) {
                                  nutrition = value;
                                },
                          )),
                          
                          uploadButton(context,DemoLocalization.of(context).translate('attachreport'),'nutritionreport'),
                        ],
                      ),
                      SizedBox(
                        width: 30
                      )
                    ],
                  ),
                ),
                SymptomCard(
                  title: DemoLocalization.of(context).translate('hearing'),
                  row: Row(
                    children: [
                      Column(
                        children: [
                           SizedBox(
                            height: 15,
                          ),
                          Container(width: 70, height: 20, child: TextFormField(
                            autofocus: false,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                //border: InputBorder.none,
                                ),
                              onChanged: (String value) {
                                  audiometry = value;
                                },
                          )),
                          uploadButton(context,DemoLocalization.of(context).translate('attachreport'),'audiometryreport'),
                        ],
                      ),
                      SizedBox(
                        width: 30
                      )
                    ],
                  ),
                ),
                SymptomCard(
                  title: DemoLocalization.of(context).translate('retinal'),
                  row: Row(
                    children: [
                      Container(width: 70, height: 20, child: TextFormField(
                        autofocus: false,
                                  //keyboardType: TextInputType.phone,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            //border: InputBorder.none,
                            ),
                          onChanged: (String value) {
                              retinascan = value;
                            },
                      )),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
                SymptomCard(
                  title: DemoLocalization.of(context).translate('optometry'),
                  row: Row(
                    children: [
                      Container(width: 70, height: 20, child: TextFormField(
                        autofocus: false,
                                  //keyboardType: TextInputType.phone,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      //border: InputBorder.none,
                                      ),
                                    onChanged: (String value) {
                                        optometry = value;
                                      },
                      )),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  height: 160,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(7.0),
                    // color: Theme.of(context).primaryColor
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Expanded(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(DemoLocalization.of(context).translate('describe'),style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 15),),
                          TextFormField(
                              maxLines: 4,
                              decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                                //maxLines: 5,
                                ),
            
                        ],
                      ),
                    ),
                  ),
                ),
                loading != true ?
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    DemoLocalization.of(context).translate('submit'),
                    style: TextStyle(color: Colors.white),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    onPressed: submitHandler,
                   //onPressed: () => Navigator.pushNamed(context, 'doctorscreen', arguments: widget.doctorId),
                ) :
                SpinKitCircle(color: Colors.teal, size: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget uploadButton(context, String title,filetype) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      height: 50,
      width: 80,
      child: FlatButton(
        color: Theme.of(context).primaryColor,
        child: Text(
          title,
          //DemoLocalization.of(context).translate('submit'),
          style: TextStyle(color: Colors.white),
        ),
        
        onPressed: () async {
          FileType type;
          if(filetype == 'image'){
            type = FileType.image;
          }
          else{
            type= FileType.any;
          }
          File result = await FilePicker.getFile(type: type);
          if (result != null) {
            switch (filetype) {
              case 'image': 
                setState(() {
                _ecgimagefile = result;
                ecgimagepresent = true;
               });
                break;
              case 'ecgreport':
                setState(() {
                _ecgreportfile = result;
                ecgreportpresent = true;
                });
                break;
              case 'nutritionreport':
                setState(() {
                _nutritionfile = result;
                nutritionreportpresent = true;
                });
                break;
              case 'audiometryreport':
                setState(() {
                _audiometryfile = result;
                audiometryreportpresent = true;
                });
                break;
              default:
              
            }
            
            
          } else {
            // User canceled the picker
          }
        },
      ),
    );
  }

    Future submitHandler() async {
      String token = await jwtProvider.token;
      FocusScope.of(context).unfocus();
      setState(() {
        loading = true;
      });
      String postUrl = constant.url+'/consultation/general-symptoms/';
      var request = http.MultipartRequest("POST", Uri.parse(postUrl));
      request.headers["Authorization"] = 'token $token';
      if (ecgimagepresent == true) {
        request.files.add(await http.MultipartFile.fromPath("ecg_report", _ecgimagefile.path));
      }
      if (ecgreportpresent == true) {
        request.files.add(await http.MultipartFile.fromPath("ecg_report", _ecgreportfile.path));

      }
      if (nutritionreportpresent == true) {
        request.files.add(await http.MultipartFile.fromPath("nutrition_report", _nutritionfile.path));
      }
      if (audiometryreportpresent == true) {
        request.files.add(await http.MultipartFile.fromPath("audiometry_report", _audiometryfile.path));
      }
      request.fields["systolic"] = systolic;
      request.fields["diatolic"] = diatolic;
      request.fields["blood_glucose"] = bloodglucose;
      request.fields["heart_rate"] = heartrate;
      request.fields["ecg"] = ecg;
      request.fields["temp"] = temp;
      request.fields["pulse"] = pulse; 
      request.fields["spo2"] = spo2;
      request.fields["weight"] = weight;
      request.fields["nutrition"] = nutrition;
      request.fields["audiometry"] = audiometry;
      request.fields["retina_scan"] = retinascan;
      request.fields["optometry"] = optometry;
      request.fields["assigned_doctor_id"] = widget.doctorId;

      request.send().then((result) async {
        http.Response.fromStream(result).then((response) {
          if(response.statusCode == 200){
            print(response.statusCode);
            print('SUBMITION SUCCESSFULL');
            setState(() {
              loading = false;
            });
            Navigator.pushNamed(
            context,
            'doctorscreen',
            arguments: widget.doctorId);

          }
          else {
            print("ELSE STATEMENT of HTTP MULTIREQUEST");
          }
        });
      } );
    }
}

      // List response = [];
    //    Map data = {
    //     "systolic": systolic,
    //       "diatolic": diatolic,
    //       "blood_glucose": bloodglucose,
    //       "heart_rate": heartrate,
    //       "ecg": ecg,
    //       "ecg_report": 'null',
    //       "temp": temp,
    //       "pulse": pulse,
    //       "spo2": spo2,
    //       "weight": weight,
    //       "nutrition": nutrition,
    //       "nutrition_report": 'null',
    //       "audiometry": audiometry,
    //       "audiometry_report": 'null',
    //       "retina_scan": retinascan,
    //       "optometry": optometry,
    //       "assigned_doctor_id": "3",
    //     };

    //    // try {
    //     //print('Map Data:  $data');
    //     var response = await http.post(
    //     '$postUrl/consultation/general-symptoms/',
    //     headers: {
    //      // 'Content-type': 'multipart/form-data',
    //      'Content-type': 'application/json',
    //       "Authorization": "token $token"
    //     },
    //     body: json.encode(data)
    //   );
    //     print(response.body);
    //    var decodedResponse = convert.jsonDecode(response.body);
    //    print('IN SYMPTOMS SENDING RESPONSE $decodedResponse');
    // // } catch (e) {
    // //   print('provider form error  $e');
    // // }
    // return 'res';

  

  //     Future<dynamic> uploadData() async {
  //       print('I am in UPLOAD DATA');
  //     bool ecgValue = false;
  //     //String postRL = 'http://127.0.0.1:8000';
  //     String postUrl = constant.url;
  //     String ecgfilename = '';
  //     String token = 'b07011c7e65ade740547ea79513e36d722449f99';
  //     //String token = 'c462922e0cf4c896e2245f8cb8757095db3d10b9';
  //     File imagefilepath = _ecgimagefile;
  //     // print(imagefilepath.path);
  //     // if(imagefilepath.path != null){
  //     //   ecgValue = true;
  //     // }
  //     // print(ecgValue);
  //     if(imagefilepath != null){
  //       ecgfilename = basename(imagefilepath.path);
  //       print('file base name $ecgfilename');
  //     }
  //     Dio dio = new Dio();
  //     dio.options.headers = {
  //       'Content-type': 'multipart/form-data',
  //       'Accept': 'application/json',
  //       "Authorization": "Token $token"
  //     };
  //   //try {
  //     print('in try block $_ecgimagefile');
  //     var formData = new FormData.fromMap({
  //         "systolic": systolic,
  //         "diatolic": diatolic,
  //         "blood_glucose": bloodglucose,
  //         "heart_rate": heartrate,
  //         "ecg": ecg,
  //         "ecg_report": ecgValue ? await MultipartFile.fromFile(imagefilepath.path, filename: ecgfilename) : null,
  //         "temp": temp,
  //         "pulse": pulse,
  //         "spo2": spo2,
  //         "weight": weight,
  //         "nutrition": nutrition,
  //         "nutrition_report": null,
  //         "audiometry": audiometry,
  //         "audiometry_report": null,
  //         "retina_scan": retinascan,
  //         "optometry": optometry,
  //         "assigned_doctor_id": widget.doctorId,
  //     });

  //     Response response = await dio.post('$postUrl/consultation/general-symptoms/', data: formData);
  //     print('response:: $response');
  //   // } catch (e) {
  //   //   print('In catch $e');
  //   // }
    
  // }


