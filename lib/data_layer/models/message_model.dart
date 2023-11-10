class MessageModel {
  String? senderId ;
  String? receiverId ;
  String? messageId ;
  dynamic dateTime;
  String? text;
  String? image;
  String? messageImageNamesInStorage;
  bool? isSeen ;

  MessageModel({
    this.senderId,
    this.receiverId,
    this.messageId,
    this.dateTime,
    this.text,
    this.image,
    this.messageImageNamesInStorage,
    this.isSeen,
  });

  MessageModel.fromJson(Map<String,dynamic> json){
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    messageId = json['messageId'];
    dateTime = json['dateTime'];
    text = json['text'];
    image = json['image'];
    messageImageNamesInStorage = json['imagePath'];
    isSeen = json['isSeen'];
  }

  Map<String,dynamic> toMap()
  {
    return
      {
      'senderId' : senderId ,
      'receiverId' : receiverId ,
      'messageId' : messageId ,
      'dateTime' : dateTime ,
        'text' : text ,
      'image' : image ,
      'imagePath' : messageImageNamesInStorage ,
      'isSeen' : isSeen ,

    };
  }
}