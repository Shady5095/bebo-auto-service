class UserModel {
  String? firstName ;
  String? lastName ;
  String? email ;
  String? password ;
  String? phone;
  int? points;
  String? uId;
  String? carModel ;
  int? year;
  String? color;
  String? plate;
  String? transmission;
  String? bodyType;
  int? km;
  String? chassisNo;
  String? engineNo;
  int? serviceStreak;

  UserModel({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.phone,
    this.uId,
    this.points,
    this.carModel,
    this.year,
    this.color,
    this.plate,
    this.transmission,
    this.bodyType,
    this.km,
    this.chassisNo,
    this.engineNo,
    this.serviceStreak,
  });

  UserModel.fromJson(Map<String,dynamic> json){
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    uId = json['uId'];
    points = json['points'];
    carModel = json['carModel'];
    year = json['year'];
    color = json['color'];
    plate = json['plate'];
    transmission = json['transmission'];
    bodyType = json['bodyType'];
    km = json['km'];
    chassisNo = json['chassisNo'];
    engineNo = json['engineNo'];
    serviceStreak = json['serviceStreak'];

  }

  Map<String,dynamic> toMap()
  {
    return
      {
      'firstName' : firstName ,
      'lastName' : lastName ,
      'email' : email ,
      'password' : password ,
      'phone' : phone ,
        'uId' : uId ,
      'points' : points ,
        'carModel' : carModel ,
        'year' : year ,
        'color' : color ,
        'plate' : plate ,
        'transmission' : transmission ,
        'bodyType' : bodyType ,
        'km' : km ,
        'chassisNo' : chassisNo ,
        'engineNo' : engineNo ,
        'serviceStreak' : serviceStreak ,
    };
  }
}