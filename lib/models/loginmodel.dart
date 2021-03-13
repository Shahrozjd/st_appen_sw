class loginModel{
  dynamic name;
  dynamic password;


  loginModel({this.name, this.password});

  factory loginModel.fromJson(Map<String,dynamic> json){
    return loginModel(
        name: json['name'],
        password: json['password']
    );
  }

  Map<String,dynamic> toJsonAdd(){
    return {
      'name':name,
      'password':password,
    };
  }

}