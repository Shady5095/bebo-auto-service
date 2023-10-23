import 'dart:convert';
import 'dart:ui';

import 'package:bebo_auto_service/business_logic_layer/app_cubit/app_cubit.dart';
import 'package:bebo_auto_service/components/components.dart';
import 'package:bebo_auto_service/components/constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../components/app_locale.dart';

class PriceListScreen extends StatelessWidget {
   const PriceListScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      appBar: AppBar(
        backgroundColor: defaultBackgroundColor,
        elevation: 0,
        title: Text(
          '${getLang(context, 'Price list')}',
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0 , vertical: 5),
            child: Center(
              child: Text(
                '${getLang(context, 'All Categories')}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 9,right: 9,left: 9),
              child: AnimationLimiter(
                child: GridView.count(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 0.85,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                  children: List.generate(
                    CarCubit.get(context).categoriesGrid.length,
                        (int index) {
                      return AnimationConfiguration.staggeredGrid(
                        position: index,
                        duration: const Duration(milliseconds: 500),
                        columnCount: 2,
                        child: ScaleAnimation(
                          child: FadeInAnimation(
                            child: categoriesPage(context,index)
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget categoriesPage(context,index) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15.0 , sigmaY: 15.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(2, 0, 0, 0.2),
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
                      CarCubit.get(context).categoriesGrid[index]['assetImage'],
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    CarCubit.get(context).categoriesGrid[index]['nameAr'],
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
  );


}