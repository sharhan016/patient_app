import 'package:flutter/material.dart';
import 'package:patient_app/localization/localization.dart';
import '../components/customAppBar.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../providers/doctors.dart';

class DoctorListScreen extends StatefulWidget {

  final Map specialist;
  DoctorListScreen({@required this.specialist});

  @override
  _DoctorListScreenState createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {

  @override
  void initState() {
    var doctorProvider = Provider.of<DoctorsProvider>(context, listen: false);
    doctorProvider.getDoctorList(widget.specialist['id']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var doctorProvider = Provider.of<DoctorsProvider>(context, listen: true);
    return Scaffold(
      appBar: CustomAppBarComponent(
        title: widget.specialist['tag'],
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 10.0, 0.0, 7.0),
              child: Text(
                DemoLocalization.of(context).translate('doctors'),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
              ),
            ),

            doctorProvider.loaderStatus == LoaderStatus.busy ? 
            SpinKitCircle(color: Colors.teal, size: 30) :
            Expanded(child:  ListView.builder(
              shrinkWrap: true,
              itemCount: doctorProvider.doctorList.length,
              itemBuilder: (_, index) {
                var doctor = doctorProvider.doctorList;
                var id = doctor[index]['id'].toString();
                return Container(
                  child: Row(
                    children: [
                      // Body
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(8),
                        width: 230,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Name
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                  doctor[index]['doctor']['name'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 21,
                                ),
                              ),
                            ),

                            // Specialization
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                doctor[index]['speciality']['tag_name'],
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),

                            // Hospital Name
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                doctor[index]['hospital_name'] == null ? 'Hospital Name' : doctor[index]['hospital_name'],
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),

                            // Experience
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                doctor[index]['experience'].toString()+' '+DemoLocalization.of(context).translate('expitotal'),
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),

                            SizedBox(height: 10),

                            // Padding(
                            //   padding: const EdgeInsets.all(2.0),
                            //   child: Row(
                            //     children: [
                            //       // Rating
                            //       Row(
                            //         children: [
                            //           Icon(
                            //             Icons.thumb_up,
                            //             color: Colors.green,
                            //           ),
                            //           Text(
                            //             '98%',
                            //             style: TextStyle(
                            //               fontWeight: FontWeight.bold,
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //       SizedBox(width: 4),

                            //       // Stories
                            //       Expanded(
                            //         child: Row(
                            //           children: [
                            //             Icon(
                            //               Icons.chat,
                            //               color: Colors.green,
                            //             ),
                            //             Flexible(
                            //               child: Text(
                            //                 '420 patient stories',
                            //                 style: TextStyle(
                            //                   fontWeight: FontWeight.bold,
                            //                 ),
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // ),

                            // Fee
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "₹ "+doctor[index]['fees'].toString()+' ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: ' '+DemoLocalization.of(context).translate('consultfee'),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Availability
                            // Row(children: [
                            //   Icon(Icons.camera_alt),
                            //   Text(" 7:30 PM, Today")
                            // ]),

                            Row(
                              children: [

                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: FlatButton(
                                      color: Theme.of(context).primaryColor,
                                      onPressed: () {
                                          Navigator.pushNamed(
                                          context,
                                          'symptomscreen',
                                          arguments: id,);
                                          print('doctorList id $id');
                                      },
                                      child: Text(
                                        DemoLocalization.of(context).translate('bookappoinment'),
                                        style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),

                                // Book
                                // Expanded(
                                //   child: Padding(
                                //     padding: const EdgeInsets.all(4.0),
                                //     child: FlatButton(
                                //       color: Theme.of(context).primaryColor,
                                //       onPressed: () {},
                                //       child: Text(
                                //         'Book Video Consult',
                                //         style: TextStyle(fontSize: 11),
                                //       ),
                                //     ),
                                //   ),
                                // ),

                                // // Call
                                // Expanded(
                                //   child: Padding(
                                //     padding: const EdgeInsets.all(4.0),
                                //     child: FlatButton(
                                //       color: Theme.of(context).primaryColor,
                                //       onPressed: () {},
                                //       child: Text(
                                //         'Chat',
                                //         style: TextStyle(fontSize: 11),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                            
                          ],
                        ),
                      ),
                      Expanded(
                       // child: Image.network(doctor[index]['profile_pic'])

                        child: FadeInImage(
                        placeholder: AssetImage('images/placevalue.png',), 
                        image: NetworkImage(doctor[index]['profile_pic']),
                        fit: BoxFit.cover,
                        height: 185.0,
                        ),
                        ),
                      // Expanded(
                      //   child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(5.0),
                      //       child: Image.network(
                      //           //  doctor[index]['profile_pic'],
                      //          'https://images.unsplash.com/photo-1473992243898-fa7525e652a5', 
                      //       height: 180, fit: BoxFit.fill, ),
                      //       ),
                      //   ),
                        SizedBox(width: 5,)
                      // Image
                      // Flexible(
                      //   child: Image.asset('images/user.PNG',fit: BoxFit.fill,),
                      //     //image: AssetImage('images/user.PNG'),
                          
                      
                      // ),
                    ],
                  ),
                );
              },
            ),
            ),

            
          ],
        ),
      ),
    );
  }
}
