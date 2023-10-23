import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../../components/components.dart';

class ImageViewer extends StatelessWidget {

final ImageProvider? photo ;
final List<dynamic>? photosList ;
final int? photosListIndex ;

  ImageViewer({
    this.photo,
    this.photosList,
    this.photosListIndex
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppbar(
          context: context,
        title: '',
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: photosList == null ?  PhotoView(
            backgroundDecoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
              imageProvider: photo
          ) : CarouselSlider(
            items: photosList!.map((e) =>
                ClipRRect(
                  child: Image.network(
                    e,
                  ),
                ),
            ).toList(),
            options: CarouselOptions(
              height: double.infinity,
              initialPage: photosListIndex!,
              enableInfiniteScroll: false,
              enlargeCenterPage: false,
              reverse: false,
              viewportFraction: 1.0,
              autoPlay: false,
              scrollDirection: Axis.horizontal,
              scrollPhysics: const BouncingScrollPhysics(),
            ),
          ),
      ),
    );
  }
}
