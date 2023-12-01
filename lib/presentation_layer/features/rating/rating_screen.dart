import 'package:bebo_auto_service/business_logic_layer/main_app_cubit/main_app_cubit.dart';
import 'package:bebo_auto_service/business_logic_layer/rating_cubit/rating_cubit.dart';
import 'package:bebo_auto_service/components/components.dart';
import 'package:bebo_auto_service/components/constans.dart';
import 'package:bebo_auto_service/presentation_layer/features/home/layout/app_layout.dart';
import 'package:bebo_auto_service/presentation_layer/widgets/my_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RatingScreen extends StatefulWidget {
  final String serviceDocId;

  const RatingScreen({
    super.key,
    required this.serviceDocId,
  });

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  double rating = 0;
  List<String> selectableGoodRatingsText = [
    'سرعة الخدمة',
    'مهندس الأستقبال جيد',
    'فني الصيانة جيد',
    'سرعة معرفة المشكلة',
    'سعر قطع الغيار جيد',
    'نظافة صالة الأستقبال'
  ];

  List<String> selectableBadRatingsText = [
    'بطئ في الخدمة',
    'مشكلة مع مهندس الأستقبال',
    'مشكلة مع فني الصيانة',
    'عدم معرفة المشكلة',
    'سعر قطع الغيار مرتفع',
    'صالة الأستقبال غير نظيفة'
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RatingCubit, RatingState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 30.h,
            actions: [
              IconButton(
                  onPressed: () {
                    navigateAndFinish(
                      context: context,
                      widget: const AppLayout(),
                    );
                  },
                  icon:  Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 17.sp,
                  ))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const Image(
                    width: double.infinity,
                    image: AssetImage(
                      'assets/images/carRating.png',
                    ),
                  ),
                  Text(
                    'ماهو تقييمك لاخر صيانه لك في مركز بيبو اوتو',
                    style: TextStyle(color: Colors.white, fontSize: 18.sp),
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  faceReaction(rating) ?? const SizedBox(),
                  SizedBox(
                    height: 7.h,
                  ),
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    unratedColor: Colors.black.withOpacity(0.7),
                    itemSize: 35.sp,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) =>  const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      RatingCubit.get(context).selectedRatingsIndex = [];
                      RatingCubit.get(context).selectedRatingsText = [];
                      this.rating = rating;
                      setState(() {});
                    },
                  ),
                  SelectableItems(
                    rating: rating,
                    selectableGoodRatingsText: selectableGoodRatingsText,
                    selectableBadRatingsText: selectableBadRatingsText,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  if(state is SendRatingLoadingState)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: LinearProgressIndicator(color: defaultColor,),
                  ),
                  defaultButton(
                    onTap: () {
                      if (rating != 0) {
                        RatingCubit.get(context)
                            .rateService(
                          serviceDocId: widget.serviceDocId,
                          rating: rating,
                          userName:
                              MainAppCubit.get(context).userData!.firstName!,
                          ratingNotes: RatingCubit.get(context)
                                      .notesController
                                      .text ==
                                  ''
                              ? null
                              : RatingCubit.get(context).notesController.text,
                        )
                            .then((value) {
                          navigateAndFinish(
                            context: context,
                            widget: const AppLayout(),
                          );
                          showDialog(
                              context: context,
                              builder: (context) => MyAlertDialog(
                                    isFailed: false,
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'تم ارسال تقييمك',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                        Text(
                                          'شكرا لحسن تعاونكم معنا...نسعي دائما في تقديم افضل خدمه لكم',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white54,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: const [],
                                  ));
                        });
                      }
                    },
                    text: 'أرسل',
                    width: displayWidth(context) * 0.80,
                    decoration: BoxDecoration(
                      color: rating == 0
                          ? Colors.black.withOpacity(0.3)
                          : defaultColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget? faceReaction(double rate) {
    switch (rate) {
      case 1:
        return Icon(
          Icons.sentiment_very_dissatisfied,
          color: Colors.red,
          size: 45.sp,
        );
      case 2:
        return Icon(
          Icons.sentiment_dissatisfied,
          color: Colors.redAccent,
          size: 45.sp,
        );
      case 3:
        return Icon(
          Icons.sentiment_neutral,
          color: Colors.amber,
          size: 45.sp,
        );
      case 4:
        return Icon(
          Icons.sentiment_satisfied,
          color: Colors.lightGreen,
          size: 45.sp,
        );
      case 5:
        return Icon(
          Icons.sentiment_very_satisfied,
          color: Colors.green,
          size: 45.sp,
        );
    }
    return null;
  }
}

class SelectableItems extends StatelessWidget {
  const SelectableItems({
    super.key,
    required this.rating,
    required this.selectableGoodRatingsText,
    required this.selectableBadRatingsText,
  });

  final double rating;
  final List<String> selectableGoodRatingsText;
  final List<String> selectableBadRatingsText;

  @override
  Widget build(BuildContext context) {
    if (rating == 0) {
      return const SizedBox();
    }
    return Column(
      children: [
        SizedBox(
          height: 7.h,
        ),
        Text(
          rating > 3
              ? 'قولنا ايه اكتر حاجات عجبتك في المركز'
              : 'قولنا ايه المشاكل الي قابلتك',
          style: TextStyle(color: Colors.white54, fontSize: 14.sp),
        ),
        SizedBox(
          height: 7.h,
        ),
        Wrap(
            direction: Axis.horizontal,
            runSpacing: 20,
            spacing: 10,
            alignment: WrapAlignment.center,
            children: List.generate(selectableGoodRatingsText.length, (index) {
              if (rating > 3) {
                return SelectableRatingsItem(
                  selectableRatingsText: selectableGoodRatingsText[index],
                  index: index,
                );
              } else {
                return SelectableRatingsItem(
                  selectableRatingsText: selectableBadRatingsText[index],
                  index: index,
                );
              }
            })),
        SizedBox(
          height: 10.h,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: TextFormField(
            controller: RatingCubit.get(context).notesController,
            keyboardType: TextInputType.text,
            onFieldSubmitted: (String newPrice) {},
            maxLines: 3,
            style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor, fontSize: 15.sp),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
              labelStyle: TextStyle(
                  color: Theme.of(context).hintColor, fontSize: 16.sp),
              prefixIconColor: Theme.of(context).secondaryHeaderColor,
              suffixIconColor: Theme.of(context).secondaryHeaderColor,
              labelText: 'الملاحظات',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SelectableRatingsItem extends StatelessWidget {
  final String selectableRatingsText;

  final int index;

  const SelectableRatingsItem({
    super.key,
    required this.selectableRatingsText,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RatingCubit, RatingState>(
      listener: (context, state) {},
      builder: (context, state) {
        return InkWell(
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            RatingCubit.get(context).selectRating(
              index: index,
              text: selectableRatingsText,
            );
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: RatingCubit.get(context).isRatingSelected(index)
                    ? defaultColor
                    : Colors.transparent,
                border: RatingCubit.get(context).isRatingSelected(index)
                    ? null
                    : Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(25)),
            child: Text(
              selectableRatingsText,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 12.sp),
            ),
          ),
        );
      },
    );
  }
}
