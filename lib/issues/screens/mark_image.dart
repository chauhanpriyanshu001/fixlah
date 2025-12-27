import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:fixlah/config/colors.dart';
import 'package:fixlah/config/graphics.dart';
import 'package:fixlah/config/sizes.dart';
import 'package:fixlah/config/utils.dart';
import 'package:fixlah/issues/provider/issues_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_painter/image_painter.dart';
import 'package:provider/provider.dart';

class MarkImageScreen extends StatefulWidget {
  final ui.Image capturedImage;
  final File capturedImageFile;
  final bool goback;
  final bool? addImage;
  final int? index;

  const MarkImageScreen(
      {required this.capturedImage,
      Key? key,
      required this.capturedImageFile,
      required this.goback,
      this.addImage,
      this.index})
      : super(key: key);

  @override
  State<MarkImageScreen> createState() => _MarkImageScreenState();
}

class _MarkImageScreenState extends State<MarkImageScreen> {
  List<Offset?> points = [];
  bool paint = false;
  bool zoom = false;
  final imagePainterController = ImagePainterController(
      color: NewColors.primary, mode: PaintMode.freeStyle);

  // Creates a new image with drawing
  Future<Uint8List> _exportMarkedImage() async {
    print(imagePainterController.paintHistory);
    final byteData = await imagePainterController.exportImage();
    return byteData!.buffer.asUint8List();
  }

  @override
  void dispose() {
    widget.capturedImage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<IssuesProvider>(builder: (context, issuesProvider, child) {
      return Stack(
        children: [
          Scaffold(
            appBar: generalAppBar(
              context,
              title: "Create Issue",
              actions: [
                IconButton(
                    onPressed: () async {
                      if (imagePainterController.paintHistory.isNotEmpty) {
                        if (widget.addImage == true) {
                          await context.read<IssuesProvider>().addItemImage(
                              context,
                              byteList: await _exportMarkedImage(),
                              index: widget.index!);
                        } else {
                          await context.read<IssuesProvider>().saveImage(
                              context,
                              byteList: await _exportMarkedImage(),
                              goback: widget.goback);
                        }
                      } else {
                        Fluttertoast.showToast(
                            textColor: NewColors.black,
                            backgroundColor: NewColors.whitecolor,
                            fontSize: 15.r,
                            msg: "Please Mark Issue");
                      }
                    },
                    icon: Icon(
                      Icons.check,
                      color: NewColors.whitecolor,
                    ))
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  flex: 8,
                  child: ImagePainter.file(
                    widget.capturedImageFile,
                    controller: imagePainterController,
                    scalable: zoom,
                    showControls: false,
                  ),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {
                          zoom = true;
                          imagePainterController.setMode(PaintMode.none);
                          setState(() {});
                        },
                        icon: Icon(
                          zoom != true ? Icons.zoom_in_map : Icons.zoom_out_map,
                          color: zoom == true
                              ? NewColors.primary
                              : NewColors.black,
                          size: aspectRatio * 50,
                        )),
                    InkWell(
                      onTap: () {
                        imagePainterController.setMode(PaintMode.freeStyle);
                        zoom = false;
                        setState(() {});
                      },
                      child: Row(
                        children: [
                          ImageIcon(
                            color: zoom == true
                                ? NewColors.black
                                : NewColors.primary,
                            AssetImage(
                              Graphics.edit_circle_icon,
                            ),
                            size: 20.r,
                          ),
                          // Image(
                          //   width: aspectRatio * 45,
                          //   image: AssetImage(Graphics.edit_circle_icon),
                          // ),
                          SizedBox(
                            width: aspectRatio * 15,
                          ),
                          Text(
                            "Mark Issue",
                            style: TextStyle(
                                fontWeight: boldFontWeight,
                                fontSize: buildFontSize(30)),
                          )
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          zoom = false;
                          imagePainterController.clear();
                          imagePainterController.setMode(PaintMode.freeStyle);
                          setState(() {});
                          print(zoom);
                        },
                        icon: Icon(
                          Icons.clear,
                          size: aspectRatio * 50,
                        )),
                  ],
                ))
              ],
            ),
          ),
          if (issuesProvider.loading) FullPageLoadingWidget()
        ],
      );
    });
  }
}
