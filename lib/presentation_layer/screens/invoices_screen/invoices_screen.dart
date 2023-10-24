import 'package:bebo_auto_service/components/components.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../components/constans.dart';
import '../../widgets/image_viewer.dart';

class InvoicesScreen extends StatelessWidget {
  const InvoicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppbar(
          context: context,
        title: 'جميع الفواتير',
      ),
      body: AnimationLimiter(
        child: ListView.builder(
          itemCount: 10,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: buildMenuItems( context , index),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  Widget buildMenuItems( BuildContext context , int index) => InkWell(
    onTap: (){
      navigateTo(
        context: context,
        widget: ImageViewer(
          photoUrlToSaveImage: 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/photo_2023-10-23_22-35-18.jpg?alt=media&token=b36578a2-5f03-40e0-b7e8-c48f4bb40974',
          photo: NetworkImage(
            'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/photo_2023-10-23_22-35-18.jpg?alt=media&token=b36578a2-5f03-40e0-b7e8-c48f4bb40974',
          ),
        )
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity,
        height: 80.h,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Color.fromRGBO(2, 0, 0, 0.3),
            borderRadius: BorderRadius.circular(20).r
        ),
        child: Row(
          children: [
            Container(
              width: 8.w,
              height: 70.h,
              decoration: BoxDecoration(
                color: defaultColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.zero ,
                  bottomLeft: Radius.zero ,
                  bottomRight:  const Radius.circular(20).r ,
                  topRight: const Radius.circular(20).r ,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      '2,400',
                      style: GoogleFonts.dosis(
                          color: Colors.white,
                          height: 1.h,
                          fontSize: 25.sp,
                      ),
                    ),
                  ),
                  Text(
                    'جنيه',
                    style: GoogleFonts.dosis(
                        color: Colors.white,
                        fontSize: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    '26/8/2023',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                    ),
                  ),
                  Text(
                    '8:36 PM',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                    ),
                  ),
                ],
              ),
            ),
             Expanded(
              child: Text(
                'عرض صوره الفاتوره',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.sp,
                ),
              ),
              /*CachedNetworkImage(
                height: double.maxFinite,
                imageUrl: 'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/photo_2023-10-23_22-35-18.jpg?alt=media&token=b36578a2-5f03-40e0-b7e8-c48f4bb40974',
                placeholder: (context, url) => Container(
                  color: Colors.grey[700],
                  height: double.maxFinite,
                  width: double.minPositive,
                ),
                errorWidget: (context, url,_) => const Icon(
                  Icons.warning_amber,
                  color: Colors.red,
                  size: 30,
                ),
              ),*/
            ),
          ],
        ),
      ),
    ),
  );
}
