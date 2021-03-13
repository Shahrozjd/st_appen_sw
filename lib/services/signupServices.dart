import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:st_appen/models/signupModels.dart';


class signupServices{

  static const ADD_URL = "https://st-appen.herokuapp.com/users";

  Future<String> SignupUser(signupModel signupmodel)async{
    final response = await http.post(ADD_URL, body: signupmodel.toJsonAdd());
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