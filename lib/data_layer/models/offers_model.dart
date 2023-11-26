import 'package:cloud_firestore/cloud_firestore.dart';

class OffersModel {
  String? name ;
  String? description;
  String? image;
  String? offerPhotoNameInStorage;
  String? id;
  bool? isExpired;
  Timestamp? expireDate;
  Timestamp? addedTime;

  OffersModel({
    this.name,
    this.description,
    this.image,
    this.offerPhotoNameInStorage,
    this.id,
    this.isExpired,
    this.expireDate,
    this.addedTime,
  });

  OffersModel.fromJson(Map<String,dynamic> json){
    name = json['name'];
    description = json['description'];
    image = json['image'];
    offerPhotoNameInStorage = json['offerPhotoNameInStorage'];
    id = json['id'];
    isExpired = json['isExpired'];
    expireDate = json['expireDate'];
    addedTime = json['addedTime'];
  }

  Map<String,dynamic> toMap()
  {
    return
      {
        'name' : name ,
        'description' : description ,
        'image' : image ,
        'offerPhotoNameInStorage' : offerPhotoNameInStorage ,
        'isExpired' : isExpired ,
        'id' : id ,
        'expireDate' : expireDate,
        'addedTime' : addedTime ,
      };
  }
}