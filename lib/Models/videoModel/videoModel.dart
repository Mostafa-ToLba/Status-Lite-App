
class VideoModel{
  String? video;
  String? photo;

  VideoModel({this.video,this.photo});

  VideoModel.fromJson(Map<String,dynamic>json)
  {
    video=json['video'];
    photo=json['photo'];
  }

  Map<String,dynamic>toMap()
  {
    return {
      'video':video,
      'photo':photo,
    };
  }

}
