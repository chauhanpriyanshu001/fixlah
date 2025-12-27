import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:fixlah/config/colors.dart';
import 'package:fixlah/config/constants.dart';
import 'package:fixlah/config/sizes.dart';
import 'package:fixlah/config/text_fields.dart';

import 'package:fixlah/config/utils.dart';
import 'package:fixlah/config/validators.dart';
import 'package:fixlah/home/model/area_response_model.dart';
import 'package:fixlah/issues/provider/issues_provider.dart';
import 'package:fixlah/issues/screens/unit_issue_3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class EditIssueCreate extends StatefulWidget {
  final int index;
  final String issueId;
  const EditIssueCreate(
      {super.key, required this.index, required this.issueId});

  @override
  State<EditIssueCreate> createState() => _EditIssueCreateState();
}

class _EditIssueCreateState extends State<EditIssueCreate> {
  String selctedValue = "";
  String selctedUnitLocation = "";

  TextEditingController issueItem = TextEditingController();
  Map<String, dynamic> addIssue = {};
  var _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<IssuesProvider>(builder: (context, issuesProvider, child) {
      int index = widget.index;
      return Scaffold(
        appBar: generalAppBar(
          context,
          title: "Add Issue",
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                color: NewColors.whitecolor,
                Icons.done,
                size: 25.r,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.r),
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Unit Location Selection

                  const TitleWidget1(
                    title: 'Unit Location',
                  ),

                  SizedBox(
                    height: 10.r,
                  ),

                  Wrap(
                    children: List.generate(areaListResponse!.total!, (index) {
                      AreaData unitLocationData =
                          areaListResponse!.data![index];
                      return Padding(
                        padding: EdgeInsets.all(5.r),
                        child: FilterChip(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.r, horizontal: 10.r),
                          color: const WidgetStatePropertyAll(
                              NewColors.whitecolor),
                          side: BorderSide(
                            width: 2,
                            color: unitLocationData.name == selctedUnitLocation
                                ? NewColors.primary
                                : NewColors.secondaycolor,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(60),
                              side: BorderSide(
                                color:
                                    unitLocationData.name == selctedUnitLocation
                                        ? NewColors.primary
                                        : NewColors.secondaycolor,
                                width: 2,
                              )),
                          label: Text(
                            maxLines: 2,
                            overflow: TextOverflow.clip,
                            unitLocationData.name ?? "-",
                            style: TextStyle(
                                color: NewColors.black,
                                fontSize: buildFontSize(30)),
                          ),
                          onSelected: (value) {
                            selctedUnitLocation = unitLocationData.name ?? "-";
                            addIssue.addAll({
                              "items[${widget.index}][area_id]":
                                  unitLocationData.id
                            });

                            setState(() {});
                          },
                        ),
                      );
                    }),
                  ),
                  SizedBox(
                    height: 10.r,
                  ),
                  const TitleWidget1(
                    title: 'Issue Type',
                  ),
                  SizedBox(
                    height: 10.r,
                  ),
                  DropdownButtonFormField(
                      icon: Icon(
                        size: 20.r,
                        Icons.arrow_drop_down_circle_sharp,
                        color: NewColors.secondayFullcolor,
                      ),
                      style: TextStyle(
                          fontSize: buildFontSize(30), color: NewColors.black),
                      dropdownColor: NewColors.whitecolor,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(fontSize: 0),
                        errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 255, 1, 1),
                                width: 2),
                            borderRadius: BorderRadius.circular(100)),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 15.r, horizontal: 15.r),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: const BorderSide(
                              color: NewColors.secondayFullcolor, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: const BorderSide(
                              color: NewColors.primary, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: const BorderSide(
                              color: NewColors.secondayFullcolor, width: 2),
                        ),
                      ),
                      items: issueTypeDataDropDownlistList,
                      validator: (value) {
                        if (value == null) {
                          return "Select Value";
                        }
                        return null;
                      },
                      hint: Text(
                        "Select Issue Type",
                        style: TextStyle(
                            color: NewColors.black,
                            fontWeight: mediumFontWeight,
                            fontSize: buildFontSize(30)),
                      ),
                      onChanged: (value) {
                        print(value);
                        addIssue.addAll(
                            {"items[$index][issue_type][0]": value!.name});
                      }),
                  SizedBox(
                    height: 10.r,
                  ),
                  CustomTextFields(
                      controller: issueItem,
                      label: "Issue Item",
                      validator: Validators.validateRequired,
                      hintText: "Enter Issue Item"),
                  SizedBox(
                    height: 10.r,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextFieldTitle(label: "Images"),
                      if (issuesProvider.finalImges.length < 5)
                        IconButton(
                            onPressed: () {
                              naviagteTo(context,
                                  builder: (context) => CameraCaptureScreen(
                                        goBack: true,
                                      ));
                            },
                            icon: Icon(Icons.add))
                    ],
                  ),
                  SizedBox(
                    height: 10.r,
                  ),
                  // Images
                  Wrap(
                      children: List.generate(issuesProvider.finalImges.length,
                          (index) {
                    XFile file = issuesProvider.finalImges[index];
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            width: 150.r,
                            height: 150.r,
                            decoration: BoxDecoration(
                                color: NewColors.secondaryBgColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Image.file(File(file.path)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: NewColors.whitecolor),
                              child: IconButton(
                                  onPressed: () {
                                    issuesProvider.deleteImage(index: index);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    size: 20.r,
                                    color: NewColors.red,
                                  )),
                            ),
                          )
                        ],
                      ),
                    );
                  })),
                  SizedBox(
                    height: 20.r,
                  ),
                  NxtBtn(
                    text: "Submit",
                    onTap: () async {
                      if (_key.currentState!.validate()) {
                        addIssue
                            .addAll({"items[$index][item]": issueItem.text});
                        log(addIssue.toString());

                        if (selctedUnitLocation != "" &&
                            issuesProvider.finalImges.isNotEmpty) {
                          await issuesProvider.createIssueItem(
                              context, addIssue, widget.issueId, index);
                        } else {
                          Fluttertoast.showToast(
                              textColor: NewColors.whitecolor,
                              backgroundColor: NewColors.red,
                              fontSize: 15.r,
                              msg: "Invalid Input");
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
