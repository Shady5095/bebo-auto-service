import 'package:bebo_auto_service/business_logic_layer/main_app_cubit/main_app_cubit.dart';
import 'package:bebo_auto_service/business_logic_layer/main_app_cubit/main_app_states.dart';
import 'package:bebo_auto_service/components/components.dart';
import 'package:bebo_auto_service/components/constans.dart';
import 'package:bebo_auto_service/presentation_layer/layout/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  double rating = 0;
  List<String> selectableGoodRatingsText = [
    'سرعة الخدمة',
    'مهندس الأستقبال جيد',
    'فني الصيانة جيد',
    'سرعه تشخيص المشكلة',
    'سعر قطع الغيار جيد',
    'نظافة صالة الأستقبال'
  ];

  List<String> selectableBadRatingsText = [
    'بطئ في الخدمة',
    'مشكلة مع مهندس الأستقبال',
    'مشكلة مع فني الصيانة',
    'تشخيص خاطئ للمشكلة',
    'سعر قطع الغيار مرتفع',
    'صالة الأستقبال غير نظيفة'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppbar(
          context: context,
          onPopMethod: () {
            navigateAndFinish(
              context: context,
              widget: const AppLayout(),
            );
          }),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
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
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) =>
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  MainAppCubit
                      .get(context)
                      .selectedRatingsIndex = [];
                  this.rating = rating;
                  setState(() {});
                },
              ),
              SelectableItems(rating: rating, selectableGoodRatingsText: selectableGoodRatingsText, selectableBadRatingsText: selectableBadRatingsText),
            ],
          ),
        ),
      ),
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
    if(rating ==0 ){
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
            children:
            List.generate(selectableGoodRatingsText.length, (index) {
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
    return BlocConsumer<MainAppCubit, MainAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return InkWell(
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            MainAppCubit.get(context).selectRating(index);
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: MainAppCubit.get(context).isRatingSelected(index)
                    ? defaultColor
                    : Colors.transparent,
                border: MainAppCubit.get(context).isRatingSelected(index)
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
