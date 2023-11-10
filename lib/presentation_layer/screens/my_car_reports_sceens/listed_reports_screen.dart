import 'package:bebo_auto_service/components/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../../components/constans.dart';
import '../../widgets/image_viewer.dart';
import 'package:intl/intl.dart' as dateTimeIntl;

class ListedReportsScreen extends StatelessWidget {
  const ListedReportsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppbar(
        context: context,
        title: 'تقارير الفحص السابقه',
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('verifiedUsers')
              .doc(myUid)
              .collection('invoices')
              .orderBy('addedTime', descending: true)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Icon(
                  Icons.warning_amber,
                  color: Colors.red,
                  size: 100,
                ),
              );
            }
            if (!snapshot.hasData) {
              return Center(child: myCircularProgressIndicator());
            }
            if ((snapshot.data?.docs.isEmpty)!) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.fileInvoice,
                      size: 115.sp,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'لا يوجد تقارير حتي الأن ....',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'أذهب الي المركز الان لفحص كل قطعه في السياره واحصل علي تقرير مفصل عن حاله جزء',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: defaultColor, fontSize: 15.sp),
                      ),
                    ),
                  ],
                ),
              );
            }
            return AnimationLimiter(
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: buildReportItems(
                          context: context,
                          index: index,
                          invoiceMap: snapshot.data!.docs[index].data(),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
    );
  }

  Widget buildReportItems({
    required BuildContext context,
    required int index,
    required Map<String, dynamic> invoiceMap,
  }) =>
      InkWell(
        onTap: () {
          navigateTo(
              context: context,
              widget: ImageViewer(
                isNetworkImage: true,
                photoUrlToSaveImage: '${invoiceMap['image']}',
                photo: NetworkImage(
                  '${invoiceMap['image']}',
                ),
              ));
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: double.infinity,
            height: 100.h,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: const Color.fromRGBO(2, 0, 0, 0.3),
                borderRadius: BorderRadius.circular(20).r),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SleekCircularSlider(
                      appearance: CircularSliderAppearance(
                        angleRange: 240,
                        size: 50.sp,
                        infoProperties: InfoProperties(
                          mainLabelStyle:
                              TextStyle(color: Colors.white, fontSize: 15.sp),
                        ),
                        customColors: CustomSliderColors(
                            dotColor: Colors.black,
                            trackColors: [
                              Colors.grey[800]!,
                              Colors.grey[600]!,
                              Colors.grey[200]!,
                            ],
                            progressBarColors: [
                              const Color.fromRGBO(0, 255, 0, 1),
                              const Color.fromRGBO(255, 255, 0, 1),
                            ]),
                      ),
                      initialValue: 80,
                    ),
                    Text(
                      'التقييم النهائي للفحص',
                      maxLines: 1,
                      style: GoogleFonts.dosis(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        dateTimeIntl.DateFormat.yMMMd('ar')
                            .format(invoiceMap['addedTime'].toDate()),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.sp,
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        dateTimeIntl.DateFormat.jm('ar')
                            .format(invoiceMap['addedTime'].toDate()),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      );
}
