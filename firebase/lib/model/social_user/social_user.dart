class SocialUserModel{
  String? email;
  String? name;
  String? phone;
  String? uId;
  String? bio;
  String? image;
  String? cover;
  bool? isEmailVerified;

  SocialUserModel({
    this.email,
    this.name,
    this.phone,
    this.uId,
    this.bio,
    this.image,
    this.cover,
    this.isEmailVerified,
  });

  SocialUserModel.fromMap(Map<String,dynamic> map){
    this.email = map['email'];
    this.name = map['name'];
    this.phone = map['phone'];
    this.uId = map['uId'];
    this.bio = map['bio'];
    this.image = map['image'];
    this.cover = map['cover'];
    this.isEmailVerified = map['isEmailVerified'];
  }

  Map<String,dynamic> toMap(){
    return {
      'email':this.email,
      'name':this.name,
      'phone':this.phone,
      'uId':this.uId,
      'bio':this.bio,
      'image':this.image,
      'cover':this.cover,
      'isEmailVerified':this.isEmailVerified,
    };
  }
}