import 'dart:ui';
import 'package:bebo_auto_service/components/components.dart';
import 'package:bebo_auto_service/components/constans.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../../business_logic_layer/main_app_cubit/main_app_cubit.dart';
import '../../../../../data_layer/models/spare_parts_model.dart';
import '../spare_parts_details_screen/spare_parts_details_screen.dart';
import '../specific_category_screen/specific_category_screen.dart';

class SparePartsCategoriesScreen extends StatefulWidget {
  const SparePartsCategoriesScreen({Key? key}) : super(key: key);

  @override
  State<SparePartsCategoriesScreen> createState() =>
      _SparePartsCategoriesScreenState();
}

class _SparePartsCategoriesScreenState
    extends State<SparePartsCategoriesScreen> {
  bool isSearching = false;

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      appBar: AppBar(
          backgroundColor: defaultBackgroundColor,
          leading: isSearching
              ? IconButton(
            onPressed: () {
              isSearching = false;
              searchController.text = '';
              setState(() {});
            },
            icon: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Icon(
                Icons.arrow_back_ios,
                size: 21.sp,
                color: Theme.of(context).secondaryHeaderColor,
              ),
            ),
          )
              : null,
          elevation: 0,
          toolbarHeight: 45.h,
          title: titleWidget(),
          actions: [
            IconButton(
              icon: Icon(
                isSearching ? Icons.close : Icons.search,
                color: Colors.white,
                size: 22.sp,
              ),
              onPressed: () {
                isSearching = !isSearching;
                searchController.text = '';
                setState(() {});
              },
            ),
          ]),
      body: bodyWidget(),
    );
  }

  Widget categoriesBuild(context, index) => InkWell(
        onTap: () {
          navigateToAnimated(
            context: context,
            widget: SpecificCategoryScreen(
              category: MainAppCubit.get(context).categoriesGrid[index]['name'],
              categoryAr: MainAppCubit.get(context).categoriesGrid[index]['nameAr'],
              categoryImage: MainAppCubit.get(context).categoriesGrid[index]
                  ['assetImage'],
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(2, 0, 0, 0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: FittedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Image.asset(
                            MainAppCubit.get(context).categoriesGrid[index]
                                ['assetImage'],
                            height: 40,
                            width: 40,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          MainAppCubit.get(context).categoriesGrid[index]['nameAr'],
                          style: const TextStyle(
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget titleWidget() {
    if (isSearching) {
      return TextFormField(
        controller: searchController,
        autofocus: true,
        maxLines: 1,
        keyboardType: TextInputType.text,
        onChanged: (String text) {
          setState(() {});
        },
        style: TextStyle(
          color: Theme.of(context).secondaryHeaderColor,
          fontSize: 15.sp,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 15.sp,
            height: 1,
          ),
          hintText: 'البحث عن قطعة غيار...',
        ),
      );
    } else {
      return  Text(
        'قطع الغيار',
        style: TextStyle(
          fontSize: 22.sp
        ),
      );
    }
  }

  Widget bodyWidget() {
    if (searchController.text != '') {
      return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('spareParts')
              .where('name',
                  isGreaterThanOrEqualTo: searchController.text.trim())
              .where('name', isLessThan: '${searchController.text.trim()}ي')
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
                      Icons.search_off,
                      size: 110.sp,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                    SizedBox(
                      height: 13.h,
                    ),
                    Text(
                      'لا يوجد نتائج لبحثك...',
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
                  SparePartsModel sparePartsModel = SparePartsModel.fromJson(
                      snapshot.data!.docs[index].data());
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: buildNewSparePartItem(
                            sparePartsModel, context, snapshot.data!.docs[index].data()),
                      ),
                    ),
                  );
                },
              ),
            );
          });
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: Center(
              child: Text(
                'جميع الفئات',
                style: TextStyle(color: Colors.white, fontSize: 22.sp),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 9, right: 9, left: 9),
              child: AnimationLimiter(
                child: GridView.count(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: MediaQuery.of(context).size.shortestSide > 600 ? 3 : 2,
                  childAspectRatio: 1 / 0.85,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                  children: List.generate(
                    MainAppCubit.get(context).categoriesGrid.length,
                    (int index) {
                      return AnimationConfiguration.staggeredGrid(
                        position: index,
                        duration: const Duration(milliseconds: 500),
                        columnCount: 2,
                        child: ScaleAnimation(
                          child: FadeInAnimation(
                              child: categoriesBuild(context, index)),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
  }

  Widget buildNewSparePartItem(
    SparePartsModel sparePartsModel,
    BuildContext context,
    Map<String, dynamic> snapshot,
  ) =>
      InkWell(
        onTap: () {
          navigateTo(
            widget: SparePartsDetailsScreen(
              categoryImage: 'assets/images/${sparePartsModel.category}.png',
              sparePartsModel: sparePartsModel,
              snapshot: snapshot,
            ),
            context: context,
          );
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
                          'assets/images/${sparePartsModel.category}.png',
                          width: displayWidth(context) * 0.22,
                          height: displayHeight(context) * 0.10,
                        )
                      : Hero(
                          tag: '${sparePartsModel.id}',
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
