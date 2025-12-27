import 'dart:developer';

import 'package:fixlah/common/permission_handler.dart';
import 'package:fixlah/config/colors.dart';

import 'package:fixlah/config/sizes.dart';
import 'package:fixlah/config/utils.dart';

import 'package:fixlah/issues/provider/issues_provider.dart';
import 'package:fixlah/issues/screens/create_issue.dart';
import 'package:fixlah/issues/screens/unit_issue_2.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class UnitIssue extends StatefulWidget {
  const UnitIssue({super.key});

  @override
  State<UnitIssue> createState() => _UnitIssueState();
}

class _UnitIssueState extends State<UnitIssue> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    await requestCameraPermission();
    await controller?.resumeCamera();
    await controller?.getCameraInfo();
  }

  @override
  void dispose() {
    super.dispose();
    controller!.stopCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: generalAppBar(context, title: "Create Issue", actions: [
        IconButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            icon: Icon(
              Icons.close,
              size: 25.r,
              color: NewColors.whitecolor,
            ))
      ]),
      body: Consumer<IssuesProvider>(builder: (context, issuesProvider, child) {
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
                      onQRViewCreated: (QRViewController controller) {
                        this.controller = controller;
                        controller.scannedDataStream.listen((scanData) {
                          setState(() {
                            result = scanData;

                            log(result!.code.toString());
                            log(result!.rawBytes.toString());
                            log(result!.format.toString());

                            controller.pauseCamera();
                            issuesProvider.getQrData(context,
                                qrid: result!.code!);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const UnitIssue2())).then((value) {
                              if (value == true) {
                                Navigator.pop(context, true);
                              } else {
                                controller.resumeCamera();
                              }
                            });
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
                    onTap: () {
                      controller!.pauseCamera();
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CreateIssue()))
                          .then((value) {
                        if (value) {
                          Navigator.pop(context, true);
                        } else {
                          controller!.resumeCamera();
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
