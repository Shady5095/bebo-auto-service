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

   static Future<Response?>? postNotification({
     required Map<String,dynamic> data,
}) async {
     dio?.options.headers={
       'Content-Type':'application/json',
       'Authorization' : 'key=AAAAThanUmM:APA91bFwyqmn6N3XN80LJMnqZJomPS4HasDFGBb9EsV-KCIH1y9o_dWzI8zpqT_OmOVNrGNfnhFeRsAZbIeJSWohSDZ4GutDNXZd8nlvLhCGOlFfVAZnb2g837O4ja0QLbwGXAGzP04R',
     };
     return await dio?.post(
         '/fcm/send',
         data: data,
     ).then((value) {
       print(value.data) ;
       return null;
     }).catchError((error){
       print(error);
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