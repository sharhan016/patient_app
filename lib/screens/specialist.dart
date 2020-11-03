import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:patient_app/localization/localization.dart';
import 'package:provider/provider.dart';
import '../components/customAppBar.dart';
import '../providers/doctors.dart';


class SpecialistScreen extends StatefulWidget {
  @override
  _SpecialistScreenState createState() => _SpecialistScreenState();
}

class _SpecialistScreenState extends State<SpecialistScreen> {

  @override
  void initState() {
    var doctorProvider = Provider.of<DoctorsProvider>(context, listen: false);
    doctorProvider.getSpeciality();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var doctorProvider = Provider.of<DoctorsProvider>(context, listen: true);
    return Scaffold(
      appBar: CustomAppBarComponent(
        title: DemoLocalization.of(context).translate('specialist'),
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
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            // Title
            SizedBox(height: 10,),
            // Text(
            //   'Specialists',
            //   style: TextStyle(
            //     fontWeight: FontWeight.bold,
            //     fontSize: 21,
            //   ),
            // ),

            // List
            doctorProvider.loaderStatus == LoaderStatus.busy ? 
            SpinKitCircle(color: Colors.teal, size: 30)
             :
            Expanded(
              child: ListView.builder(
                itemCount: doctorProvider.speciality.length,
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  var id = doctorProvider.speciality[index]['id'].toString();
                  var tag = doctorProvider.speciality[index]['tag_name'].toString();
                  return InkWell(
                      onTap: () => {
                        Navigator.pushNamed(
                        context,
                        'specialistscreen',
                        arguments: {
                          'id': id,
                          'tag': tag
                        }),
                        print('specialist id $id')
                      },
                      child: Container(
                      height: 140,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            margin: EdgeInsets.all(8),
                            width: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 10,),
                                Text(
                                  doctorProvider.speciality[index]['tag_name'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 21,
                                  ),
                                ),

                                Expanded(
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            doctorProvider.speciality[index]['description'],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              // child: Container(
                              // height: 125,
                              // decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                              // child: Image.network('https://images.unsplash.com/photo-1473992243898-fa7525e652a5' ),
                                  child: Image.network(
                                    'http://hd.wallpaperswide.com/thumbs/medical_symbol-t2.jpg', 
                                  height: 125, fit: BoxFit.fill, ),
                                  //image: AssetImage('images/user.PNG'),
                                  // fit: BoxFit.fill,
                                  // height: 125,
                                  ),
                              ),
                              
                    
                          //)
                          //Image
                          // Expanded(
                          //   child: Image(height: 140,
                          //     image: AssetImage(
                          //       'images/user.PNG',
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
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
