import 'package:dio/dio.dart';

class DioHelper {
   static Dio? dio;

   static init() {
     dio = Dio(
       BaseOptions(
         baseUrl: 'https://fcm.googleapis.com',
         receiveDataWhenStatusError: true,
       )
     );
   }

   static Future<Response?> getData({
   required String url ,
     Map<String,dynamic>? query,
   String lang = 'en',
     String? token,
   }) async {
     dio?.options.headers={
       'lang' : lang,
       'Content-Type':'application/json',
       'Authorization' : token,
     };
     return await dio?.get(
         url,
         queryParameters: query
     );
   }

   static Future<Response?>? pushNotification({
     required Map<String,dynamic> data,
}) async {
     dio?.options.headers={
       'Content-Type':'application/json',
       'Authorization' : 'key=AAAApMpcAfg:APA91bF6v62kuVAaPTiOZ7be9f2GfNVYbrTZrnuS9vqnAFdFXvPbSGg87fYaGs7_qlBUkRMbPq5lyiLLl3MVZ47nLXl2TgbeVowtVS_cXdfdbZJKyYwym1LOVCoeJt6nLNavfCnA_FFp',
     };
     return await dio?.post(
         '/fcm/send',
         data: data,
     ).then((value) {
       return null;
     }).catchError((error){
     });
   }

   static Future<Response?>? putData({
     required String url ,
     Map<String,dynamic>? query,
     required Map<String,dynamic> data,
     String lang = 'en',
     String? token,
   }) async {
     dio?.options.headers={
       'lang' : lang,
       'Content-Type':'application/json',
       'Authorization' : token,
     };
     return await dio?.put(
       url,
       queryParameters: query,
       data: data,
     );
   }
}