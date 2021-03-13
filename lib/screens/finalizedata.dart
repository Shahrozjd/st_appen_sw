import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:st_appen/components/RoundButton.dart';
import 'package:st_appen/components/constants.dart';
import 'package:st_appen/models/addDataModel.dart';
import 'package:st_appen/services/addDataService.dart';
import 'package:toast/toast.dart';

class finalizedata extends StatefulWidget {

  String suboperation;
  String operation;


  finalizedata({this.suboperation, this.operation});

  @override
  _finalizedataState createState() => _finalizedataState();
}

class _finalizedataState extends State<finalizedata> {
  String categ;
  List categ_list = [
    'Observator',
    'Assisterande',
    'Huvodoperator'];

  Box usersessBox = Hive.box('usersession');
  int usersesskey = 100;
  int useridkey = 101;
  String id;

  String note;
  DateTime date;

  bool loading = false;

  savedata(addDataModel addmodel, String userid)async{
    await addDataService().AddData(addmodel, userid).then((value){
      setState(() {
        if(value == "ERROR")
        {
          loading = false;
          Toast.show('Fel vid tillägg av data', context,gravity: Toast.BOTTOM,duration: 2);
        }
        else
          {
            final body = json.decode(value);
            String name = body['name'];
            if(name.isNotEmpty)
              {
                loading = false;
                Toast.show('Data har lagts till', context,gravity: Toast.BOTTOM,duration: 2);

              }
          }
      });
    });
  }

  @override
  void initState() {
    id = usersessBox.get(useridkey,defaultValue: null);
    print(widget.suboperation);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Slutför data',
          style: TextStyleHeadingAccentBold,
        ),
      ),
      body: ModalProgressHUD(

        inAsyncCall: loading,
        child: Container(
          padding: EdgeInsets.all(15),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  TextField(
                    onChanged: (String getNote){
                      note = getNote;
                    },
                    maxLines: 4,
                    decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: mainaccent)),
                      hintText: ' 🖊 Lägg till en anteckning',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Välj en operatör',
                        style: TextStyleMediumBlack,
                      ),
                      Container(
                        height: 100,
                        child: CupertinoPicker(
                          magnification: 2,
                          children: [
                            for (int i = 0; i < categ_list.length; i++)
                              Text(
                                categ_list[i],
                                style: TextStyleFormBlack,
                                textAlign: TextAlign.center,
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
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Välj Datum och tid',
                        style: TextStyleMediumBlack,
                      ),
                      Container(
                        height: 100,
                        child: CupertinoDatePicker(
                          initialDateTime: DateTime.now(),
                          onDateTimeChanged: (DateTime newdate) {
                            date = newdate;
                          },
                          minimumYear: 2010,
                          maximumYear: 2018,
                          minuteInterval: 1,
                          mode: CupertinoDatePickerMode.dateAndTime,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RoundButton(textval: 'Lägg till',height: 50,onpress: (){
                    setState(() {
                      if(id != null)
                        {
                          if(categ !=  null && note != null && date != null)
                            {
                              loading = true;
                              addDataModel addmodel = new addDataModel(
                                operationType: widget.operation,
                                subOperationType: widget.suboperation,
                                operator: categ,
                                date: date.toString(),
                                note: note,
                              );
                              savedata(addmodel, id);
                            }
                          else
                            {
                              Toast.show("Välj komplett formulär", context,gravity: Toast.BOTTOM,duration: 2);
                            }

                        }
                      else
                        {
                          Toast.show("Inget ID närvarande för ADD med", context,gravity: Toast.BOTTOM,duration: 3);
                        }
                    });
                  },)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
