import 'package:flutter/material.dart';
import 'package:patient_app/localization/localization.dart';
import '../components/customAppBar.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../providers/doctors.dart';
import 'package:intl/intl.dart';

class DoctorProfile extends StatefulWidget {
  final String doctorId;
  DoctorProfile({@required this.doctorId});

  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  List doctorList;

  @override
  void initState() {
    super.initState();
    var today = DateTime.now();
    String year = today.year.toString();
    String month = today.month.toString();
    String day = today.day.toString();
    String todayDate = '$year-$month-$day';
    print(todayDate);
    var doctorProvider = Provider.of<DoctorsProvider>(context, listen: false);
    doctorProvider.getDoctorProfile(widget.doctorId,todayDate);
  }


  @override
  Widget build(BuildContext context) {
    var doctorProvider = Provider.of<DoctorsProvider>(context, listen: true);
    var doctorData = doctorProvider.doctorData;

    var doctorProfileId = doctorProvider.doctorData['id'].toString();
    print('Doctor Profile Id:  $doctorProfileId');
    //slotProvider.getTimeSlots(doctorProfileId,todayDate);

    var slotstime = doctorProvider.timeslots;
    var slots = doctorProvider.availableSlots;
    var slotsAvailable = slots.length;
    return Scaffold(
        key: _drawerKey,
        appBar: CustomAppBarComponent(
          title: DemoLocalization.of(context).translate('doctor'),
          leadingWidget: IconButton(
            icon: Icon(Icons.arrow_back),
            iconSize: 30,
            color: Colors.white,
            onPressed: () => Navigator.pop(context),
          ),
          trailingWidget: IconButton(
            icon: Icon(Icons.search),
            iconSize: 30,
            color: Colors.transparent,
            onPressed: () {},
          ),
        ),
        //
        //body: SingleChildScrollView(
        body: Column(
         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            doctorProvider.loaderStatus == LoaderStatus.busy
                ? SpinKitCircle(color: Colors.teal, size: 30)
                : Expanded(child: doctorInfo(doctorData,slotsAvailable)),
            //SizedBox(height: 25,),
            doctorProvider.loaderStatus == LoaderStatus.busy
                ? SpinKitCircle(color: Colors.transparent, size: 30) :
            Container(
                //margin: const EdgeInsets.symmetric(vertical: 10.0),
                    margin: EdgeInsets.only(top: 10.0),
                    height: 1.5,
                    color: Theme.of(context).primaryColor
                  ),
            SizedBox(height: 20),
            doctorProvider.loaderStatus == LoaderStatus.busy
                  ? SpinKitCircle(
                      color: Colors.teal,
                      size: 20.0,
                    )
                  : Expanded(child: _buildTimeSlots(slotstime, doctorData),)
          ],
        )
        // ),
        );
  }

  Widget doctorInfo(doctorData,count) {
    var today = DateTime.now();
    final df = new DateFormat('MMMM d');
    var doctor = doctorData['doctor'];
    return Container(
      height: 150,
      child: ListView(
        children: [ 
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    // -----PROFILE PIC------
                  //  Image(
                      FadeInImage(
                        placeholder: AssetImage('images/placevalue.png'), 
                        image: NetworkImage(doctor['profile_pic'] == null ? 'http://hd.wallpaperswide.com/thumbs/medical_symbol-t2.jpg': doctor['profile_pic']),
                        height: 150,
                        width: 100,
                        ),
                      //Image.network(doctor['profile_pic']),
                      //image: NetworkImage(doctor['profile_pic']),
                      //image: AssetImage('images/user.PNG'),
                    //   width: 100,
                    // ),
                    SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text('Dr. '+doctor['name'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 19)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(doctorData['speciality']['tag_name'],
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 16)),
                      ],
                    )
                  ],
                ),
              ),

              //Text(doctor["id"].toString())
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
                  height: 2,
                  color: Theme.of(context).primaryColor
                ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                DemoLocalization.of(context).translate('availablity'),
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
                SizedBox(
                  height: 20,
                ),
                Container(
                  //padding: EdgeInsets.all(10.0),
                  //height: 250,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      slotInfo('Today', count),
                      //slotInfo('Tomorrow', '10')
                    ],
                  ),
                ),
                SizedBox(height: 60, 
                child: Center(
                  child: Text(DemoLocalization.of(context).translate('today')+' '+df.format(today).toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
                ),
                ),
                
                // SizedBox(
                //   height: 25,
                // ),
                // Container(
                //   height: 2,
                //   color: Theme.of(context).primaryColor
                // ),
                
              ],
            ),
          ),
          
        ],
      ),
    );
  }

  Widget slotInfo(String day, count) {
    return Container(
      height: 80,
      width: 160,
      decoration: BoxDecoration(
          color: day == 'Today'
              ? Theme.of(context).primaryColor
              : Colors.transparent,
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Theme.of(context).primaryColor, width: 3)),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Text(DemoLocalization.of(context).translate('today')+' ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
        Text('$count '+ DemoLocalization.of(context).translate('slotpresent'),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 19,
                color: Colors.green[800])),
      ]),
    );
  }

  Widget _buildTimeSlots(appoinments, doctorData) {
    var doctorProvider = Provider.of<DoctorsProvider>(context, listen: true);
    print(appoinments.length);
    var today = DateTime.now();
    String year = today.year.toString();
    String month = today.month.toString();
    String day = today.day.toString();
    String todayDate = '$year-$month-$day';
    if(appoinments.length > 0){
    return ListView.builder(
        itemCount: appoinments.length,
        itemBuilder: (context, index) {
          var hour =
              DateTime.parse(appoinments[index]["start_time"]).hour.toString();
          var minute = DateTime.parse(appoinments[index]["start_time"])
              .minute
              .toString();
          var id = appoinments[index]["id"].toString();
          var isBooked = appoinments[index]["is_booked"];
          var doctorId = doctorData['id'].toString();
          var hours = "";
          var minutes = "";
          if (hour.length == 1) {
            hours = "0$hour";
          } else {
            hours = hour;
          }
          if (minute.length == 1) {
            minutes = "0$minute";
          } else {
            minutes = minute;
          }
          var time = "$hours : $minutes";
          return Container(
              decoration: BoxDecoration(
                border: Border.all(width: 0.8),
                borderRadius: BorderRadius.circular(12.0),
              ),
              margin:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: InkWell(
                onTap: () => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(DemoLocalization.of(context).translate('confirmbook')),
                    content: Text(
                        DemoLocalization.of(context).translate('confirmbook')+"?"),
                    actions: <Widget>[
                      FlatButton(
                          onPressed: () {
                            //bookDoctorAppoinment(doctorData['id'], id),
                              doctorProvider.bookAppoinment(doctorId, id, todayDate);
                            // if(resopnse == '200'){
                            //   Navigator.of(context).pushNamedAndRemoveUntil('homescreen', (Route<dynamic> route) => false);
                            // }
                            //timeslotsProvider.deleteTimeSlots(id),
                            Navigator.of(context).pop(true);
                          },
                          child: Text(DemoLocalization.of(context).translate('confirm'))),
                      FlatButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text(DemoLocalization.of(context).translate('cancel')),
                      ),
                    ],
                  );
                },
              ),
                  child: ListTile(
                  leading: Text(time, style: TextStyle(fontSize: 16, color: isBooked == true ? Colors.red : Colors.green[900],decoration: isBooked == true ? TextDecoration.lineThrough: null), ),
                  trailing: Icon(Icons.chevron_right),
                  //title: appoinments[index]["is_booked"]==true?Text("Booked", style: TextStyle(color: Colors.green),):Text("Not Booked",style: TextStyle(color: Colors.red),),
                  // onTap: () => Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => BookingConfirm()),)
                ),
              ),
            );
        });
    }
    else{
     return  Container(
        height: 150,
        child: Center(child: Text(DemoLocalization.of(context).translate('timewillupdate')),),
      );
    }
  }
}

