import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:st_appen/components/RoundButton.dart';
import 'package:st_appen/components/constants.dart';
import 'package:st_appen/screens/finalizedata.dart';
import 'package:toast/toast.dart';

class surgeryopt extends StatefulWidget {
  @override
  _surgeryoptState createState() => _surgeryoptState();
}

class _surgeryoptState extends State<surgeryopt> {
  String categ;

  List categ_list = [
    'Kirurgi',
    'Chirurgia minor',
    'Chirurgia major',
    'Laparotomi med medellinjesnitt',
    'Bukväggsförslutning  Diagnostisk laparoskopi',
    'Främre nätplastik av ljumskbråck',
    'Navelbråck',
    'Kolecystektomi (öppen)',
    'Lap kolecystektomi',
    'Gastroskopi',
    'Rektoskopi',
    'Sigmoideoskopi',
    'Koloskopi',
    'Appendektomi (öppen)',
    'Lap appendektomi',
    'Thoraxdrän',
    'Mastektomi och partiell mastektomi',
    'Kärlingrepp',
    'Suprapubisk kateter',
    'Explorera skrotum',
    'Handledarsamtal',
  ];

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
          'Alternativ för kirurgi',
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
                'Välj typ av operation',
                style: TextStyleMediumBlack,
              ),
              SizedBox(
                height: 10,
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
              SizedBox(
                height: 50,
              ),
              RoundButton(
                textval: 'Nästa',
                onpress: () {
                  if(categ != null)
                    {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => finalizedata(operation: 'Surgery',suboperation: categ,)));
                    }
                  else
                    {
                      Toast.show("Please choose an option", context,gravity: Toast.BOTTOM,duration: 2);
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
