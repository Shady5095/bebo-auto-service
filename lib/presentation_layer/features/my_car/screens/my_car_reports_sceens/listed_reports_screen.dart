import 'package:bebo_auto_service/components/components.dart';
import 'package:bebo_auto_service/presentation_layer/features/my_car/screens/my_car_reports_sceens/report_details_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:intl/intl.dart' as date_time_intl;
import '../../../../../components/constans.dart';

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
              .collection('reports')
              .where('isVerified',isEqualTo: true)
              .orderBy('dateTime', descending: true)
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
                        child: BuildReportItem(context: context, index: index, reportMap: snapshot.data!.docs[index].data()),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
    );
  }

}

class BuildReportItem extends StatelessWidget {
  const BuildReportItem({
    super.key,
    required this.context,
    required this.index,
    required this.reportMap,
  });

  final BuildContext context;
  final int index;
  final Map<String, dynamic> reportMap;

  @override
  Widget build(BuildContext context) {
    late double newValue = (reportMap['overallRating']).toDouble();
    late int green = ((newValue * 2.55)).toInt();
    late int red = ((255 - (newValue * 2.55 * 0.5))).toInt();
    return InkWell(
        onTap: () {
          navigateTo(
              context: context,
              widget: ReportDetailsScreen(customerDocId: myUid!, reportDocId: reportMap['docId'],));
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: double.infinity,
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
                              Color.fromRGBO(red, green,0, 1),
                              Color.fromRGBO(red, green, 0, 1),
                              Color.fromRGBO(
                                  (red - reportMap['overallRating']).toInt(), (green - reportMap['overallRating']).toInt(), 0, 1),
                            ]),
                      ),
                      initialValue: reportMap['overallRating'].toDouble(),
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
                        date_time_intl.DateFormat.yMMMd('ar')
                            .format(reportMap['dateTime'].toDate()),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.sp,
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        date_time_intl.DateFormat.jm('ar')
                            .format(reportMap['dateTime'].toDate()),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
