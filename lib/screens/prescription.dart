import 'package:flutter/material.dart';
import 'package:patient_app/components/customAppBar.dart';
import 'package:patient_app/localization/localization.dart';

class PrescriptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarComponent(
        title: DemoLocalization.of(context).translate('mysheet'),
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
      // appBar: AppBar(
      //   backgroundColor: Colors.cyanAccent,
      //   centerTitle: true,
      //   title: Row(
      //     children: [
      //       Text("My Prescriptions"),
      //       Icon(Icons.search),
      //     ],
      //   ),
      // ),
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Text(
              'No Record present',
              style: TextStyle( color: Color(0xff939393), fontSize: 15, fontFamily: "Montserrat")
            ),
          ),
          ),
          ),
        // child: ListView.builder(
        //   itemCount: 3,
        //   itemBuilder: (_, index) {
        //     return Container(
        //       margin: EdgeInsets.all(8),
        //       decoration: BoxDecoration(
        //         border: Border.all(color: Colors.cyanAccent),
        //         borderRadius: BorderRadius.circular(4),
        //       ),
        //       child: Row(
        //         children: [
        //           //Date
        //           Expanded(
        //             flex: 1,
        //             child: Container(
        //               color: Colors.cyanAccent,
        //               height: 80,
        //               child: Column(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   Text(
        //                     '19',
        //                     style: TextStyle(
        //                       fontWeight: FontWeight.bold,
        //                       color: Colors.white,
        //                     ),
        //                   ),
        //                   Text(
        //                     'SEP',
        //                     style: TextStyle(
        //                       fontWeight: FontWeight.bold,
        //                       color: Colors.white,
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),

        //           // Doctor Name
        //           Expanded(
        //             flex: 3,
        //             child: Center(
        //               child: Container(
        //                 margin:
        //                     EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        //                 child: Column(
        //                   children: [
        //                     Text(
        //                       'Dr. Sania Lin',
        //                       style: TextStyle(
        //                         fontWeight: FontWeight.bold,
        //                       ),
        //                     ),
        //                     Text(
        //                       'Prescription One',
        //                       style: TextStyle(
        //                         fontWeight: FontWeight.bold,
        //                         color: Colors.grey,
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           )
        //         ],
        //       ),
        //     );
        //   },
        // ),

     // ),
    );
  }
}
