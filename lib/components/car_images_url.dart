import 'package:bebo_auto_service/components/components.dart';

String carPhotoUrl({
  required String carModel,
  required int carYear,
  required String carColor,
}) {
  String reformatCarModel = carModel.removeSpaceAndToLowercase();
  switch(reformatCarModel){
    case 'mazda2' : {
      return mazda2SwichCase(carColor: carColor);
    }
    case 'mazda3' : {
      return mazda3SwichCase(carColor: carColor,carYear: carYear);
    }
    case 'mazda6' : {
      return mazda6SwichCase(carColor: carColor,carYear: carYear);
    }
    case 'mazdacx3' : {
      return mazdacx3SwichCase(carColor: carColor);
    }
    case 'mazdacx5' : {
      return mazdacx5SwichCase(carColor: carColor);
    }
  }
  return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2021-2024%2Fmazda3_2020_red.png?alt=media&token=dbf503b1-7c2f-4f9b-b1e8-8eebbf4ead5b';
}

String mazda2SwichCase({
  required String carColor,
}){
  switch(carColor){
    case 'أحمر' :{
      return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda2%2Fmazda2_red.png?alt=media&token=dc9f87d0-214f-4449-85ea-8bf1d2e59ba6' ;
    }
    case 'أسود' : {
      return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda2%2Fmazda2_black.png?alt=media&token=d2fff149-ebb7-4752-91cf-903c4564fee8';
    }
    case 'أبيض' : {
      return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda2%2Fmazda2_white.png?alt=media&token=bfc17bde-7e2d-4270-a967-59c1fedd707a';
    }
    case 'رمادي' : {
      return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda2%2Fmazda2_grey.png?alt=media&token=1873305d-ed82-4033-adbe-58b0050c9b04';
    }
    case 'فضي' : {
      return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda2%2Fmazda2_silver.png?alt=media&token=63e5fcfb-1e57-4123-911e-366565022ac0';
    }
    case 'بني' : {
      return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda2%2Fmazda2_brown.png?alt=media&token=b344255d-a092-4fc8-8cd4-c20583e48406';
    }
    case 'أزرق' : {
      return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda2%2Fmazda2_blue.png?alt=media&token=6a25a1d6-b61c-4a3a-8632-282d1cfc6a68';
    }
  }
  return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda2%2Fmazda2_red.png?alt=media&token=dc9f87d0-214f-4449-85ea-8bf1d2e59ba6';
}

String mazda3SwichCase({
  required String carColor,
  required int carYear,
}){
  if(carYear <2010){
    switch(carColor){
      case 'أحمر' :{
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2005-2009%2Fmazda3_2005_red.png?alt=media&token=5ebea443-98d8-4f54-bedf-d0390ef9b738' ;
      }
      case 'أسود' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2005-2009%2Fmazda3_2005_black.png?alt=media&token=59e8fcf1-1252-483d-bb07-2f6f0b10880b';
      }
      case 'أبيض' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2005-2009%2Fmazda3_2005_white.png?alt=media&token=11b6a11c-9dca-4e54-928b-5db3f4062011';
      }
      case 'رمادي' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2005-2009%2Fmazda3_2005_grey.png?alt=media&token=1865f44e-99bb-427f-8b44-e12a42d575c1';
      }
      case 'فضي' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2005-2009%2Fmazda3_2005_silver.png?alt=media&token=e2d00986-587f-4ebe-9cb3-f968df818b53';
      }
      case 'بني' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2005-2009%2Fmazda3_2005_brown.png?alt=media&token=d45d5a46-f0a4-40a2-b4d1-2062d57005d9';
      }
      case 'فراني او كحلي' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2005-2009%2Fmazda3_2005_ferany.png?alt=media&token=7a8d05bc-8e5d-4b59-9041-9a5f266db443';
      }
      case 'أزرق' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2005-2009%2Fmazda3_2005_blue.png?alt=media&token=23fa1be1-7ad3-480e-aa25-c944e0005c6a';
      }
      case 'ذهبي' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2005-2009%2Fmazda3_2005_gold.png?alt=media&token=7d438bbc-f608-476f-a9d6-325fdadbe15f';
      }
      case 'بتنجاني' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2005-2009%2Fmazda3_2005_btngany.png?alt=media&token=f87fd980-fb69-4e93-bf02-a40862ccb507';
      }
    }
  }
  if(carYear >2009 && carYear < 2015){
    switch(carColor){
      case 'أحمر' :{
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2010-2014%2Fmazda3_2010_red.png?alt=media&token=c382e3f1-b699-4027-a9c5-c28cc8d7c2c6' ;
      }
      case 'أسود' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2010-2014%2Fmazda3_2010_black.png?alt=media&token=bf6b96e9-f0a4-4e58-acc3-9cffbdedd02c';
      }
      case 'أبيض' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2010-2014%2Fmazda3_2010_white.png?alt=media&token=36206558-e432-4452-9e7d-f1f029dab78c';
      }
      case 'رمادي' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2010-2014%2Fmazda3_2010_grey.png?alt=media&token=364ea11b-1703-4437-a818-d9d34fd774fa';
      }
      case 'فضي' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2010-2014%2Fmazda3_2010_silver.png?alt=media&token=b8a4f4de-7704-40fa-8fda-6efc1575ce1d';
      }
      case 'بني' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2010-2014%2Fmazda3_2010_black.png?alt=media&token=bf6b96e9-f0a4-4e58-acc3-9cffbdedd02c';
      }
      case 'فراني او كحلي' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2010-2014%2Fmazda3_2010_ferany.png?alt=media&token=b677ec7b-2514-4ffc-80c7-33ba8fac33b0';
      }
      case 'أزرق' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2010-2014%2Fmazda3_2010_darkBlue.png?alt=media&token=aaaaeac6-3786-4b62-9d41-ba726c8d7bd7';
      }
      case 'ذهبي' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2010-2014%2Fmazda3_2010_skyBlue.png?alt=media&token=c7ee754e-4c8b-47c3-bfed-5e5d959bb9eb';
      }
      case 'بتنجاني' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2010-2014%2Fmazda3_2010_skyBlue.png?alt=media&token=c7ee754e-4c8b-47c3-bfed-5e5d959bb9eb';
      }
    }
  }
  if(carYear >2014 && carYear < 2021){
    switch(carColor){
      case 'أحمر' :{
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2015-2020%2Fmazda3_2015_red.png?alt=media&token=aabe812c-9276-412d-8fbe-b1eda47a291c' ;
      }
      case 'أسود' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2015-2020%2Fmazda3_2015_black.png?alt=media&token=101ff4c7-5bf3-4107-8601-6c3d58449ede';
      }
      case 'أبيض' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2015-2020%2Fmazda3_2015_white.png?alt=media&token=4f6b06f1-bbc7-4b9e-981f-c3146895c93c';
      }
      case 'رمادي' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2015-2020%2Fmazda3_2015_grey.png?alt=media&token=5e641231-7926-4cad-9bce-a510494dfb51';
      }
      case 'فضي' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2015-2020%2Fmazda3_2015_silver.png?alt=media&token=fd44b8d3-4796-4127-b9ed-879503b30754';
      }
      case 'بني' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2015-2020%2Fmazda3_2015_brown.png?alt=media&token=942b7360-0d58-4788-a912-47b949b2643e';
      }
      case 'فراني او كحلي' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2015-2020%2Fmazda3_2015_ferany.png?alt=media&token=ca6f0a69-4f94-4247-8009-55bdb485750f';
      }
      case 'أزرق' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2015-2020%2Fmazda3_2015_blue.png?alt=media&token=cb94fa8e-979f-4a39-bc2f-dfd70075690a';
      }
      case 'ذهبي' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2015-2020%2Fmazda3_2015_brown.png?alt=media&token=942b7360-0d58-4788-a912-47b949b2643e';
      }
      case 'بتنجاني' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2015-2020%2Fmazda3_2015_ferany.png?alt=media&token=ca6f0a69-4f94-4247-8009-55bdb485750f';
      }
    }
  }
  if(carYear > 2020){
    switch(carColor){
      case 'أحمر' :{
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2021-2024%2Fmazda3_2020_red.png?alt=media&token=dbf503b1-7c2f-4f9b-b1e8-8eebbf4ead5b' ;
      }
      case 'أسود' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2021-2024%2Fmazda3_2020_black.png?alt=media&token=49098e39-b2ba-4cf9-b1ac-c4720e4d13be';
      }
      case 'أبيض' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2021-2024%2Fmazda3_2020_white.png?alt=media&token=a99cd3b5-c758-4786-888c-a3d2a914d232';
      }
      case 'رمادي' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2021-2024%2Fmazda3_2020_grey.png?alt=media&token=5fdf88fe-ed28-4e49-9a74-a6f961877381';
      }
      case 'فضي' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2021-2024%2Fmazda3_2020_silver.png?alt=media&token=0ed17481-b8a4-4ab6-b80b-ec09dc5ed0a3';
      }
      case 'بني' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2021-2024%2Fmazda3_2020_brown.png?alt=media&token=a2940426-1ce3-49d5-bb0d-58c98d031689';
      }
      case 'فراني او كحلي' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2021-2024%2Fmazda3_2020_ferany.png?alt=media&token=b4114b97-1a49-47ef-84d6-e67d6df8d49e';
      }
      case 'أزرق' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2021-2024%2Fmazda3_2020_blue.png?alt=media&token=8d80ed7e-20f9-4ae5-b75d-9961b28bf284';
      }
      case 'ذهبي' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2021-2024%2Fmazda3_2020_brown.png?alt=media&token=a2940426-1ce3-49d5-bb0d-58c98d031689';
      }
      case 'بتنجاني' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2021-2024%2Fmazda3_2020_ferany.png?alt=media&token=b4114b97-1a49-47ef-84d6-e67d6df8d49e';
      }
    }
  }
  return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2021-2024%2Fmazda3_2020_red.png?alt=media&token=dbf503b1-7c2f-4f9b-b1e8-8eebbf4ead5b';
}

String mazda6SwichCase({
  required String carColor,
  required int carYear,
}){
  if(carYear <2010){
    switch(carColor){
      case 'أحمر' :{
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2005-2009%2Fmazda6_2005_red.png?alt=media&token=0f3b33a0-e9d6-453c-9fc9-c774db6f41c0' ;
      }
      case 'أسود' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2005-2009%2Fmazda6_2005_black.png?alt=media&token=7b0b4462-c5e6-43a6-8f45-e31675ea5b2a';
      }
      case 'أبيض' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2005-2009%2Fmazda6_2005_white.png?alt=media&token=70630e0b-3664-4252-9e40-ae4a6dedf8cf';
      }
      case 'رمادي' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2005-2009%2Fmazda6_2005_grey.png?alt=media&token=b9f786fb-c427-425d-9e62-295f830d3fc4';
      }
      case 'فضي' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2005-2009%2Fmazda6_2005_silver.png?alt=media&token=0a7b62b8-0dcc-4c64-9811-e798bd7059ed';
      }
      case 'بني' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2005-2009%2Fmazda6_2005_gold.png?alt=media&token=79c13630-7415-42c1-8ae4-e52eee2e76a1';
      }
      case 'فراني او كحلي' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2005-2009%2Fmazda6_2005_ferany.png?alt=media&token=568ede18-6ab6-4525-8d15-fdba5a223039';
      }
      case 'أزرق' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2005-2009%2Fmazda6_2005_blue.png?alt=media&token=5f53cc32-981f-4434-b410-b71a0141d1ff';
      }
      case 'ذهبي' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2005-2009%2Fmazda6_2005_gold.png?alt=media&token=79c13630-7415-42c1-8ae4-e52eee2e76a1';
      }
      case 'بتنجاني' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2005-2009%2Fmazda6_2005_betngany.png?alt=media&token=9a242146-d563-49db-b935-82c15e1acbfb';
      }
    }
  }
  if(carYear >2009 && carYear < 2015){
    switch(carColor){
      case 'أحمر' :{
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2010-2014%2Fmazda6_2010_red.png?alt=media&token=95173018-e057-4370-ab06-a5783cc81206' ;
      }
      case 'أسود' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2010-2014%2Fmazda6_2010_black.png?alt=media&token=66e0dff9-3338-4e6a-aeff-85bb11514257';
      }
      case 'أبيض' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2010-2014%2Fmazda6_2010_white.png?alt=media&token=62e5dffd-10ad-4674-8713-f15d9b46d74f';
      }
      case 'رمادي' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2010-2014%2Fmazda6_2010_grey.png?alt=media&token=43e739da-1aa5-466d-93e8-f13b2f8d26c5';
      }
      case 'فضي' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2010-2014%2Fmazda6_2010_silver.png?alt=media&token=20c5535c-1fac-4488-8e04-9b8b89d68add';
      }
      case 'بني' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2010-2014%2Fmazda6_2010_gold.png?alt=media&token=16b23113-15b2-4e1d-87ee-44a765106ce1';
      }
      case 'فراني او كحلي' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2010-2014%2Fmazda6_2010_ferany.png?alt=media&token=52e6a12c-6638-4d59-824c-ef14344fc32b';
      }
      case 'أزرق' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2010-2014%2Fmazda6_2010_blue.png?alt=media&token=190f181e-ab21-4331-af58-66e1b12c50d6';
      }
      case 'ذهبي' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2010-2014%2Fmazda6_2010_gold.png?alt=media&token=16b23113-15b2-4e1d-87ee-44a765106ce1';
      }
      case 'بتنجاني' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2010-2014%2Fmazda6_2010_btengany.png?alt=media&token=24506897-7dfe-471c-9d37-abbc71701840';
      }
    }
  }
  if(carYear >2014 && carYear < 2021){
    switch(carColor){
      case 'أحمر' :{
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2015-2019%2Fmazda6_2015_red.png?alt=media&token=f674021c-ceef-4067-90ae-5a558b27b252' ;
      }
      case 'أسود' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2015-2019%2Fmazda6_2015_black.png?alt=media&token=effc2820-1658-41cb-8e4f-7fd694e40693';
      }
      case 'أبيض' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2015-2019%2Fmazda6_2015_white.png?alt=media&token=37b6aebc-fcdb-4e53-9841-ab3d1268679c';
      }
      case 'رمادي' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2015-2019%2Fmazda6_2015_grey.png?alt=media&token=cbc3fc51-d167-40a6-b62d-5c07c011503d';
      }
      case 'فضي' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2015-2019%2Fmazda6_2015_silver.png?alt=media&token=9020411c-91e9-4cab-8dae-37741853ab1b';
      }
      case 'بني' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2015-2019%2Fmazda6_2015_red.png?alt=media&token=f674021c-ceef-4067-90ae-5a558b27b252';
      }
      case 'فراني او كحلي' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2015-2019%2Fmazda6_2015_red.png?alt=media&token=f674021c-ceef-4067-90ae-5a558b27b252';
      }
      case 'أزرق' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2015-2019%2Fmazda6_2015_blue.png?alt=media&token=2e734ceb-e14b-4d41-8269-d065729687b5';
      }
      case 'ذهبي' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2015-2019%2Fmazda6_2015_blue.png?alt=media&token=2e734ceb-e14b-4d41-8269-d065729687b5';
      }
      case 'بتنجاني' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2015-2019%2Fmazda6_2015_blue.png?alt=media&token=2e734ceb-e14b-4d41-8269-d065729687b5';
      }
    }
  }
  if(carYear > 2020){
    switch(carColor){
      case 'أحمر' :{
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2020-2024%2Fmazda6_2020_red.png?alt=media&token=c4ae94d1-97ca-4c81-bc96-d340732cd3f4' ;
      }
      case 'أسود' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2020-2024%2Fmazda6_2020_blck.png?alt=media&token=3e132f59-fdac-4cb1-9527-b73ccab5c450';
      }
      case 'أبيض' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2020-2024%2Fmazda6_2020_white.png?alt=media&token=29e6b058-5af2-4aa4-b1b3-9775128de82a';
      }
      case 'رمادي' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2020-2024%2Fmazda6_2020_grey.png?alt=media&token=f7dbf655-4968-4b47-857d-0291a77bb3d7';
      }
      case 'فضي' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2020-2024%2Fmazda6_2020_silver.png?alt=media&token=4f1e4db2-4404-4ce1-8e9c-248d135fc4db';
      }
      case 'بني' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2020-2024%2Fmazda6_2020_brown.png?alt=media&token=104e88ce-4a27-4e64-acf1-238c632a96ae';
      }
      case 'فراني او كحلي' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2020-2024%2Fmazda6_2020_darkBlue.png?alt=media&token=bc911b74-cad5-4dc6-9cc4-44cf53dc9ca5';
      }
      case 'أزرق' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2020-2024%2Fmazda6_2020_skyBlue.png?alt=media&token=6dff7c74-6ff5-4e86-adb1-8d5e663f9767';
      }
      case 'ذهبي' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2020-2024%2Fmazda6_2020_brown.png?alt=media&token=104e88ce-4a27-4e64-acf1-238c632a96ae';
      }
      case 'بتنجاني' : {
        return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2020-2024%2Fmazda6_2020_darkBlue.png?alt=media&token=bc911b74-cad5-4dc6-9cc4-44cf53dc9ca5';
      }
    }
  }
  return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda6%2F2020-2024%2Fmazda6_2020_red.png?alt=media&token=c4ae94d1-97ca-4c81-bc96-d340732cd3f4';
}

String mazdacx3SwichCase({
  required String carColor,
}){
  switch(carColor){
    case 'أحمر' :{
      return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazdaCx3%2FmazdaCx3_red.png?alt=media&token=65e2e327-03bd-46ea-950c-ef3a5c15bd64' ;
    }
    case 'أسود' : {
      return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazdaCx3%2FmazdaCx3_black.png?alt=media&token=9dc73182-dec3-487f-bbbb-ea17cb66d25d';
    }
    case 'أبيض' : {
      return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazdaCx3%2FmazdaCx3_white.png?alt=media&token=358f8ec9-19d6-441f-9bc1-eaefb5203788';
    }
    case 'رمادي' : {
      return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazdaCx3%2FmazdaCx3_grey.png?alt=media&token=2b50b003-a4b7-4fcb-b8b9-6901d4e5aa9d';
    }
    case 'فضي' : {
      return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazdaCx3%2FmazdaCx3_silver.png?alt=media&token=064f23a6-a996-43cc-8155-a2459403dc99';
    }
    case 'بني' : {
      return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazdaCx3%2FmazdaCx3_black.png?alt=media&token=9dc73182-dec3-487f-bbbb-ea17cb66d25d';
    }
    case 'فراني او كحلي' : {
      return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazdaCx3%2FmazdaCx3_ferany.png?alt=media&token=ca340345-ae51-4a60-9f17-6443b62c0a8b';
    }
    case 'أزرق' : {
      return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazdaCx3%2FmazdaCx3_blue.png?alt=media&token=087e98ae-13bc-4f4c-92a2-4039c60a7e43';
    }
  }
  return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazdaCx3%2FmazdaCx3_red.png?alt=media&token=65e2e327-03bd-46ea-950c-ef3a5c15bd64';
}

String mazdacx5SwichCase({
  required String carColor,
}){
  switch(carColor){
    case 'أحمر' :{
      return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazdaCx5%2FmazdaCx5_red.png?alt=media&token=7bf50ef3-d0be-4ceb-b6c5-0e35c331919c' ;
    }
    case 'أسود' : {
      return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazdaCx5%2FmazdaCx5_black.png?alt=media&token=fb1f84df-1063-4754-bfb0-60c0bc6580c2';
    }
    case 'أبيض' : {
      return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazdaCx5%2FmazdaCx5_white.png?alt=media&token=ce00e056-f85f-4520-bfe2-07c1da2b5bc5';
    }
    case 'رمادي' : {
      return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazdaCx5%2FmazdaCx5_grey.png?alt=media&token=3261d4fa-c42e-4f04-bd8e-2c1cf3c989e8';
    }
    case 'فضي' : {
      return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazdaCx5%2FmazdaCx5_silver.png?alt=media&token=7a1a548a-bd6c-41a9-af3b-e07a33fb43de';
    }
    case 'بني' : {
      return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazdaCx5%2FmazdaCx5_black.png?alt=media&token=fb1f84df-1063-4754-bfb0-60c0bc6580c2';
    }
    case 'فراني او كحلي' : {
      return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazdaCx5%2FmazdaCx5_ferany.png?alt=media&token=8ca48960-d6c2-4396-95b6-1e07946dca20';
    }
    case 'أزرق' : {
      return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazdaCx5%2FmazdaCx5_blue.png?alt=media&token=223e33bb-5755-4b58-b396-78e29e7477f6';
    }
  }
  return 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazdaCx5%2FmazdaCx5_red.png?alt=media&token=7bf50ef3-d0be-4ceb-b6c5-0e35c331919c';
}