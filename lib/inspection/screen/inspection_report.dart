import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:fixlah/config/colors.dart';
import 'package:fixlah/config/sizes.dart';
import 'package:fixlah/config/text_fields.dart';
import 'package:fixlah/config/utils.dart';
import 'package:fixlah/config/validators.dart';

import 'package:fixlah/inspection/provider/inspection_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';

class InspectionReport extends StatefulWidget {
  const InspectionReport({super.key});

  @override
  State<InspectionReport> createState() => _InspectionReportState();
}

class _InspectionReportState extends State<InspectionReport> {
  TextEditingController name = TextEditingController();
  TextEditingController designation = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();
  var formKey = GlobalKey<FormState>();

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  @override
  void dispose() {
    super.dispose();
    name.dispose();
    designation.dispose();
    date.dispose();
    time.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<InspectionProvider>(
        builder: (context, inspectionProvider, child) {
      return Stack(
        children: [
          Scaffold(
              appBar: generalAppBar(context,
                  title: "Acknowledgement",
                  newColor: NewColors.inspectionscolor,
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          size: aspectRatio * 50,
                          color: NewColors.whitecolor,
                          Icons.close,
                        ))
                  ]),
              body: Form(
                key: formKey,
                child: ListView(
                  padding: EdgeInsets.all(aspectRatio * 50),
                  children: [
                    Text(
                      "${inspectionProvider.tabStatus == "2nd Inspection" ? "Agent" : "Company"} Representative Acknowledgement",
                      style: TextStyle(
                        fontSize: buildFontSize(35),
                        fontWeight: boldFontWeight,
                        color: NewColors.inspectionscolor,
                      ),
                    ),
                    SizedBox(
                      height: 10.r,
                    ),
                    Divider(
                      color: NewColors.secondaycolor,
                    ),
                    SizedBox(
                      height: 10.r,
                    ),
                    CustomTextFields(
                      label: "Name",
                      controller: name,
                      hintText: "Enter Name",
                      validator: Validators.validateRequired,
                    ),
                    SizedBox(
                      height: 10.r,
                    ),
                    CustomTextFields(
                        label: "Designation",
                        controller: designation,
                        validator: Validators.validateRequired,
                        hintText: "Enter Designation"),
                    SizedBox(
                      height: 10.r,
                    ),
                    // Date
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFields(
                              validator: Validators.validateRequired,
                              label: "Completion Date",
                              controller: date,
                              onTap: () async {
                                print("object");

                                final selcteddate = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(3000));
                                if (selcteddate != null) {
                                  final f = DateFormat('dd-MM-yyyy');
                                  date.text = f.format(selcteddate);
                                  setState(() {});
                                }
                              },
                              readOnly: true,
                              hintText: "Select Date"),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.r,
                    ),
                    Text(
                      "I acknowledge that the report complied is as per the agreed condition of the property at the time of inspection",
                      style: TextStyle(
                        fontSize: buildFontSize(32),
                        color: NewColors.black,
                      ),
                    ),
                    SizedBox(
                      height: 10.r,
                    ),
                    Container(
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: NewColors.black, width: 2)),
                      child: Signature(
                        controller: _controller,
                        height: 80.r,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: aspectRatio * 40,
                    ),
                    NxtBtn(
                      text: inspectionProvider.tabStatus == "2nd Inspection"
                          ? "Generate Report"
                          : "Complete Registration",
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          if (_controller.isNotEmpty) {
                            String fileParameter = "";
                            Map<String, dynamic> body = {};

                            if (inspectionProvider.tabStatus ==
                                "2nd Inspection") {
                              body = {
                                'type': 'agent',
                                'agent_rep_name': name.text,
                                'agent_rep_designation': designation.text,
                                'agent_rep_date': date.text,
                              };
                              fileParameter = "agent_rep_signature";
                            } else {
                              body = {
                                'type': 'company',
                                'company_rep_name': name.text,
                                'company_rep_designation': designation.text,
                                'company_rep_date': date.text,
                              };
                              fileParameter = "company_rep_signature";
                            }

                            final tempDir = await getTemporaryDirectory();
                            Uint8List? tempSign =
                                await _controller.toPngBytes();

                            File file = File(
                                "${tempDir.path}/sign_${name.text}_${DateTime.now().toIso8601String()}.png");
                            await file.writeAsBytes(tempSign!);
                            List<XFile> sign = [XFile(file.path)];
                            print(await file.length());
                            log(body.toString());

                            showDialog(
                              context: context,
                              builder: (context) {
                                return SimpleDialog(
                                  backgroundColor: NewColors.whitecolor,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(aspectRatio * 80),
                                      child: Column(
                                        children: [
                                          Text(
                                            textAlign: TextAlign.center,
                                            "Your can not modify the report once completed. Do you want to complete the Inspection Report ?",
                                            style: TextStyle(
                                              fontWeight: boldFontWeight,
                                              color: NewColors.black,
                                              fontSize: buildFontSize(30),
                                            ),
                                          ),
                                          SizedBox(height: aspectRatio * 50),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10.r),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      border: Border.all(
                                                          color: NewColors
                                                              .secondaycolor,
                                                          width: 2),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "No",
                                                        style: TextStyle(
                                                          fontSize:
                                                              buildFontSize(35),
                                                          color:
                                                              NewColors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.r,
                                              ),
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    inspectionProvider
                                                        .completeInspection(
                                                      context,
                                                      body: body,
                                                      file: sign,
                                                      fileParameter:
                                                          fileParameter,
                                                    );
                                                    // Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10.r),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      border: Border.all(
                                                          color:
                                                              NewColors.primary,
                                                          width: 2),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Yes",
                                                        style: TextStyle(
                                                          fontSize:
                                                              buildFontSize(35),
                                                          color:
                                                              NewColors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              },
                            );
                          } else {
                            Fluttertoast.showToast(
                                fontSize: 15.r,
                                textColor: NewColors.black,
                                backgroundColor: NewColors.whitecolor,
                                msg: "Please Sign Acknowledgement");
                          }
                        }
                      },
                    )
                  ],
                ),
              )),
          if (inspectionProvider.loading) const FullPageLoadingWidget()
        ],
      );
    });
  }
}
