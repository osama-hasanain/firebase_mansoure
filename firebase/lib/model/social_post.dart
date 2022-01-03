class SocialPostModel{
  String? name;
  String? uId;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;

  SocialPostModel({
    this.name,
    this.uId,
    this.image,
    this.dateTime,
    this.text,
    this.postImage,
  });

  SocialPostModel.fromMap(Map<String,dynamic> map){
    this.name = map['name'];
    this.uId = map['uId'];
    this.image = map['image'];
    this.dateTime = map['dateTime'];
    this.text = map['text'];
    this.postImage = map['postImage'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name':this.name,
      'uId':this.uId,
      'image':this.image,
      'dateTime':this.dateTime,
      'text':this.text,
      'postImage':this.postImage,
    };
  }
}