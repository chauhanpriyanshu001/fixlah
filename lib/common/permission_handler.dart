import 'package:camera/camera.dart';

// Call this before using QRView
Future<void> requestCameraPermission() async {
  try {
    await availableCameras(); // iOS shows popup here
    print("Camera permission granted");
  } catch (e) {
    print("User denied camera permission or no camera");
  }
}
