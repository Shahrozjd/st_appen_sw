class operationChartModel{
  dynamic id;
  dynamic count;

  operationChartModel({this.id, this.count});

  factory operationChartModel.fromJson(Map<String,dynamic> json){
    return operationChartModel(
      id: json['_id'],
      count: json['count'],
    );
  }
}