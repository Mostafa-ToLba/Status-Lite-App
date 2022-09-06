

class TypeOfQoutesModel{

  String? Qoute;
  String?time;

  TypeOfQoutesModel({this.Qoute,this.time});

  TypeOfQoutesModel.fromJson(Map<String,dynamic>json)
  {
    Qoute=json['Qoute'];
    time=json['time'];
  }

  Map<String,dynamic>toMap()
  {
    return {
      'Qoute':Qoute,
      'time':time,
    };
  }

}
