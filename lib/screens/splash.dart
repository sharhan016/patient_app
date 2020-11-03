import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:patient_app/functions/jwt.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> checkFirstSeen() async {
    String token = await JWTProvider().token;

    if (token != null) {
      // Check If user is logged in,if not redirect to Signin Screen
      return Navigator.pushNamedAndRemoveUntil(
        context,
        'homescreen',
        ModalRoute.withName('/splashscreen'),
      );
    }
    else{
      return Navigator.pushNamedAndRemoveUntil(
        context,
        'loginscreen',
        ModalRoute.withName('/splashscreen'),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    new Timer(new Duration(milliseconds: 500), () {
      checkFirstSeen();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffF7F7F7),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Spacer(),
                SizedBox(height: height/4,),
                 Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    height: 500,
                    width: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/app-logo.jpg'),
                        alignment: Alignment.center
                      )
                    ),
                  ),),
                  SizedBox(height: height/4.5,)

              //  Expanded(
              //       child:Column(
              //           children: [
              //             SizedBox(height: 20,),
              //             RichText(
              //               textAlign: TextAlign.center,
              //               text: TextSpan(
              //                 children: [
              //                   TextSpan(
              //                     text: "HealthCare\n",
              //                     style: Theme.of(context).textTheme.headline4.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
              //                   ),
              //                   TextSpan(
              //                     text: "Making Life Easier",
              //                     style: TextStyle(
              //                       fontSize: 14,
              //                       color: Theme.of(context).primaryColor
              //                     )
              //                   ),
              //                 ]
              //               ))
              //           ],
              //       ) ,
              //     )
            ],
          ),
        ],
      ),
      
    );
  }
}