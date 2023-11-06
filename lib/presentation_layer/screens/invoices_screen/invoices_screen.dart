import 'package:bebo_auto_service/components/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/constans.dart';
import '../../widgets/image_viewer.dart';
import 'package:intl/intl.dart' as dateTimeIntl;

class InvoicesScreen extends StatelessWidget {
  const InvoicesScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppbar(
        context: context,
        title: 'جميع الفواتير',
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('verifiedUsers')
              .doc(myUid)
              .collection('invoices')
              .orderBy('addedTime',descending: true)
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
                      size: 130,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'لا يوجد فواتير',
                      style: Theme.of(context).textTheme.bodyLarge,
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
                        child: buildInvoiceItems(
                          context :context,
                          index:index,
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

  Widget buildInvoiceItems({
    required BuildContext context,
    required int index,
    required Map<String, dynamic> invoiceMap,
  }) =>
      InkWell(
        onTap: () {
          navigateTo(
              context: context,
              widget:  ImageViewer(
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
            height: 80.h,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: const Color.fromRGBO(2, 0, 0, 0.3),
                borderRadius: BorderRadius.circular(20).r),
            child: Row(
              children: [
                Container(
                  width: 8.w,
                  height: 70.h,
                  decoration: BoxDecoration(
                    color: defaultColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.zero,
                      bottomLeft: Radius.zero,
                      bottomRight: const Radius.circular(20).r,
                      topRight: const Radius.circular(20).r,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          '${invoiceMap['totalPrice']}'.addCommaToString(),
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
                        dateTimeIntl.DateFormat.yMMMd('ar').format(invoiceMap['addedTime'].toDate()),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                        ),
                      ),
                      Text(
                        dateTimeIntl.DateFormat.jm('ar').format(invoiceMap['addedTime'].toDate()),
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
                ),
              ],
            ),
          ),
        ),
      );
}
