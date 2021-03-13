import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:st_appen/components/constants.dart';
import 'package:st_appen/screens/bottomnav.dart';
import 'package:st_appen/screens/welcome.dart';

class splashscreen extends StatefulWidget {
  @override
  _splashscreenState createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {

  Box usersessBox = Hive.box('usersession');
  int usersesskey = 100;
  String userid;

  chechklogin(){

    bool islogged = usersessBox.get(usersesskey,defaultValue: false);

    if(islogged)
      {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => PersistentBottomBar()));
      }
    else
      {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => welcomepage()));
      }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 2),
            () => chechklogin());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/splashbg.png")
              )
            ),
            child: Center(child: Text('ST-APPEN',style: TextStyleHeadingBold,)),
          ),
        ),
      ),
    );
  }
}
