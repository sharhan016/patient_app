import 'package:flutter/material.dart';

class CustomAppBarComponent extends PreferredSize {
  final String title;
  final Widget leadingWidget;
  final Widget trailingWidget;
  CustomAppBarComponent({@required this.title, @required this.leadingWidget, @required this.trailingWidget});

  @override
  Size get preferredSize => Size.fromHeight(120);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 25,
        left: 10,
        right: 25,
      ),
      height: preferredSize.height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          leadingWidget,
          Flexible(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          trailingWidget
          // Image(
          //   image: AssetImage('images/splashLogo.png'),
          //   width: 50,
          // ),
        ],
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        // borderRadius: BorderRadius.only(
        //   bottomRight: Radius.circular(45),
        // ),
      ),
    );
  }
}
