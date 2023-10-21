import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyShimmer extends StatelessWidget {
  final double? height ;
  final double? width ;
  final double? radius ;
  final bool? isBorderRadius ;

  const MyShimmer({
    Key? key,
    this.height,
    this.width,
    this.radius,
    this.isBorderRadius
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).highlightColor,
      highlightColor: Theme.of(context).hoverColor,
      child: (width != null && height !=null ) ? Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: isBorderRadius == null ? BorderRadius.circular(15) : BorderRadius.zero,
          color: Theme.of(context).highlightColor,
        ),
      ) : CircleAvatar(
        radius: radius,
      ),
    );
  }
}
