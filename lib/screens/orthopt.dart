import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:st_appen/components/RoundButton.dart';
import 'package:st_appen/components/constants.dart';
import 'package:toast/toast.dart';

import 'finalizedata.dart';

class orthopt extends StatefulWidget {
  @override
  _orthoptState createState() => _orthoptState();
}

class _orthoptState extends State<orthopt> {
  String categ;

  List categ_list = [
        'Ortopedi,'
        'Axel,'
        'Överarm,'
        'Armbåge,'
        'Underarm,'
        'Handled,'
        'Hand,'
        'Rygg,'
        'Bäcken,'
        'Höft,'
        'Lårben,'
        'Knä,'
        'Underben,'
        'Fotled,'
        'Fot,'
        'Barningrepp,'
        'Barnfrakturer,'
        'Annat,'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Ortopediskt alternativ',
          style: TextStyleHeadingAccentBold,
        ),
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
              Container(
                height: 200,
                child: CupertinoPicker(
                  magnification: 2,
                  children: [
                    for (int i = 0; i < categ_list.length; i++)
                      Text(
                        categ_list[i],
                        style: TextStyleFormBlack,
                      ),
                  ],
                  itemExtent: 20,
                  onSelectedItemChanged: (int value) {
                    setState(() {
                      categ = categ_list[value];
                      print(categ);
                    });
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              RoundButton(
                textval: 'Nästa',
                onpress: () {
                  if (categ != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => finalizedata(
                                  operation: 'Orthopedic',
                                  suboperation: categ,
                                )));
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
