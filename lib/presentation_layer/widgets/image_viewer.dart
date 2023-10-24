import 'dart:typed_data';

import 'package:bebo_auto_service/components/constans.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';

import '../../components/components.dart';

class ImageViewer extends StatelessWidget {

final ImageProvider? photo ;
final List<dynamic>? photosList ;
final int? photosListIndex ;
final String? photoUrlToSaveImage ;

  ImageViewer({
    this.photo,
    this.photosList,
    this.photosListIndex,
    this.photoUrlToSaveImage
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppbar(
          context: context,
        title: '',
        actions: [
          if(photoUrlToSaveImage != null)
          TextButton(
              onPressed: ()  {
                 saveImageToDevice(photoUrlToSaveImage!).then((value) {
                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                     content: Text('تم حفظ الصوره'),
                   ));
                 });
              },
              child: const Text(
                'حفظ',
                style: TextStyle(
                    color: defaultColor,
                    fontSize: 19
                ),
              )
          ),
        ]
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: photosList == null ?  PhotoView(
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 2,
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
  Future<void> saveImageToDevice(String imageUrl) async {
    // Saved with this method.
    await GallerySaver.saveImage(imageUrl,albumName: 'Bebo Auto Service',).then((bool? success) {

    });
  }
}
