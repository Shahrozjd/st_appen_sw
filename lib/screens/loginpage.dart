import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:st_appen/components/DarkTextField.dart';
import 'package:st_appen/components/RoundButton.dart';
import 'package:st_appen/components/constants.dart';
import 'package:st_appen/models/loginmodel.dart';
import 'package:st_appen/screens/bottomnav.dart';
import 'package:st_appen/screens/registerpage.dart';
import 'package:st_appen/services/loginServices.dart';
import 'package:toast/toast.dart';

class loginpage extends StatefulWidget {
  @override
  _loginpageState createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  bool loading = false;
  String email;
  String password;

  Box usersessBox = Hive.box('usersession');
  int usersesskey = 100;
  int useridkey = 101;

  loginuser(loginModel loginmodel) async {
    await loginServices().LoginUser(loginmodel).then((value) {
      print(value);
      setState(() {
        if (value == "ERROR") {
          Toast.show("Fel vid inloggning, kontrollera dina uppgifter", context,
              gravity: Toast.BOTTOM, duration: 3);
          loading = false;
        } else {
          final body = json.decode(value);
          String id = body['_id'];
          usersessBox.put(useridkey, id.toString());
          usersessBox.put(usersesskey, true);
          Toast.show("Logga in, framgång", context,
              gravity: Toast.BOTTOM, duration: 3);
          loading = false;

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => PersistentBottomBar()));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loading,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Logga in",
                    style: TextStyleHeadingAccentBold,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset("images/signup.jpg"),
                  Column(
                    children: [
                      DarkTextField(
                        hasfocus: true,
                        obscuretext: false,
                        inputtype: TextInputType.emailAddress,
                        labeltext: "Namn",
                        hintext: "Skriv in ditt användarnamn",
                        onChanged: (String getEmail) {
                          email = getEmail;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DarkTextField(
                        hasfocus: true,
                        obscuretext: true,
                        inputtype: TextInputType.text,
                        labeltext: "Lösenord",
                        hintext: "Skriv in lösenord",
                        onChanged: (String getPass) {
                          password = getPass;
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RoundButton(
                    textval: 'Logga in',
                    onpress: () {
                      setState(() {
                        if (email != null && password != null) {
                          loading = true;

                          loginModel loginmodel = new loginModel(
                            name: email,
                            password: password,
                          );
                          loginuser(loginmodel);
                        }
                        else {
                          Toast.show("Snälla Fyll i alla fält", context,
                              gravity: Toast.BOTTOM, duration: 2);
                        }
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Har du inget konto? ",
                          style: TextStyle(
                              color: Color(0xFF656565), fontSize: 16)),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterPage()));
                          },
                          child: Text(
                            "Bli Medlem",
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
      ),
    );
  }
}
