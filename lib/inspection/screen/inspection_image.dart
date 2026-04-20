import 'dart:developer';
import 'dart:io';

import 'package:fixlah/config/colors.dart';
import 'package:fixlah/config/utils.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;
import 'package:permission_handler/permission_handler.dart';

class InspectionPhotoScreen extends StatefulWidget {
  const InspectionPhotoScreen({super.key});

  @override
  State<InspectionPhotoScreen> createState() => _InspectionPhotoScreenState();
}

class _InspectionPhotoScreenState extends State<InspectionPhotoScreen> {
  CameraController? controller;
  List<CameraDescription> cameras = [];
  bool isFlashOn = false;
  double zoom = 1.0;
  XFile? imagefile;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await Permission.camera.request();
    cameras = await availableCameras();
    controller = CameraController(
      cameras.isNotEmpty ? cameras[0] : throw Exception('No cameras found'),
      ResolutionPreset.high,
      enableAudio: false,
    );
    await controller?.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<void> _toggleFlash() async {
    if (controller != null && controller!.value.isInitialized) {
      isFlashOn = !isFlashOn;
      await controller!
          .setFlashMode(isFlashOn ? FlashMode.torch : FlashMode.off);
      setState(() {});
    }
  }

  Future<void> _toggleZoom() async {
    if (controller != null && controller!.value.isInitialized) {
      zoom = zoom == 1.0 ? 2.0 : 1.0;
      await controller!.setZoomLevel(zoom);
      setState(() {});
    }
  }

  Future<void> _capture() async {
    if (controller != null && controller!.value.isInitialized) {
      final image = await controller!.takePicture();
      // Bake orientation for iOS (fixes flipped/rotated images)
      try {
        final bytes = await image.readAsBytes();
        img.Image? capturedImage = img.decodeImage(bytes);
        if (capturedImage != null) {
          final bakedImage = img.bakeOrientation(capturedImage);
          await File(image.path).writeAsBytes(img.encodeJpg(bakedImage));
        }
      } catch (e) {
        log("Error baking orientation: $e");
      }
      imagefile = image;

      controller!.pausePreview();

      Navigator.pop(context, imagefile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: generalAppBar(
        context,
        newColor: NewColors.inspectionscolor,
        title: "Inspection Photo",
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                color: NewColors.whitecolor,
              ))
        ],
      ),
      body: imagefile != null
          ? Center(
              child: Image.file(File(imagefile!.path)),
            )
          : controller == null || !controller!.value.isInitialized
              ? Center(child: CircularProgressIndicator())
              : Stack(
                  children: [
                    Center(child: CameraPreview(controller!)),
                    Positioned(
                      bottom: 40,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Zoom Button
                          InkWell(
                            onTap: _toggleZoom,
                            child: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                              child: Center(
                                child: Text('${zoom.toInt()}x',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                          SizedBox(width: 40),
                          // Capture Button
                          InkWell(
                            onTap: _capture,
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: NewColors.whitecolor,
                              ),
                            ),
                          ),
                          SizedBox(width: 40),
                          // Flash Button
                          InkWell(
                            onTap: _toggleFlash,
                            child: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                              child: Center(
                                child: Icon(
                                  isFlashOn ? Icons.flash_on : Icons.flash_off,
                                  color: Colors.black,
                                  size: 28,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
    );
  }
}
