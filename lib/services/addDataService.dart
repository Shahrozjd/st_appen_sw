import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:st_appen/models/addDataModel.dart';


class addDataService{



  List<addDataModel> medicalfromJson(String jsonstring) {
    final data = json.decode(jsonstring);
    print(data);
    return List<addDataModel>.from(
      data.map(
            (item) => addDataModel.fromJson(item),

      ),
    );
  }

  Future<List<addDataModel>> getMedicals(String id) async {

    String GET_URL = "https://st-appen.herokuapp.com/users/"+id+"/medical";

    final response = await http.get(GET_URL);

    if (response.statusCode == 200) {
      List<addDataModel> list = medicalfromJson(response.body);
      return list;
    } else {
      return List<addDataModel>();
    }
  }

  Future<String> AddData(addDataModel add_model,String id)async{

    String ADD_URL = "https://st-appen.herokuapp.com/users/"+id+"/medical";

    final response = await http.post(ADD_URL, body: add_model.toJsonAdd());
    if (response.statusCode == 200)
    {
      print(response.body);
      return response.body;
    }
    else{
      return "ERROR";
    }
  }

}