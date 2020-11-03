import 'dart:io';
import 'package:patient_app/main.dart';
import 'package:patient_app/utils/app_colors.dart';
import 'package:patient_app/utils/raised_button.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:patient_app/localization/localization.dart';
import 'package:patient_app/utils/methods.dart';
import 'package:patient_app/functions/jwt.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

String _email;
String _password;
bool loading = false;
bool passWordVisible = true;
bool isEnglishSelected = false;
bool isHindiSelected = false;
final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

class _LoginScreenState extends State<LoginScreen> {


  void togglePasswordVisiblity() {
    setState(() {
      passWordVisible = !passWordVisible;
    });
  }

  Future<void> _login(context) async {
    FocusScope.of(context).unfocus();
    String url = "https://api-healthcare.datavivservers.in/api/v1/login/";
    if (_formkey.currentState.validate()) {
      setState(() {
        loading = true;
      });
      _formkey.currentState.save();
      if(isEnglishSelected == true){
      JWTProvider().changeLang('en');
      MyApp.setLocale(context, Locale('en', 'US'));
      }
      else{
        JWTProvider().changeLang('mr');
        MyApp.setLocale(context, Locale('mr', 'IN'));
      }

      try {
        Map data = {"username": _email, "password": _password};
        var response = await http.post("$url", body: data);
        //var jsonObject = json.decode(response.body);
        //  var userData =(jsonObject as Map<String, dynamic>)["data"];
        Map<String, dynamic> jsonData = json.decode(response.body);
        String token = jsonData['token'];
        String name = jsonData['name'];
        if (response.statusCode == 200) {
          print(response.body);
          if(jsonData['token'] != null){
              print('token ::::  $token');
              JWTProvider().setToken(token, _email);
              JWTProvider().setName(name);
              Navigator.of(context).pushNamedAndRemoveUntil('homescreen', (Route<dynamic> route) => false);
          }
          setState(() {
            loading = false;
          });

          print(jsonData);
          // Navigator.pop(context);
          //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(userToken: jsonObject,) ));

        } else {
          Methods.showSnackBar("Username or password is incorrect", context);
          setState(() {
            loading = false;
          });
        }
      } on SocketException catch (error) {
        print('SOCKET EXCEPTION ERROR $error');
        setState(() {
          loading = false;
        });
        Methods.showSnackBar("Internal Server Error", context);
        // print(error);

      } catch (e) {
        setState(() {
          loading = false;
        });
        Methods.showSnackBar(e.toString(), context);
        // print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xffF7F7F7),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          setState(() {
            isEnglishSelected = false;
            isHindiSelected = false;
          });
        },
          child: SingleChildScrollView(
          child: Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(height: 20,),
              Container(
                  //color: Colors.grey,
                  height: MediaQuery.of(context).size.height / 3.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      
                      Image(
                      height: 120,
                      image: AssetImage('images/app-logo.jpg'),
                      //fit: BoxFit.fill,
                    ),
                    Text(
                      DemoLocalization.of(context).translate('healthcare'),
                     style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 33, fontWeight: FontWeight.w700),)
                    ]
                  )),
                   SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: TextFormField(
                  autofocus: false,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    //contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.0),),
                      borderSide: BorderSide.none
                    ),
                    suffixIcon: Icon(
                         Icons.person,size: 10,
                          color: Theme.of(context).primaryColor
                    ),
                      prefixIcon:Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Icon(
                          Icons.person,size: 30,
                          color: Color(0xff939393),
                        ),
                      ),
                      hintStyle: TextStyle(color: Color(0xff939393), fontSize: 15, fontFamily: "Montserrat"),
                      hintText: DemoLocalization.of(context).translate('email'),
                      //border: InputBorder.none,
                      // border: new OutlineInputBorder(),

                      filled: true,
                      fillColor: Theme.of(context).primaryColor),
                  validator: (val) =>
                      val.length < 10 ? DemoLocalization.of(context).translate('validNumber') : null,
                  onSaved: (val) => _email = val,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 18.0, left: 30.0, right: 30.0),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  obscureText: passWordVisible,
                  autofocus: false,
                  decoration: InputDecoration(
                    //contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.0),),
                      borderSide: BorderSide.none
                    ),
                      prefixIcon:Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Icon(
                          Icons.lock,
                          size: 25,
                          color: Color(0xff939393),
                        ),
                      ),
                      hintStyle: TextStyle(color: Color(0xff939393),fontSize: 17, fontFamily: "Montserrat" ),
                      hintText: DemoLocalization.of(context).translate('password'),
                      suffixIcon: IconButton(
                        icon: Icon(
                          passWordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Color(0xff939393),
                        ),
                        onPressed: togglePasswordVisiblity,
                        iconSize: 25.0,
                      ),
                      // border: new OutlineInputBorder(),
                      filled: true,
                      fillColor: Theme.of(context).primaryColor),
                  validator: (val) =>
                      val.length < 4 ? DemoLocalization.of(context).translate('passShort') : null,
                  onSaved: (val) => _password = val,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Center(
                  child: Text(
                    DemoLocalization.of(context).translate('chooselang'),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      color: isEnglishSelected ? Color(0xff508782) : Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      onPressed: () {
                        setState(() {
                          isEnglishSelected = true;
                          isHindiSelected = false;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("English", style: TextStyle(fontSize: 22),),
                      ),
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(4.0)),
                    ),
                    SizedBox(
                      width: 35.0,
                    ),
                    FlatButton(
                      color: isHindiSelected ? Color(0xff508782) :Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      onPressed: () {
                        setState(() {
                          isHindiSelected = true;
                          isEnglishSelected = false;
                        }); // 508782
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Marathi", style: TextStyle(fontSize: 22),),
                      ),
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(4.0)),
                    )
                  ],
                ),
              ),
              MyRaisedButton(
                onPressed: _login,
                title: DemoLocalization.of(context).translate('login'),
                buttonColor: Theme.of(context).primaryColor,
                textColor: AppColors.colorWhite,
                loading: loading,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0, bottom: 20.0),
                child: Container(
                  width:MediaQuery.of(context).size.width/1.1,
                  height: MediaQuery.of(context).size.height/13,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10.0),
                    // boxShadow: <BoxShadow>[
                    // BoxShadow(color: loading ? Colors.grey : Theme.of(context).primaryColor, blurRadius: 5)],
                  ),
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                    onPressed: () {
                      if(isEnglishSelected == true){
                      JWTProvider().changeLang('en');
                      MyApp.setLocale(context, Locale('en', 'US'));
                      }
                      else{
                        JWTProvider().changeLang('mr');
                        MyApp.setLocale(context, Locale('mr', 'IN'));
                      }
                      //Navigator.pushNamed(context, 'homescreen');
                      Navigator.pushNamed(context, 'registerscreen');
                    },
                    child: Text(DemoLocalization.of(context).translate('signup'),
                        style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 18.0),
              //   child: Center(
              //     child: Text(
              //       "Or Sign Up Using",
              //       style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 20.0,
              //           color: Theme.of(context).secondaryHeaderColor),
              //     ),
              //   ),
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     Image(
              //       image: AssetImage('facebook.ico'),
              //     ),
              //     //twitter dummy
              //     Image(
              //       image: AssetImage('facebook.ico'),
              //     ),
              //     Image(
              //       image: AssetImage('google.ico'),
              //     ),
              //   ],
              // ),
            ],
          ),
            ),
          //  ),
        ),
      ),
    );
  }
}
