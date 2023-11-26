import 'package:cloud_firestore/cloud_firestore.dart';

class CarSellModel {
  String? docId ;
  String? sellerName ;
  String? sellerPhone;
  String? otherNotes;
  String? carName;
  int? carYear;
  int? km;
  String? plate;
  String? chassisNo;
  String? engineNo;
  bool? isSold;
  String? price;
  List<dynamic>? images ;
  List<dynamic>? imagesPath ;
  Timestamp? addedTime;
  int? overAllRating ;

  CarSellModel({
    this.docId,
    this.sellerName,
    this.sellerPhone,
    this.otherNotes,
    this.carName,
    this.carYear,
    this.km,
    this.plate,
    this.chassisNo,
    this.engineNo,
    this.isSold,
    this.price,
    this.images,
    this.imagesPath,
    this.addedTime,
    this.overAllRating,
  });

  CarSellModel.fromJson(Map<String,dynamic> json){
    docId = json['docId'];
    sellerName = json['sellerName'];
    sellerPhone = json['sellerPhone'];
    carName = json['carName'];
    carYear = json['carYear'];
    otherNotes = json['otherNotes'];
    km = json['km'];
    plate = json['plate'];
    chassisNo = json['chassisNo'];
    engineNo = json['engineNo'];
    isSold = json['isSold'];
    price = json['price'];
    images = json['images'];
    imagesPath = json['imagesPath'];
    addedTime = json['addedTime'];
    overAllRating = json['overAllRating'];
  }

  Map<String,dynamic> toMap()
  {
    return
      {
        'docId' : docId ,
        'sellerName' : sellerName ,
        'sellerPhone' : sellerPhone ,
        'otherNotes' : otherNotes ,
        'carName' : carName ,
        'carYear' : carYear ,
        'km' : km ,
        'plate' : plate ,
        'chassisNo' : chassisNo ,
        'engineNo' : engineNo ,
        'isSold' : isSold ,
        'price' : price ,
        'images' : images ,
        'imagesPath' : imagesPath ,
        'addedTime' : addedTime ,
        'overAllRating' : overAllRating ,
      };
  }
}