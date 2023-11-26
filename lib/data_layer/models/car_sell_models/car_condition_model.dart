class CarConditionModel {
  int? condition ;
  String? notes;
  String? name;
  String? nameEn;
  int? order;

  CarConditionModel({
    this.condition,
    this.notes,
    this.name,
    this.order,
  });

  CarConditionModel.fromJson(Map<String,dynamic> json){
    condition = json['condition'];
    notes = json['notes'];
    name = json['name'];
    nameEn = json['nameEn'];
    order = json['order'];

  }

  Map<String,dynamic> toMap()
  {
    return
      {
        'condition' : condition ,
        'notes' : notes ,
        'name' : name ,
        'nameEn' : nameEn ,
        'order' : order ,
      };
  }
}