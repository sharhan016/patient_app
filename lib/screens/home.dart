import 'package:flutter/material.dart';
import 'package:patient_app/functions/jwt.dart';
import 'package:patient_app/localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:patient_app/components/customAppBar.dart';
import '../providers/user.dart';
import 'package:patient_app/main.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
String name = 'patient';
   @override
  void initState() {
    super.initState();
    var userProvider =
        Provider.of<UserProvider>(context, listen: false);
    userProvider.getUserConsultationRecord();
    setLanguage();

  }

  setLanguage() async {
        String lang = await JWTProvider().language;
        print('In set language of home  $lang');
        switch (lang) {
          case 'en':
            MyApp.setLocale(context, Locale('en', 'US'));
            break;
          case 'mr':
            MyApp.setLocale(context, Locale('mr', 'IN'));
            break;
          default:
            MyApp.setLocale(context, Locale('en', 'US'));
            break;
        }
  }


  @override
  Widget build(BuildContext context) {
    var userProvider =
        Provider.of<UserProvider>(context, listen: true);
    if(userProvider.name != null){
      setState(() {
        name = userProvider.name;
      });
    }
    return Scaffold(
      key: _drawerKey,
      appBar: CustomAppBarComponent(
          title: DemoLocalization.of(context).translate('home'),
          leadingWidget: IconButton(
            icon: Icon(Icons.menu),
            iconSize: 30,
            color: Colors.white,
            onPressed: () => _drawerKey.currentState.openDrawer(),
          ),
          trailingWidget: IconButton(
            icon: Icon(Icons.search),
            iconSize: 30,
            color: Colors.transparent,
            onPressed: () {},
          ),
        ),
      //   AppBar(
      //   title: Text(
      //     'Home',
      //     style: TextStyle(
      //       color: Colors.white,
      //     ),
      //   ),
      //   centerTitle: true,
      //   actions: [
      //     IconButton(
      //       icon: Icon(
      //         Icons.search,
      //       ),
      //       color: Colors.transparent,
      //       //color: Colors.white,
      //       onPressed: () {},
      //     ),
      //   ],
      // ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: Row(
                  children: [
                    CircleAvatar(backgroundImage: AssetImage('images/profile.png'),
                      radius: 32,
                    ),
                    SizedBox(width: 8),
                    Text(name),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
            ),
            ListTile(
              title: Text(DemoLocalization.of(context).translate('home'),),
              onTap: () => Navigator.pop(context),
              trailing: Icon(Icons.arrow_right),
            ),
            // ListTile(  
            //   title: Text(DemoLocalization.of(context).translate('submit')), 
            //   onTap: () => Navigator.pushNamed(context, 'symptomscreen', arguments: "3"),
            //   trailing: Icon(Icons.arrow_right),
            // ),
            ListTile(
              title: Text(DemoLocalization.of(context).translate('bookconsult')),
              onTap: () => Navigator.pushNamed(context, 'doctortypescreen'),
              trailing: Icon(Icons.arrow_right),
            ),
            ListTile(
              title: Text(DemoLocalization.of(context).translate('mysheet')),
              onTap: () => Navigator.pushNamed(context, 'prescriptionscreen'),
              trailing: Icon(Icons.arrow_right),
            ),
            // ListTile(
            //   title: Text('FAQ'),
            //   onTap: () {},
            //   trailing: Icon(Icons.arrow_right),
            // ),
            // ListTile(
            //   title: Text('Help'),
            //   onTap: () {},
            //   trailing: Icon(Icons.arrow_right),
            // ),
            // ListTile(
            //   title: Text('Settings'),
            //   onTap: () {},
            //   trailing: Icon(Icons.arrow_right),
            // ),
            ListTile(
              title: Text(DemoLocalization.of(context).translate('logout')),
              onTap: () {
                JWTProvider().removeToken();
                Navigator.pushNamed(context, 'loginscreen');
              },
            ),
          ],
        ),
      ),

      // Body
      body: SingleChildScrollView(
        child: Container(
         // color: Colors.white70,
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Book Video Card
              SizedBox(height: 20,),
              // Container(
              //   width: MediaQuery.of(context).size.width * 0.4,
              //   padding: EdgeInsets.all(8),
              //   height: 80,
              //   color: Theme.of(context).primaryColor,
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       //Add Camera Image Here
              //       Text('Camera Image'),
              //       Row(
              //         children: [
              //           //Title
              //           Flexible(
              //             child: Text(
              //               'Book Video Consult Now',
              //               style: TextStyle(
              //                 fontWeight: FontWeight.bold,
              //                 color: Colors.white,
              //               ),
              //             ),
              //           ),
              //           SizedBox(width: 8),

              //           Icon(
              //             Icons.arrow_forward,
              //             color: Colors.white,
              //           ),
              //         ],
              //       )
              //     ],
              //   ),
              // ),

              // Health Articles
              // Text(
              //   'Health Articles',
              //   style: TextStyle(
              //     fontWeight: FontWeight.bold,
              //     fontSize: 21,
              //   ),
              // ),
              // Container(
              //   height: 200,
              //   margin: EdgeInsets.symmetric(vertical: 4),
              //   child: ListView.builder(
              //     shrinkWrap: true,
              //     itemCount: 4,
              //     scrollDirection: Axis.horizontal,
              //     itemBuilder: (_, index) {
              //       return Container(
              //         padding: EdgeInsets.all(8),
              //         width: 190,
              //         child: Column(
              //           children: [
              //             //Image
              //             Image(
              //               image: AssetImage('images/user.PNG'),
              //             ),
              //             //Text
              //             Container(
              //               padding: EdgeInsets.all(4),
              //               decoration: BoxDecoration(
              //                 border: Border.all(
              //                   color: Theme.of(context).primaryColor,
              //                 ),
              //                 borderRadius: BorderRadius.circular(4),
              //               ),
              //               child: Center(
              //                 child: Text('Understanding skin pigments'),
              //               ),
              //             )
              //           ],
              //         ),
              //       );
              //     },
              //   ),
              // ),

              // // Health Tracker
              // Text(
              //   'Health Tracker',
              //   style: TextStyle(
              //     fontWeight: FontWeight.bold,
              //     fontSize: 21,
              //   ),
              // ),
              // Container(
              //   height: 120,
              //   margin: EdgeInsets.symmetric(vertical: 4),
              //   child: ListView.builder(
              //     shrinkWrap: true,
              //     itemCount: 4,
              //     scrollDirection: Axis.horizontal,
              //     itemBuilder: (_, index) {
              //       return Container(
              //         decoration: BoxDecoration(
              //           border: Border.all(
              //             color: Theme.of(context).primaryColor,
              //           ),
              //           borderRadius: BorderRadius.circular(4),
              //         ),
              //         margin: EdgeInsets.all(8),
              //         width: 200,
              //         child: Column(
              //           children: [
              //             // Title
              //             Text(
              //               'Heart Rate',
              //               style: TextStyle(
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             ),

              //             Expanded(
              //               child: Center(
              //                 child: Row(
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   children: [
              //                     Text(
              //                       '40',
              //                       style: TextStyle(
              //                         fontWeight: FontWeight.bold,
              //                         color: Theme.of(context).primaryColor,
              //                         fontSize: 21,
              //                       ),
              //                     ),
              //                     SizedBox(width: 8),
              //                     Text(
              //                       'bpm',
              //                       style: TextStyle(
              //                         fontWeight: FontWeight.bold,
              //                         fontSize: 14,
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       );
              //     },
              //   ),
              // ),

              // My Doctors
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DemoLocalization.of(context).translate('mydoctors'),
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 19,
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, 'doctortypescreen'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                          DemoLocalization.of(context).translate('viewall'),
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 19,
                            color: Theme.of(context).primaryColor
                          ),
                    ),
                    Icon(Icons.arrow_right, color: Theme.of(context).primaryColor,)
                        ],
                      ),
                    )
                  ],
                ),
              ),
              userProvider.loaderStatus == LoaderStatus.busy ?
              SpinKitCircle(
                color: Colors.teal,
                size: 30
              ) :
              // userProvider.userConsultationData == [] ?
              // Container(height: 200,color: Colors.deepOrange,) :
              //Center(child: Text('No Consultation Record')) :
              recentConsultation(userProvider.userConsultationData)
            ],
          ),
        ),
      ),
    );
  }
  Widget recentConsultation (records){
    return Container(
                height: 220,
                margin: EdgeInsets.symmetric(vertical: 4),
                child: records.length == 0 ?
                Center(child: Text('\u{1F4C3} '+DemoLocalization.of(context).translate('norecord')),)
                : ListView.builder(
                  shrinkWrap: true,
                  itemCount: records.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    var consultDate = records[index]["last_consulted"];
                    DateTime lastDate = DateTime.parse(consultDate);
                    final df = new DateFormat('dd-MMM-yyyy');
                    var id = records[index]["doctor_id"];
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      margin: EdgeInsets.all(8),
                      width: 210,
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          Image(
                            image: AssetImage('images/user.PNG'),
                            width: 100,
                          ),
                          Text(
                            'Dr. '+ records[index]["doctor_name"].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(records[index]["department"].toString()),

                          // Book Button
                          FlatButton(
                            onPressed: () => Navigator.pushNamed(context, 'symptomscreen',arguments: id ),
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              DemoLocalization.of(context).translate('bookappoinment'),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          Flexible(
                            child: Text(
                              DemoLocalization.of(context).translate('lastconsult')+
                              df.format(lastDate).toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
}
}

/*


*/