import 'package:cloud_firestore/cloud_firestore.dart';

class SparePartsModel {
  String? name ;
  String? description ;
  String? image;
  String? category;
  bool? isShowPriceToCustomer;
  String? onePrice;
  String? id;
  String? sparePartPhotoNameInStorage;
  Timestamp? lastPriceUpdate;
  Map<String,dynamic>? mazda3 ;
  Map<String,dynamic>? mazda2 ;
  Map<String,dynamic>? mazda6 ;
  Map<String,dynamic>? mazdacx5 ;
  Map<String,dynamic>? mazdacx3 ;

  SparePartsModel({
    this.name,
    this.description,
    this.image,
    this.category,
    this.isShowPriceToCustomer,
    this.id,
    this.onePrice,
    this.sparePartPhotoNameInStorage,
    this.lastPriceUpdate,
    this.mazda3,
    this.mazda2,
    this.mazda6,
    this.mazdacx5,
    this.mazdacx3,
  });

  SparePartsModel.fromJson(Map<String,dynamic> json){
    name = json['name'];
    description = json['description'];
    image = json['image'];
    category = json['category'];
    isShowPriceToCustomer = json['isShowPriceToCustomer'];
    id = json['id'];
    onePrice = json['onePrice'];
    lastPriceUpdate = json['lastPriceUpdate'];
    mazda3 = json['mazda3'];
    mazda2 = json['mazda2'];
    mazda6 = json['mazda6'];
    mazdacx5 = json['mazdacx5'];
    mazdacx3 = json['mazdacx3'];
  }

  Map<String,dynamic> toMap()
  {
    return
      {
        'name' : name ,
        'description' : description ,
        'image' : image ,
        'category' : category ,
        'isShowPriceToCustomer' : isShowPriceToCustomer ,
        'id' : id ,
        'onePrice' : onePrice ,
        'sparePartPhotoNameInStorage' : sparePartPhotoNameInStorage ,
        'lastPriceUpdate' : lastPriceUpdate ,
      };
  }
}