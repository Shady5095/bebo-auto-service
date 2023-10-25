class SparePartsModel {
  String? name ;
  String? image;
  String? category;
  String? id;
  SparePartPriceDetailsModel? price;
  SparePartPriceDetailsModel?  lifeSpan;

  SparePartsModel({
    this.name,
    this.image,
    this.category,
    this.id,
    this.price,
    this.lifeSpan,
  });

  SparePartsModel.fromJson(Map<String,dynamic> json){
    name = json['name'];
    image = json['image'];
    category = json['category'];
    id = json['id'];
  }

  Map<String,dynamic> toMap()
  {
    return
      {
        'name' : name ,
        'image' : image ,
        'category' : category ,
        'id' : id ,
      };
  }
}
class SparePartPriceDetailsModel {
  int? copy ;
  int? org ;
  int? estirad ;

  SparePartPriceDetailsModel.fromJson(Map<String,dynamic> json){
    copy = json['copy'];
    org = json['org'];
    estirad = json['estirad'];
  }

  Map<String,dynamic> toMap()
  {
    return
      {
        'copy' : copy ,
        'org' : org ,
        'estirad' : estirad ,
      };
  }
}