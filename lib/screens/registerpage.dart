import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:st_appen/components/DarkTextField.dart';
import 'package:st_appen/components/RoundButton.dart';
import 'package:st_appen/components/constants.dart';
import 'package:st_appen/models/signupModels.dart';
import 'package:st_appen/screens/loginpage.dart';
import 'package:st_appen/services/signupServices.dart';
import 'package:toast/toast.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool checkconsent = false;
  bool checkref = false;

  bool loading = false;
  String name, year, speciality, hospital, medicales, password;

  Box usersessBox = Hive.box('usersession');
  int usersesskey = 100;
  int useridkey = 101;

  signupuser(signupModel signupmodel) async {
    await signupServices().SignupUser(signupmodel).then((value) {
      setState(() {
        if (value == "ERROR") {
          loading = false;
          Toast.show(
              "Fel vid registrering, kontrollera dina uppgifter", context,
              gravity: Toast.BOTTOM, duration: 3);
        } else {
          final body = json.decode(value);
          String id = body['_id'];
          usersessBox.put(useridkey, id.toString());
          usersessBox.put(usersesskey, true);
          Toast.show("Registrerad, framgång", context,
              gravity: Toast.BOTTOM, duration: 3);
          loading = false;
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => loginpage()));
          String check = body['name'];
          // if(check == null)
          //   {
          //     Toast.show("Error Signing up, Check your Credentials", context,gravity: Toast.BOTTOM,duration: 3);
          //   }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loading,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
//                  Image.asset("images/sbazar_navheader.png",width: 100,height: 100,),
//                  SizedBox(
//                    height: 10,
//                  ),
                Text(
                  "Bli Medlem",
                  style: TextStyleHeadingAccentBold,
                ),
                DarkTextField(
                  hasfocus: true,
                  obscuretext: false,
                  inputtype: TextInputType.name,
                  labeltext: 'Namn',
                  hintext: 'Skriv in ditt användarnamn',
                  onChanged: (String getName) {
                    name = getName;
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                DarkTextField(
                  hasfocus: true,
                  obscuretext: false,
                  inputtype: TextInputType.number,
                  labeltext: 'år',
                  hintext: 'Ange år',
                  onChanged: (String getYear) {
                    year = getYear;
                  },
                ),

                SizedBox(
                  height: 10,
                ),
                DarkTextField(
                  hasfocus: true,
                  obscuretext: false,
                  inputtype: TextInputType.emailAddress,
                  labeltext: 'Specialitet',
                  hintext: 'Ange din specialitet',
                  onChanged: (String getSpeciality) {
                    speciality = getSpeciality;
                  },
                ),
                SizedBox(
                  height: 10,
                ),

                DarkTextField(
                  hasfocus: true,
                  obscuretext: false,
                  inputtype: TextInputType.text,
                  labeltext: 'sjukhus',
                  hintext: 'Gå in på sjukhus',
                  onChanged: (String getHospital) {
                    hospital = getHospital;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                DarkTextField(
                  hasfocus: true,
                  obscuretext: true,
                  inputtype: TextInputType.text,
                  labeltext: 'Lösenord',
                  hintext: 'Ange ditt lösenord (min. 8 tecken)',
                  onChanged: (String getPassword) {
                    password = getPassword;
                  },
                ),
                SizedBox(
                  height: 10,
                ),

                RoundButton(
                  textval: 'Registrera',
                  height: 40,
                  onpress: () {
                    setState(() {
                      if (name != null &&
                          password != null &&
                          year != null &&
                          hospital != null &&
                          speciality != null) {
                        loading = true;
                        signupModel signupmodel = new signupModel(
                          name: name,
                          password: password,
                          year: year,
                          hospital: hospital,
                          speciality: speciality,
                        );
                        signupuser(signupmodel);
                      } else {
                        Toast.show("Snälla Fyll i alla fält", context,
                            gravity: Toast.BOTTOM, duration: 2);
                      }
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("ELLER ",
                        style: TextStyle(color: Colors.black, fontSize: 18)),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => loginpage()));
                        },
                        child: Text(
                          "Logga in på ditt konto",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: mainaccent,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
