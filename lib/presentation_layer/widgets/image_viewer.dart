import 'dart:io';
import 'package:bebo_auto_service/components/constans.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:photo_view/photo_view.dart';
import '../../components/components.dart';

class ImageViewer extends StatefulWidget {

final ImageProvider? photo ;
final List<dynamic>? photosList ;
final int? photosListIndex ;
final String? photoUrlToSaveImage ;
final bool? isNetworkImage;

  const ImageViewer({super.key,
    this.photo,
    this.photosList,
    this.photosListIndex,
    this.photoUrlToSaveImage,
    this.isNetworkImage,
  });

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  late int? myCarouselIndex = widget.photosListIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppbar(
          context: context,
        title: '',
        actions: [
          if(widget.photoUrlToSaveImage != null)
          TextButton(
              onPressed: ()  {
                if(widget.photosList != null){
                  for(var image in widget.photosList!){
                    saveImageToDevice(image).then((value) {
                    });
                  }
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('تم حفظ الصوره'),
                  ));
                }
              },
              child:  Text(
                'حفظ',
                style: TextStyle(
                    color: defaultColor,
                    fontSize: 16.sp
                ),
              )
          ),
        ]
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: widget.photosList == null ?  PhotoView(
            minScale: PhotoViewComputedScale.contained * 0.8,
              loadingBuilder: (BuildContext? context,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return myCircularProgressIndicator();
                return Center(
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      color: defaultColor,
                      value: loadingProgress
                          .expectedTotalBytes !=
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
            maxScale: PhotoViewComputedScale.covered * 2,
            backgroundDecoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
              imageProvider: widget.photo
          ) : CarouselSlider(
            items: widget.photosList!
                .map(
                  (e) => ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: PhotoView(
                  imageProvider: widget.isNetworkImage!
                      ? CachedNetworkImageProvider(e)
                      : FileImage(File(e)) as ImageProvider,
                  loadingBuilder: (context, event) => Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue, // Adjust this to your preferred color
                      value: event == null
                          ? 0
                          : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
                    ),
                  ),
                  errorBuilder: (context, error, stackTrace) => const Center(
                    child: Icon(
                      Icons.warning_amber,
                      color: Colors.red,
                      size: 100,
                    ),
                  ),
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  backgroundDecoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  maxScale: PhotoViewComputedScale.covered * 2,
                ),
              ),
            )
                .toList(),
            options: CarouselOptions(
              height: double.infinity,
              initialPage: myCarouselIndex ?? 0,
              enableInfiniteScroll: false,
              enlargeCenterPage: false,
              reverse: false,
              viewportFraction: 1.0,
              autoPlay: false,
              scrollDirection: Axis.horizontal,
              scrollPhysics: const BouncingScrollPhysics(),
              onPageChanged: (index, _) {
                setState(() {
                  myCarouselIndex = index;
                });
              },
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
