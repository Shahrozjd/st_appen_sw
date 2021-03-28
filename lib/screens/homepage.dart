import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:st_appen/components/constants.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:st_appen/components/customloading.dart';
import 'package:st_appen/models/operationChartModel.dart';
import 'package:st_appen/services/operationChartServices.dart';

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> with SingleTickerProviderStateMixin{

  Box usersessBox = Hive.box('usersession');
  int usersesskey = 100;
  int useridkey = 101;
  String userid;

  // TabController _tabController;



  @override
  void initState() {
    userid = usersessBox.get(useridkey, defaultValue: null);
    // _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Diagram',
          style: TextStyleHeadingBold,
        ),
        // bottom: TabBar(
        //   unselectedLabelColor: mainaccent,
        //   labelColor: Colors.white,
        //   tabs: [
        //     new Tab(icon: Text('Operation',style: TextStyleMedium,)),
        //     new Tab(icon: Text('Sub Operation',style: TextStyleMedium,),),
        //   ],
        //   controller: _tabController,
        //   indicatorColor: Colors.blue,
        //   indicatorWeight: 5,
        // ),
        bottomOpacity: 1,
      ),
      body: Operation(),
      // body: TabBarView(
      //   children: [
      //     Operation(),
      //     subOperation(),
      //   ],
      //   // controller: _tabController,
      // ),
    );
  }

  Widget Operation()
  {
    return Container(
      padding: EdgeInsets.all(20),
      child: FutureBuilder(
          future: operationChartServices().getOperation(userid),
          builder: (context,snapshot){
            if(snapshot.hasData)
              {
                List<operationChartModel> opData = [];
                for(int i=0;i<snapshot.data.length;i++)
                  {
                    operationChartModel opmodel =  snapshot.data[i];
                    opData.add(opmodel);
                  }
                List<charts.Series<operationChartModel, String>> seriesList =[
                  charts.Series<operationChartModel, String>(
                    id: 'Operations',
                    domainFn: (operationChartModel opchart, _) => opchart.id,
                    measureFn: (operationChartModel opchart, _) => opchart.count,
                    data: opData,
                    fillColorFn: (operationChartModel opchart, _) {
                      return charts.MaterialPalette.red.shadeDefault;
                    },
                  )
                ];

                return charts.BarChart(
                  seriesList,
                  animate: true,
                  vertical: false,
                );


              }
            return customloading();
          }),
    );
  }


  Widget subOperation(){
    return Container(
      padding: EdgeInsets.all(20),
      child: FutureBuilder(
          future: operationChartServices().getsubOperation(userid),
          builder: (context,snapshot){
            if(snapshot.hasData)
            {
              List<operationChartModel> opData = [];
              for(int i=0;i<snapshot.data.length;i++)
              {
                operationChartModel opmodel =  snapshot.data[i];
                opData.add(opmodel);
              }
              List<charts.Series<operationChartModel, String>> seriesList =[
                charts.Series<operationChartModel, String>(
                  id: 'subOperations',
                  domainFn: (operationChartModel opchart, _) => opchart.id,
                  measureFn: (operationChartModel opchart, _) => opchart.count,
                  data: opData,
                  fillColorFn: (operationChartModel opchart, _) {
                    return charts.MaterialPalette.deepOrange.shadeDefault;
                  },
                )
              ];

              return charts.BarChart(
                seriesList,
                animate: true,
                vertical: false,
              );


            }
            return customloading();
          }),
    );
  }
}
