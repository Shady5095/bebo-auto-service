import 'package:bebo_auto_service/components/components.dart';
import 'package:bebo_auto_service/data_layer/models/offers_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../components/constans.dart';
import '../../features/offers/offer_details_screen.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppbar(
        context: context,
        title: 'العروض',
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('offers')
              .orderBy('addedTime', descending: true)
              .snapshots(),
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
                      FontAwesomeIcons.fireFlameCurved,
                      size: 110.sp,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                    SizedBox(
                      height: 13.h,
                    ),
                    Text(
                      'لا يوجد اي عروض',
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
                  OffersModel offersModel =
                      OffersModel.fromJson(snapshot.data!.docs[index].data());
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: buildOfferItem(offersModel, context),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
    );
  }

  Widget buildOfferItem(
    OffersModel offersModel,
    BuildContext context,
  ) =>
      InkWell(
        onTap: () {
          navigateTo(
            widget: OfferDetailsScreen(
              offersModel: offersModel,
            ),
            context: context,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: const Color.fromRGBO(2, 0, 0, 0.3),
                borderRadius: BorderRadius.circular(20).r),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${offersModel.name}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white, fontSize: 15.sp),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    FutureBuilder<Widget>(
                        future: offerStatusTextWidget(offersModel),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Center(
                              child: Icon(
                                Icons.warning_amber,
                                color: Colors.red,
                                size: 10,
                              ),
                            );
                          }
                          if (!snapshot.hasData) {
                            return Center(
                                child: LoadingAnimationWidget.prograssiveDots(
                              color: defaultColor,
                              size: 20,
                            ));
                          }
                          if (snapshot.data == null) {
                            return Center(
                                child: LoadingAnimationWidget.waveDots(
                              color: defaultColor,
                              size: 30,
                            ));
                          }
                          return snapshot.data!;
                        }),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                if (offersModel.image != null)
                  LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    return Hero(
                      tag: '${offersModel.id}',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image(
                          errorBuilder: (BuildContext? context,
                              Object? exception, StackTrace? stackTrace) {
                            return const Center(
                              child: Icon(
                                Icons.warning_amber,
                                color: Colors.red,
                                size: 100,
                              ),
                            );
                          },
                          loadingBuilder: (BuildContext? context,
                              Widget? child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child!;
                            return Center(
                              child: SizedBox(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(
                                  color: defaultColor,
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress
                                              .cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                            );
                          },
                          image: CachedNetworkImageProvider(
                            '${offersModel.image}',
                          ),
                        ),
                      ),
                    );
                  }),
              ],
            ),
          ),
        ),
      );

  Future<Widget> offerStatusTextWidget(OffersModel offersModel) async {
    DateTime currentDate = await getServerTimeNow();
    if (offersModel.expireDate == null ||
        currentDate.isBefore(offersModel.expireDate!.toDate())) {
      return Text(
        'متاح',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.green,
          fontStyle: FontStyle.italic,
          fontSize: 14.sp,
        ),
      );
    } else {
      return Text(
        'أنتهي صلاحيته',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.red,
          fontStyle: FontStyle.italic,
          fontSize: 14.sp,
        ),
      );
    }
  }
}
