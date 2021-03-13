class signupModel {
  dynamic name;
  dynamic year;
  dynamic speciality;
  dynamic password;
  dynamic hospital;
  dynamic medicales;

  signupModel(
      {this.name,
      this.year,
      this.speciality,
      this.password,
      this.hospital,});

  factory signupModel.fromJson(Map<String, dynamic> json) {
    return signupModel(
      name: json['name'],
      password: json['password'],
      year: json['year'],
      speciality: json['speciality'],
      hospital: json['hospital'],
    );
  }

  Map<String, dynamic> toJsonAdd() {
    return {
      'name': name,
      'password': password,
      'year': year,
      'speciality': speciality,
      'hospital': hospital,
    };
  }
}
