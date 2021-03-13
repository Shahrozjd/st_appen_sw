import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:st_appen/models/operationChartModel.dart';


class operationChartServices{



  List<operationChartModel> chartfromJson(String jsonstring) {
    final data = json.decode(jsonstring);
    print(data);
    return List<operationChartModel>.from(
      data.map(
            (item) => operationChartModel.fromJson(item),

      ),
    );
  }

  Future<List<operationChartModel>> getOperation(String id) async {

    String GET_URL = "https://st-appen.herokuapp.com/users/"+id+"/graph-Operations";

    final response = await http.get(GET_URL);

    if (response.statusCode == 200) {
      List<operationChartModel> list = chartfromJson(response.body);
      return list;
    } else {
      return List<operationChartModel>();
    }
  }
  Future<List<operationChartModel>> getsubOperation(String id) async {

    String GET_URL = "https://st-appen.herokuapp.com/users/"+id+"/graph-subOperations";

    final response = await http.get(GET_URL);

    if (response.statusCode == 200) {
      List<operationChartModel> list = chartfromJson(response.body);
      return list;
    } else {
      return List<operationChartModel>();
    }
  }

}