import 'package:flutter/material.dart';

class SymptomCard extends StatelessWidget {
 final String title;
 final Widget row;
  // bool value;
  // Function onChanged;

  SymptomCard({
    @required this.title,
    @required this.row,
    //@required this.value,
    //@required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
                height: 90,
                margin: EdgeInsets.only(top: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 2),
                  borderRadius: BorderRadius.circular(7.0),
                  // color: Theme.of(context).primaryColor
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      row
                    ])
                ),
              );
  }
}