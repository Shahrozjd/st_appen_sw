class addDataModel{

  dynamic operationType;
  dynamic subOperationType;
  dynamic operator;
  dynamic date;
  dynamic note;

  addDataModel(
      {this.operationType,
      this.subOperationType,
      this.operator,
      this.date,
      this.note});

  factory addDataModel.fromJson(Map<String,dynamic> json){
    return addDataModel(
      operationType: json['operationType'],
      subOperationType: json['subOperationType'],
      operator: json['operator'],
      date: json['date'],
      note:json['note'],
    );
  }

  Map<String,dynamic> toJsonAdd()
  {
    return {
      'operationType' : operationType,
      'subOperationType':subOperationType,
      'operator':operator,
      'date':date,
      'note':note,

    };

  }
}