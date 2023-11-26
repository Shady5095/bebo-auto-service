import 'package:bebo_auto_service/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/my_car_reports_expandable_widget.dart';

class ReportDetailsScreen extends StatefulWidget {
  final String customerDocId;

  final String reportDocId;
  const ReportDetailsScreen({
    Key? key,
    required this.customerDocId,
    required this.reportDocId,
  }) : super(key: key);

  @override
  State<ReportDetailsScreen> createState() => _ReportDetailsScreenState();
}

class _ReportDetailsScreenState extends State<ReportDetailsScreen> {
  List<String> categoriesAr = [
    'الماتور والفتيس',
    'نظام الفرامل',
    'التكييف',
    'العفشة و البطاحات',
    'الكهرباء',
    'جهاز الأعطال',
    'الصالون الداخلي',
    'الهيكل الخارجي',
    'اعمال الشاسيه وملاحظات اخري',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppbar(
        context: context,
        title: 'تفاصيل التقرير',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 15),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return CustomerReportsExpandableWidget(
              index: index,
              customerDocId: widget.customerDocId,
              reportDocId: widget.reportDocId,
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 15.h,
            );
          },
          itemCount: categoriesAr.length,
        ),
      ),
    );
  }
}
