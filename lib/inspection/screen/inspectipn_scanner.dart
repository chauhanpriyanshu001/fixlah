import 'dart:developer';

import 'package:fixlah/config/colors.dart';
import 'package:fixlah/config/sizes.dart';
import 'package:fixlah/config/utils.dart';
import 'package:fixlah/inspection/provider/inspection_provider.dart';
import 'package:fixlah/inspection/screen/start_inspection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class InspectipnScanner extends StatefulWidget {
  const InspectipnScanner({super.key});

  @override
  State<InspectipnScanner> createState() => _InspectipnScannerState();
}

class _InspectipnScannerState extends State<InspectipnScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: generalAppBar(context,
          newColor: NewColors.inspectionscolor,
          title: "Unit Details",
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  color: NewColors.whitecolor,
                ))
          ]),
      body: Consumer<InspectionProvider>(
          builder: (context, inspectionProvider, child) {
        return Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: const BoxDecoration(
                  color: NewColors.styleColor,
                ),
                child: Stack(
                  children: [
                    QRView(
                      key: qrKey,
                      onQRViewCreated: (QRViewController controller) async {
                        this.controller = controller;
                        controller.scannedDataStream.listen((scanData) async {
                          result = scanData;

                          log(result!.code.toString());
                          log(result!.rawBytes.toString());
                          log(result!.format.toString());

                          await controller.pauseCamera();
                          setState(() {});
                          await inspectionProvider.getQrData(context,
                              qrid: result!.code!);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const StartInspection())).then((value) {
                            if (value == true) {
                              Navigator.pop(context);
                            } else {
                              controller.resumeCamera();
                              setState(() {});
                            }
                          });
                        });
                      },
                      overlay: QrScannerOverlayShape(
                        overlayColor: NewColors.styleColor,
                        borderColor: Colors.black,
                        borderRadius: 20,
                        borderWidth: 10,
                        borderLength: 80,
                      ),
                    ),
                    // Center(
                    //   child: Image.asset(
                    //     Graphics.qr_icon,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: aspectRatio * 20,
                  ),
                  Text(
                    "Scan your unit QR Code\nor Fill the unit details manually",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: NewColors.black,
                        fontWeight: mediumFontWeight,
                        fontSize: buildFontSize(40)),
                  ),
                  SizedBox(
                    height: aspectRatio * 20,
                  ),
                  NxtBtn(
                    text: "Next",
                    onTap: () async {
                      await controller!.pauseCamera();
                      setState(() {});

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const StartInspection())).then((value) {
                        if (value == true) {
                          Navigator.pop(context);
                        } else {
                          controller!.resumeCamera();
                          setState(() {});
                        }
                      });
                    },
                  )
                ],
              ),
            ))
          ],
        );
      }),
    );
  }
}
