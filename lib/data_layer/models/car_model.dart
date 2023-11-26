class CarModel {
  String? model ;
  int? year;
  String? color;
  String? plate;
  String? transmission;
  String? bodyType;
  String? km;
  String? chassisNo;
  String? engineNo;

  CarModel({
    this.model,
    this.year,
    this.color,
    this.plate,
    this.transmission,
    this.bodyType,
    this.km,
    this.chassisNo,
    this.engineNo,
  });

  CarModel.fromJson(Map<String,dynamic> json){
    model = json['model'];
    year = json['year'];
    color = json['color'];
    plate = json['plate'];
    transmission = json['transmission'];
    bodyType = json['bodyType'];
    km = json['km'];
    chassisNo = json['chassisNo'];
    engineNo = json['engineNo'];
  }

  Map<String,dynamic> toMap()
  {
    return
      {
        'model' : model ,
        'year' : year ,
        'color' : color ,
        'plate' : plate ,
        'isAutomatic' : transmission ,
        'bodyType' : bodyType ,
        'km' : km ,
        'chassisNo' : chassisNo ,
        'engineNo' : engineNo ,
      };
  }
}