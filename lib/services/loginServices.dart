import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:st_appen/models/loginmodel.dart';


class loginServices{

  static const ADD_URL = "https://st-appen.herokuapp.com/users/login";

  Future<String> LoginUser(loginModel clogin_model)async{
    final response = await http.post(ADD_URL, body: clogin_model.toJsonAdd());
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