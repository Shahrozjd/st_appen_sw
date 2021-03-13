import 'package:flutter/material.dart';
import 'package:st_appen/components/RoundButton.dart';
import 'package:st_appen/components/RoundButtonWhite.dart';
import 'package:st_appen/components/constants.dart';
import 'package:st_appen/screens/loginpage.dart';
import 'package:st_appen/screens/registerpage.dart';

class welcomepage extends StatefulWidget {
  @override
  _welcomepageState createState() => _welcomepageState();
}

class _welcomepageState extends State<welcomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Välkommen till ST-APPEN',textAlign: TextAlign.center,style: TextStyleMediumAccent,),
              SizedBox(
                height: 40,
              ),
              Image.asset("images/wlcm_bg.jpg"),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RoundButton(textval: 'Logga in',height: 45,width: 100,onpress: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>loginpage()));
                },),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RoundButtonCustom(textval: 'Bli Medlem',height: 45,width: 100,onpress: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
                },color: mainaccentlight,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
