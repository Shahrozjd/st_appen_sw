import 'package:flutter/material.dart';
import 'constants.dart';

class RoundButtonCustom extends StatelessWidget {
  String textval;
  double height;
  double width;
  Function onpress;
  Color color;


  RoundButtonCustom({this.textval, this.height, this.width,this.onpress,this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Material(
        borderRadius: BorderRadius.circular(100),
        color: color,
        elevation: 5.0,
        child: MaterialButton(
          splashColor: Colors.transparent,
          onPressed: onpress,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(textval, style: TextStyleFormBlack),
        ),
      ),
    );
  }
}
