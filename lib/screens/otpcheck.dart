import 'package:patient_app/localization/localization.dart';
import 'package:patient_app/providers/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:patient_app/utils/methods.dart';
//import 'package:timer_button/timer_button.dart';
import '../components/customAppBar.dart';
import '../functions/jwt.dart';

List<String> _otp = ["0", "0", "0", "0", "0", "0"];

updateotp(int index, String char) {
  _otp.removeAt(index);
  _otp.insert(index, char);
}

String _verificationId;

Future registerUser( String mobile, BuildContext context, String code, String number, email, password, name, age,address, lat,long) async {
  
  FirebaseAuth _auth = FirebaseAuth.instance;
  print(mobile);
  _auth.verifyPhoneNumber(
    phoneNumber: mobile,
    timeout: Duration(seconds: 60),
    verificationCompleted: (PhoneAuthCredential authCredential) async {
     await _auth.signInWithCredential(authCredential).then((UserCredential user) {
       Methods.showSnackBar(DemoLocalization.of(context).translate('vercreate'), context);
       _otpPass(context, number, email, password, name, age, address, lat, long);
     }).catchError((e) => print(e));
      // _auth.signInWithCredential(authCredential).then((AuthResult result) {
      //   _otpPass(context, number);
      // }).catchError((e) {
      //   print(e);
      // });
    },
    verificationFailed: (FirebaseAuthException authException) {
      print(authException.message);
    },
    codeSent: (String verificationId, [int forceResendingToken]) {
      print('CODE SENT');
      _verificationId = verificationId;
    },
    codeAutoRetrievalTimeout: (String verificationId) {
      _verificationId = verificationId;
      //if(verificationId == _verificationId){
        print('IN CODE AUTO RETRIEVAL TIMEOUT');
        Methods.showSnackBar(DemoLocalization.of(context).translate('vercreate'), context); //TODO:  add more duration
        _otpPass(context, number, email, password, name, age, address, lat, long);
     // }
    },
  );
}

void verifycode(BuildContext context, String number, email, password, name, age,address, lat,long ) async {
//Function for checking opt
  //Function Here//
  FirebaseAuth _auth = FirebaseAuth.instance;

  //Otp code
  String smsCode = _otp.join('');

  var authCredential = PhoneAuthProvider.credential(
      verificationId: _verificationId, smsCode: smsCode);
     await _auth.signInWithCredential(authCredential).then((UserCredential user) {
        Methods.showSnackBar(DemoLocalization.of(context).translate('vercreate'), context);
       _otpPass(context, number, email, password, name, age, address, lat, long);
     }).catchError((e) {
       print('ERROR OCCURED DURING VERIFICATION');
     });

  // auth.signInWithCredential(_credential).then((AuthResult result) {
  //   _otpPass(context, number);
  //   print('code sent');
  // }).catchError((e) {
  //   print(e);
  // });
}



_otpPass(BuildContext context, String number, email, password, name, age, address, lat, long) async {
  //Set the token in function, remove from here
  print('I AM IN OTP PASS');
  String token = await UserProvider().createUser(email, password, number, name, age,address, lat,long);
  print(token);
  //token stored in local storage
  if(token == 'ERROR'){
    Methods.showSnackBar(DemoLocalization.of(context).translate('alreadyExist'), context);
    Navigator.pop(context);
  }
  else{
    JWTProvider().setToken(token, number);
    JWTProvider().setName(name);
    Navigator.of(context).pushNamedAndRemoveUntil('homescreen', (Route<dynamic> route) => false);
  }
  
  // Navigator.pushNamedAndRemoveUntil(
  //   context,
  //   'termsscreen',
  //   ModalRoute.withName('/startupscreen'), 9061491176
  // );
}

class OtpCheckScreen extends StatefulWidget {
  //Globalkey for form
  //final String number;
  final Map info;
  OtpCheckScreen({@required this.info,});

  @override
  _OtpCheckScreenState createState() => _OtpCheckScreenState();
}

class _OtpCheckScreenState extends State<OtpCheckScreen> {
  final _otpKey = GlobalKey<FormState>();
  
  @override
  void initState() {
    super.initState();
    print(widget.info);
    registerUser('+91' + widget.info['number'], context, _otp.toString(), widget.info['number'], widget.info['email'], widget.info['password'], widget.info['name'], widget.info['age'], widget.info['address'], widget.info['latitude'], widget.info['longitude']);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments != null) print(arguments);

    return Scaffold(
      appBar: CustomAppBarComponent(
        title: DemoLocalization.of(context).translate('verification'),
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
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 32,
          horizontal: 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Logo
              // Image(
              //   image: AssetImage('images/pageLogo_1.png'),
              //   height: 95,
              // ),
              SizedBox(
                height: 20,
              ),

              //Message
              Text(
                DemoLocalization.of(context).translate('sendNumberText') +
                 
                    ' ${widget.info['number']}',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10),

              Text(DemoLocalization.of(context).translate('enterCode')),
              //Enter Code
              Builder(builder: (context) {
                return Form(
                  key: _otpKey,
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        margin: EdgeInsets.all(8),
                        child: TextFormField(
                          validator: (value) => value.length == 0 ? '' : null,
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(counterText: ''),
                          maxLength: 1,
                          keyboardType: TextInputType.number,
                          onChanged: (str) {
                            if (str.length >= 1) {
                              FocusScope.of(context).nextFocus();
                              updateotp(0, str);
                            }
                          },
                        ),
                      ),
                      Container(
                        width: 32,
                        margin: EdgeInsets.all(8),
                        child: TextFormField(
                          validator: (value) => value.length == 0 ? '' : null,
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(counterText: ''),
                          maxLength: 1,
                          keyboardType: TextInputType.number,
                          onChanged: (str) {
                            if (str.length >= 1) {
                              FocusScope.of(context).nextFocus();
                              updateotp(1, str);
                            }
                          },
                        ),
                      ),
                      Container(
                        width: 32,
                        margin: EdgeInsets.all(8),
                        child: TextFormField(
                          validator: (value) => value.length == 0 ? '' : null,
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(counterText: ''),
                          maxLength: 1,
                          keyboardType: TextInputType.number,
                          onChanged: (str) {
                            if (str.length >= 1) {
                              FocusScope.of(context).nextFocus();
                              updateotp(2, str);
                            }
                          },
                        ),
                      ),
                      Container(
                        width: 32,
                        margin: EdgeInsets.all(8),
                        child: TextFormField(
                          validator: (value) => value.length == 0 ? '' : null,
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(counterText: ''),
                          maxLength: 1,
                          keyboardType: TextInputType.number,
                          onChanged: (str) {
                            if (str.length >= 1) {
                              FocusScope.of(context).nextFocus();
                              updateotp(3, str);
                            }
                          },
                        ),
                      ),
                      Container(
                        width: 32,
                        margin: EdgeInsets.all(8),
                        child: TextFormField(
                          validator: (value) => value.length == 0 ? '' : null,
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(counterText: ''),
                          maxLength: 1,
                          keyboardType: TextInputType.number,
                          onChanged: (str) {
                            if (str.length >= 1) {
                              FocusScope.of(context).nextFocus();
                              updateotp(4, str);
                            }
                          },
                        ),
                      ),
                      Container(
                        width: 32,
                        margin: EdgeInsets.all(8),
                        child: TextFormField(
                          validator: (value) => value.length == 0 ? '' : null,
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(counterText: ''),
                          maxLength: 1,
                          keyboardType: TextInputType.number,
                          onChanged: (str) {
                            if (str.length >= 1) {
                              FocusScope.of(context).nextFocus();
                              updateotp(5, str);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }),
              SizedBox(height: 16),

              //Submit
              Builder(
                builder: (context) {
                  return Column(
                    children: [
                      //Resend button
                      //  Container(
                      //    margin: EdgeInsets.symmetric(vertical: 16),
                      //    child: TimerButton(
                      //         label: "Resend Code",
                      //         timeOutInSeconds: 60,
                      //         onPressed: () {
                      //           final snackBar = SnackBar(
                      //         content: Text(
                      //           "OTP has been resent to the number provided.",
                      //         ),
                      //       );
                      //       registerUser('+91' + widget.info['number'], context, _otp.toString(), widget.info['number'], widget.info['email'], widget.info['password'], widget.info['name'], widget.info['age'], widget.info['address'], widget.info['latitude'], widget.info['longitude']);
                      //       return Scaffold.of(context).showSnackBar(snackBar);
                      //         },
                      //         buttonType: ButtonType.OutlineButton,
                      //       ),
                      //  ),
                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: Text(DemoLocalization.of(context)
                              .translate('resendCode')),
                        ),
                        onTap: () {
                          setState(() {
                            _otp = ["", "", "", "", "", ""];
                          });
                          final snackBar = SnackBar(
                            content: Text(
                              DemoLocalization.of(context)
                              .translate('checkotp'),
                            ),
                          );
                          registerUser('+91' + widget.info['number'], context, _otp.toString(), widget.info['number'], widget.info['email'], widget.info['password'], widget.info['name'], widget.info['age'], widget.info['address'], widget.info['latitude'], widget.info['longitude']);
                          return Scaffold.of(context).showSnackBar(snackBar);
                        },
                      ),

                      //Submit Button
                //        Center(
                //          child: TimerButton(
                //             label: "Auto Verify",
                //             timeOutInSeconds: 15,
                //               onPressed: () {
                //           if (!_otpKey.currentState.validate()) {
                //             final snackBar = SnackBar(
                //               content: Text("Please enter a valid OTP"),
                //             );
                //             return Scaffold.of(context).showSnackBar(snackBar);
                //           }
                //           //Verifying code
                //           verifycode(context, widget.info['number'], widget.info['email'], widget.info['password'], widget.info['name'], widget.info['age'], widget.info['address'], widget.info['latitude'], widget.info['longitude'], );
                //         },
                //             buttonType: ButtonType.FlatButton,
                //             disabledColor: Colors.blueGrey[600],
                //             color: Theme.of(context).primaryColor
                // ),
                //        ),
                      FlatButton(
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          DemoLocalization.of(context).translate('submit'),
                          style: TextStyle(color: Colors.white),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        onPressed: () {
                          if (!_otpKey.currentState.validate()) {
                            final snackBar = SnackBar(
                              content: Text(DemoLocalization.of(context).translate('entervalidotp')),
                            );
                            return Scaffold.of(context).showSnackBar(snackBar);
                          }
                          //Verifying code
                          verifycode(context, widget.info['number'], widget.info['email'], widget.info['password'], widget.info['name'], widget.info['age'], widget.info['address'], widget.info['latitude'], widget.info['longitude'], );
                        },
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
