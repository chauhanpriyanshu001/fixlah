// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fixlah/config/colors.dart';
import 'package:fixlah/inspection/model/inspection_get_model.dart';

import 'package:fixlah/issues/model/issues_model.dart';
import 'package:flutter/material.dart';

class ImageViewer extends StatefulWidget {
  final int index;
  final List? itemImages;
  final String baseUrl;

  const ImageViewer({
    Key? key,
    required this.index,
    this.itemImages,
    required this.baseUrl,
  }) : super(key: key);

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  late int currentIndex;
  @override
  void initState() {
    super.initState();
    currentIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: NewColors.black,
        appBar: AppBar(
          backgroundColor: NewColors.black,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: NewColors.whitecolor,
            ),
          ),
        ),
        body: Container(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          padding: EdgeInsets.zero,
          child: CarouselSlider.builder(
              itemCount: widget.itemImages!.length,
              itemBuilder: (context, index, realIndex) {
                Photos? photodata;

                if (widget.itemImages.runtimeType == List<Photos>) {
                  photodata = widget.itemImages![index];
                }
                ReferencePhotos? referencePhotos;
                if (widget.itemImages.runtimeType == List<ReferencePhotos>) {
                  referencePhotos = widget.itemImages![index];
                }

                return InteractiveViewer(
                  // maxScale: 1,
                  // minScale: 0.2,
                  child: Image(
                      image: NetworkImage(
                        "${widget.baseUrl}${photodata?.photoPath ?? referencePhotos?.photoUrl}",
                      ),
                      fit: BoxFit.contain),
                );
              },
              options: CarouselOptions(
                viewportFraction: 1,
                onScrolled: (value) {
                  currentIndex = value!.toInt();
                  setState(() {});
                },
                padEnds: false,
                enableInfiniteScroll: false,
                aspectRatio: MediaQuery.sizeOf(context).aspectRatio,
                autoPlay: false,
                initialPage: widget.index,
              )),
        ));
  }
}
