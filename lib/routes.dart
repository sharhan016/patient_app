import 'package:flutter/material.dart';
import 'screens/LoginScreen.dart';
import 'screens/home.dart';
import 'screens/chat.dart';
import 'screens/prescription.dart';
import 'screens/SignUpScreen.dart';
import 'screens/doctorlist.dart';
import 'screens/otpcheck.dart';
import 'screens/symptomscreen.dart';
import 'screens/doctorProfile.dart';
import 'screens/specialist.dart';
import 'screens/splash.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name){
      case 'splashscreen':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case 'loginscreen':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case 'homescreen':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case 'chatscreen':
        return MaterialPageRoute(builder: (_) => ChatScreen());
      case 'registerscreen':
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case 'prescriptionscreen':
        return MaterialPageRoute(builder: (_) => PrescriptionScreen());
      case 'specialistscreen':
        var data = settings.arguments as Map;
        return MaterialPageRoute(builder: (_) => DoctorListScreen(
          specialist: data,
        ));
      case 'symptomscreen':
        var id = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => SymptomScreen(
          doctorId: id,
        ));
      case 'otpcheckscreen':
        var data = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (_) => OtpCheckScreen(
            info: data,
          ),
        );
        case 'doctorscreen':
        var data = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => DoctorProfile(
            doctorId : data,
          ),
        );
      case 'doctortypescreen':
        return MaterialPageRoute(builder: (_) => SpecialistScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Container(
              child: Center(
                child: Text('Check Route Name'),
              ),
            ),
          ),
        );
    }
  }
}