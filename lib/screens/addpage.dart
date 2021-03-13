import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:st_appen/components/RoundButton.dart';
import 'package:st_appen/components/constants.dart';
import 'package:st_appen/screens/orthopt.dart';
import 'package:st_appen/screens/surgeryopt.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:st_appen/screens/welcome.dart';
import 'package:toast/toast.dart';

class addpage extends StatefulWidget {
  @override
  _addpageState createState() => _addpageState();
}

class _addpageState extends State<addpage> {
  String categ;
  List categ_list = ["kirurgi", "Ortopedisk"];

  Box usersessBox = Hive.box('usersession');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'lägga till data',
          style: TextStyleHeadingAccentBold,
        ),
        actions: [
          IconButton(
              icon: Icon(
                FontAwesomeIcons.powerOff,
                color: Colors.black,
              ),
              onPressed: () {
                  usersessBox.clear();
                  pushNewScreen(context, screen: welcomepage(),withNavBar: false);
              })
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Välj ett alternativ',
                style: TextStyleMediumBlack,
              ),
              SizedBox(
                height: 50,
              ),
              CupertinoPicker(
                magnification: 2,
                children: [
                  Text(
                    "kirurgi",
                    style: TextStyleMediumBlack,
                  ),
                  Text(
                    "Ortopedisk",
                    style: TextStyleMediumBlack,
                  ),
                ],
                itemExtent: 30,
                looping: true,
                onSelectedItemChanged: (int value) {
                  setState(() {
                    categ = categ_list[value];
                    print(categ);
                  });
                },
              ),
              SizedBox(
                height: 50,
              ),
              RoundButton(
                textval: 'Next',
                onpress: () {
                  if (categ == 'kirurgi') {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => surgeryopt()));
                  } else if (categ == "Ortopedisk") {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => orthopt()));
                  } else {
                    Toast.show("Vänligen välj ett alternativ", context,
                        gravity: Toast.BOTTOM, duration: 2);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
