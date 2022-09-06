
class QouteModel{
  String? iconImage;
  String? name;
  String? time;

  QouteModel({this.iconImage,this.name,this.time});

  QouteModel.fromJson(Map<String,dynamic>json)
  {
    iconImage=json['iconImage'];
    name=json['name'];
    time=json['time'];
  }

  Map<String,dynamic>toMap()
  {
    return {
      'iconImage':iconImage,
      'name':name,
      'time':time,
    };
  }

}
