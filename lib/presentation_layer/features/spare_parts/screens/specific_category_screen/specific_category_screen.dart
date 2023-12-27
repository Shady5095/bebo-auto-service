import 'package:bebo_auto_service/components/components.dart';
import 'package:bebo_auto_service/data_layer/models/spare_parts_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../../components/constans.dart';
import '../spare_parts_details_screen/spare_parts_details_screen.dart';

class SpecificCategoryScreen extends StatelessWidget {
  final String category;

  final String categoryAr;

  final String categoryImage;

  const SpecificCategoryScreen(
      {Key? key,
      required this.category,
      required this.categoryAr,
      required this.categoryImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppbar(
        context: context,
        title: categoryAr,
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('spareParts')
              .where('category', isEqualTo: category)
              .orderBy('name')
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
                      Icons.construction,
                      size: 110.sp,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                    SizedBox(
                      height: 13.h,
                    ),
                    Text(
                      'لا يوجد قطع غيار في هذا القسم',
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
                  SparePartsModel sparePartsModel =
                  SparePartsModel.fromJson(
                      snapshot.data!.docs[index].data());
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child:
                        buildNewSparePartItem(sparePartsModel, snapshot.data!.docs[index].data(),context,),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
    );
  }

  Widget buildNewSparePartItem(
    SparePartsModel sparePartsModel,
    Map<String,dynamic> snapshot,
    BuildContext context,
  ) =>
      InkWell(
        onTap: () {
          navigateTo(
              widget: SparePartsDetailsScreen(
                categoryImage: categoryImage,
                snapshot: snapshot,
                sparePartsModel: sparePartsModel,
              ),
              context: context);
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: sparePartsModel.image == null
                      ? Image.asset(
                          categoryImage,
                          width: displayWidth(context) * 0.22,
                          height: displayHeight(context) * 0.10,
                        )
                      : Hero(
                          tag: '${sparePartsModel.id}',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image(
                              errorBuilder: (BuildContext? context,
                                  Object? exception, StackTrace? stackTrace) {
                                return const Center(
                                  child: Icon(
                                    Icons.warning_amber,
                                    color: Colors.red,
                                    size: 30,
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
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  ),
                                );
                              },
                              image: CachedNetworkImageProvider(
                                '${sparePartsModel.image}',
                              ),
                            ),
                          ),
                        ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Text(
                    '${sparePartsModel.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white, fontSize: 15.sp),
                  ),
                ),
                SizedBox(
                  width: 10.w,
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
