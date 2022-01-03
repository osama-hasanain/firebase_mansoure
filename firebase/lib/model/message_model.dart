class MessageModelModel{
  String? senderId;
  String? receiverId;
  String? dateTime;
  String? text;


  MessageModelModel({
   this.senderId,
   this.receiverId,
   this.dateTime,
   this.text,
  });

  MessageModelModel.fromMap(Map<String,dynamic> map){
    this.senderId = map['senderId'];
    this.receiverId = map['receiverId'];
    this.dateTime = map['dateTime'];
    this.text = map['text'];
  }

  Map<String,dynamic> toMap() {
    return {
      'senderId': this.senderId,
      'receiverId': this.receiverId,
      'dateTime': this.dateTime,
      'text': this.text,
    };
  }

}