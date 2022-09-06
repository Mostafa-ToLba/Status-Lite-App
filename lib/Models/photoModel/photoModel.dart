
class PhotoModel{
  String? image;
  String?time;

  PhotoModel({this.image,this.time});

  PhotoModel.fromJson(Map<String,dynamic>json)
  {
    image=json['image'];
    time=json['time'];
  }

  Map<String,dynamic>toMap()
  {
    return {
      'image':image,
      'time':time,
    };
  }

}
