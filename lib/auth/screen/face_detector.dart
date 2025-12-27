import 'dart:io';

import 'package:face_camera/face_camera.dart';
import 'package:fixlah/auth/provider/login_provider.dart';
import 'package:fixlah/auth/screen/confirm_face.dart';
import 'package:fixlah/config/colors.dart';
import 'package:fixlah/config/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FaceDetector extends StatefulWidget {
  final bool? isLogin;
  const FaceDetector({super.key, this.isLogin});

  @override
  State<FaceDetector> createState() => _FaceDetectorState();
}

class _FaceDetectorState extends State<FaceDetector> {
  late FaceCameraController controller;

  @override
  void initState() {
    controller = FaceCameraController(
      autoCapture: false,
      enableAudio: false,
      defaultCameraLens: CameraLens.front,
      onCapture: (File? image) async {
        await context
            .read<LoginState>()
            .saveFaceImage(context, imageFile: image!);
        if (widget.isLogin == true) {
          context.read<LoginState>().faceLock(context);
        } else {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ConfirmFace()))
              .then((value) {
            if (value == true) {
              Navigator.pop(context, true);
            } else {}
          });
        }
        // naviagteTo(context, builder: (context) => ConfirmFace());
      },
      onFaceDetected: (face) {
        controller.captureImage();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginState>(builder: (context, login, child) {
      return Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              backgroundColor: NewColors.primary,
              title: Text(
                "Center your face in the square",
                style: TextStyle(fontSize: 18.r),
              ),
            ),
            body: SmartFaceCamera(
              showControls: true,
              showCameraLensControl: false,
              showFlashControl: false,
              controller: controller,
            ),
          ),
          if (login.loading) FullPageLoadingWidget()
        ],
      );
    });
  }
}
