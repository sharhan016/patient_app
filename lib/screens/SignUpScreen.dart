import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:patient_app/components/customAppBar.dart';
import 'package:patient_app/localization/localization.dart';

String number, _name, _email, _password, lat, long, _passwordAgain, _age;

bool loading = false;
bool passWordVisible = true;


class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  String address;
  Future<void> _getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var location = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    address = location[0].thoroughfare +
        ' ' +
        location[0].locality +
        ' ' +
        location[0].postalCode;
    lat = position.latitude.toString();
    long = position.longitude.toString();
  }

  String verificationId;
  TextEditingController locationController = TextEditingController();
  bool codeSent = false;
  bool _autoValidate = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarComponent(
        title: DemoLocalization.of(context).translate('register'),
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
      body: Builder(
        builder: (context) => Container(
          padding: EdgeInsets.symmetric(
            vertical: 4.0,
            horizontal: 4.0,
          ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 28.0),
          child: Form(
                key: _formKey,
                autovalidate: _autoValidate,
                child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: DemoLocalization.of(context).translate('name'),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor)),
                        ),
                        validator: (value) {
                          if (value.length < 3)
                            return DemoLocalization.of(context).translate('nameshort');
                          else
                            return null;
                        },
                        onSaved: (String val) {
                          _name = val;
                        },
                        // onChanged: (String value) {
                        //   _name = value;
                        // },
                      )),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: DemoLocalization.of(context).translate('email'),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor)),
                        ),
                        validator: validateEmail,
                        onChanged: (String value) {
                          _email = value;
                        },
                        onSaved: (newValue) => _email = newValue,
                      )),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: TextFormField(
                        decoration: InputDecoration(
                      //     prefix: Container(
                      //   child: Text('+91',),
                      //   margin: EdgeInsets.only(right: 5),
                      // ),
                          hintText: DemoLocalization.of(context).translate('phone'),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor)),
                        ),
                        maxLength: 10,
                         maxLines: 1,
                        //inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                        keyboardType: TextInputType.number,
                        onChanged: (String value) {
                          number = value;
                        },
                      )),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                    controller: locationController,
                    decoration: InputDecoration(
                      hintText: DemoLocalization.of(context).translate('location'),
                          //DemoLocalization.of(context).translate('location'),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.location_searching),
                        onPressed: () async {
                          await _getLocation();
                          locationController.text = address;
                        },
                      ),
                    ),
                    validator: (String value) => value.isEmpty
                        ? 
                        DemoLocalization.of(context).translate('location')
                        : null,
                  ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: DemoLocalization.of(context).translate('password'),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor)),
                        ),
                        validator: (value) {
                          if (value.length < 5)
                            return DemoLocalization.of(context).translate('passmore');
                          else
                            return null;
                        },
                        onChanged: (String value) {
                          _password = value;
                        },
                        onSaved: (newValue) => _password = newValue,
                      )),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: DemoLocalization.of(context).translate('passagain'),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor)),
                        ),
                        validator: (value) {
                          if (value != _password)
                            return DemoLocalization.of(context).translate('passnomatch');
                          else
                            return null;
                        },
                        onChanged: (String value) {
                          _passwordAgain = value;
                        },
                        onSaved: (newValue) => _passwordAgain = newValue,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  FlatButton(
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: _validateInputs,
                    //() {
                      // if (number == null || number.length != 10) {
                      //   final snackBar = SnackBar(
                      //     content: Text("Please enter a valid phone number."),
                      //   );
                      //   return Scaffold.of(context).showSnackBar(snackBar);
                      // }
                      // Navigator.pushNamed(
                      //   context,
                      //   'otpcheckscreen',
                      //   arguments: {
                      //     'name': _name,
                      //     'email': _email,
                      //     'number': number,
                      //     'age': '25',
                      //     'password': _password,
                      //     'address': address,
                      //     'latitude': lat,
                      //     'longitude': long
                      //   }
                      // );
                    //  Navigator.pushNamed(context, 'homescreen');
                    //},
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(DemoLocalization.of(context).translate('signup'),
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.normal)),
                    ),
                    shape: RoundedRectangleBorder(),
                  )
                ],
              ),
          ),
          ),
        ),
      ),
      ),
    );
  }

   String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return DemoLocalization.of(context).translate('validEmail');
    else
      return null;
  }

  void _validateInputs() {

      if (_formKey.currentState.validate()) {
    //    If all data are correct then save data to out variables
    _formKey.currentState.save();
    Navigator.pushNamed(
                        context,
                        'otpcheckscreen',
                        arguments: {
                          'name': _name,
                          'email': _email,
                          'number': number,
                          'age': '25',
                          'password': _password,
                          'address': address,
                          'latitude': lat,
                          'longitude': long
                        }
                      );

  } else {
//    If all data are not valid then start auto validation.
    setState(() {
      _autoValidate = true;
    });
  }

  }

}
