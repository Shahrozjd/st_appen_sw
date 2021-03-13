import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:st_appen/components/constants.dart';
import 'package:st_appen/components/customloading.dart';
import 'package:st_appen/models/addDataModel.dart';
import 'package:st_appen/services/addDataService.dart';

class reportpage extends StatefulWidget {
  @override
  _reportpageState createState() => _reportpageState();
}

class _reportpageState extends State<reportpage> {
  Box usersessBox = Hive.box('usersession');
  int usersesskey = 100;
  int useridkey = 101;
  String id;

  @override
  Widget build(BuildContext context) {
    id = usersessBox.get(useridkey, defaultValue: null);
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        backgroundColor: Color(0xFFFAFAFA),
        elevation: 0,
        title: Text(
          'Rapporter',
          style: TextStyleHeadingAccentBold,
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(15),
          child: FutureBuilder(
            future: addDataService().getMedicals(id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      addDataModel addmodel = snapshot.data[index];
                      return reportCards(
                        operation: addmodel.operationType,
                        suboperation: addmodel.subOperationType,
                        operator: addmodel.operator,
                        note: addmodel.note,
                        date: addmodel.date,
                      );
                    });
              }
              return customloading();
            },
          )),
    );
  }
}

class reportCards extends StatelessWidget {

  String operation = '';
  String suboperation = '';
  String operator = '';
  String date = '';
  String note = '';

  reportCards(
      {this.operation, this.suboperation, this.operator, this.date, this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(15),
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: mainaccentlight),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                "Operation: ",
                style: TextStyleMediumBold,
              ),
              Text(
                operator,
                style: TextStyleMedium,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Sub Operation: ",
                style: TextStyleMediumBold,
              ),
              Text(
                suboperation,
                style: TextStyleMedium,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Operatör: ",
                style: TextStyleMediumBold,
              ),
              Text(
                operator,
                style: TextStyleMedium,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "notera: ",
                style: TextStyleMediumBold,
              ),
              Text(
                note,
                style: TextStyleMedium,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "datum: ",
                style: TextStyleMediumBold,
              ),
              Text(
                date,
                style: TextStyleMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
