import 'dart:io';

import 'package:camera/camera.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fixlah/common/image_viewer.dart';
import 'package:fixlah/config/colors.dart';
import 'package:fixlah/config/constants.dart';
import 'package:fixlah/config/graphics.dart';
import 'package:fixlah/config/sizes.dart';
import 'package:fixlah/config/text_fields.dart';
import 'package:fixlah/config/utils.dart';
import 'package:fixlah/config/validators.dart';
import 'package:fixlah/issues/model/issues_model.dart';
import 'package:fixlah/work%20order/model/work_order_detail_model.dart';
import 'package:fixlah/work%20order/model/work_order_model.dart';
import 'package:fixlah/work%20order/provider/work_order_provider.dart';
import 'package:fixlah/work%20order/screen/completion_pic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class WoDeatils extends StatefulWidget {
  final String id;
  const WoDeatils({super.key, required this.id});

  @override
  State<WoDeatils> createState() => _WoDeatilsState();
}

class _WoDeatilsState extends State<WoDeatils> {
  TextEditingController remark = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();
  List<XFile> files = [];
  var formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<WorkOrderProvider>(
        context,
        listen: false,
      ).getWoDetails(context, woId: widget.id);
    });
  }

  @override
  void dispose() {
    super.dispose();
    remark.dispose();
    date.dispose();
    time.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkOrderProvider>(
        builder: (context, workOrderProvider, child) {
      WorkOrderDetails woData = workOrderProvider.selctedWOData;
      return Scaffold(
        backgroundColor: NewColors.secondaryBgColor,
        appBar: generalAppBar(
          context,
          title: "WO Details",
          newColor: NewColors.workordercolor,
        ),
        body: workOrderProvider.loading
            ? const LoadinWidget()
            : ListView(
                padding: EdgeInsets.all(aspectRatio * 40),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          woData.data?.woIdAuto ?? "-",
                          style: TextStyle(
                              color: NewColors.black,
                              fontWeight: boldFontWeight,
                              fontSize: buildFontSize(30)),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          formateDate(value: woData.data!.createdAt!),
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: NewColors.black,
                              fontSize: buildFontSize(30)),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: aspectRatio * 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: "WO Issued by ",
                            style: TextStyle(
                              fontSize: buildFontSize(25),
                              fontWeight: FontWeight.w500,
                              color: NewColors.secondattextcolor,
                            ),
                            children: [
                              TextSpan(
                                text: woData.data?.createdBy?.name ?? "",
                                style: TextStyle(
                                  fontSize: buildFontSize(25),
                                  fontWeight: FontWeight.bold,
                                  color: NewColors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          formateTime(value: woData.data!.createdAt!),
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: NewColors.secondattextcolor,
                              fontSize: buildFontSize(27)),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: aspectRatio * 40,
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: NewColors.whitecolor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Issue Category",
                                    style: TextStyle(
                                        color: NewColors.secondattextcolor,
                                        fontSize: buildFontSize(25)),
                                  ),
                                  Text(
                                    woData.data?.issue?.issueType ?? "",
                                    style: TextStyle(
                                        color: NewColors.workordercolor,
                                        fontWeight: boldFontWeight,
                                        fontSize: buildFontSize(30)),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: woData.data!.creamUnit == 0
                                        ? NewColors.red
                                        : NewColors.greencolor,
                                  ),
                                  child: Text(
                                    woData.data!.creamUnit == 0
                                        ? "NON-CREAM"
                                        : "CREAM",
                                    style: TextStyle(
                                        color: NewColors.whitecolor,
                                        fontWeight: boldFontWeight,
                                        fontSize: buildFontSize(25)),
                                  ),
                                ),
                                SizedBox(
                                  width: aspectRatio * 10,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: woData.data?.issue?.priority == "yes"
                                        ? NewColors.red
                                        : NewColors.greencolor,
                                  ),
                                  child: Text(
                                    woData.data?.issue?.priority == "yes"
                                        ? "URGENT"
                                        : "NOT URGENT",
                                    style: TextStyle(
                                        color: NewColors.whitecolor,
                                        fontWeight: boldFontWeight,
                                        fontSize: buildFontSize(25)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(
                          color: NewColors.secondaycolor,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Facility",
                                  style: TextStyle(
                                      color: NewColors.secondattextcolor,
                                      fontSize: buildFontSize(25)),
                                ),
                                Text(
                                  woData.data?.facility?.name ?? "-",
                                  style: TextStyle(
                                      color: NewColors.black,
                                      fontWeight: mediumFontWeight,
                                      fontSize: buildFontSize(30)),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Block",
                                  style: TextStyle(
                                      color: NewColors.secondattextcolor,
                                      fontSize: buildFontSize(25)),
                                ),
                                Text(
                                  woData.data?.locationTag.toString() ?? "-",
                                  style: TextStyle(
                                      color: NewColors.black,
                                      fontWeight: mediumFontWeight,
                                      fontSize: buildFontSize(30)),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Unit No",
                                  style: TextStyle(
                                      color: NewColors.secondattextcolor,
                                      fontSize: buildFontSize(25)),
                                ),
                                Text(
                                  woData.data!.locationTag ?? "-",
                                  style: TextStyle(
                                      color: NewColors.black,
                                      fontWeight: mediumFontWeight,
                                      fontSize: buildFontSize(30)),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(
                          color: NewColors.secondaycolor,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text.rich(
                                TextSpan(
                                  text: "Created by ",
                                  style: TextStyle(
                                    fontSize: buildFontSize(25),
                                    fontWeight: FontWeight.w500,
                                    color: NewColors.secondattextcolor,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: woData.data!.createdBy?.name ?? "",
                                      style: TextStyle(
                                        fontSize: buildFontSize(25),
                                        fontWeight: FontWeight.bold,
                                        color: NewColors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "${formateDate(value: woData.data!.createdAt ?? "-")} ${formateTime(value: woData.data!.createdAt ?? "-")}",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: NewColors.secondattextcolor,
                                    fontWeight: mediumFontWeight,
                                    fontSize: buildFontSize(25)),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: NewColors.secondaycolor,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text.rich(
                                TextSpan(
                                  text: "Assigned to ",
                                  style: TextStyle(
                                    fontSize: buildFontSize(25),
                                    fontWeight: FontWeight.w500,
                                    color: NewColors.secondattextcolor,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: woData.data!.assignedTo ?? "",
                                      style: TextStyle(
                                        fontSize: buildFontSize(25),
                                        fontWeight: FontWeight.bold,
                                        color: NewColors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "${formateDate(value: woData.data!.assignee?.createdAt ?? "-")} ${formateTime(value: woData.data!.assignee?.createdAt ?? "-")}",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: NewColors.secondattextcolor,
                                    fontWeight: mediumFontWeight,
                                    fontSize: buildFontSize(25)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: aspectRatio * 20,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: aspectRatio * 40,
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: NewColors.whitecolor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Unit No",
                              style: TextStyle(
                                  color: NewColors.secondattextcolor,
                                  fontSize: buildFontSize(25)),
                            ),
                            Text(
                              woData.data!.issueItem?.item ?? "",
                              style: TextStyle(
                                  color: NewColors.workordercolor,
                                  fontWeight: boldFontWeight,
                                  fontSize: buildFontSize(30)),
                            ),
                          ],
                        ),
                        const Divider(
                          color: NewColors.secondaycolor,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Assigned Location",
                              style: TextStyle(
                                  color: NewColors.secondattextcolor,
                                  fontSize: buildFontSize(25)),
                            ),
                            Text(
                              woData.data!.locationTag ?? "-",
                              style: TextStyle(
                                  color: NewColors.black,
                                  fontWeight: boldFontWeight,
                                  fontSize: buildFontSize(30)),
                            ),
                          ],
                        ),
                        const Divider(
                          color: NewColors.secondaycolor,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "WO Description",
                              style: TextStyle(
                                  color: NewColors.secondattextcolor,
                                  fontSize: buildFontSize(25)),
                            ),
                            Text(
                              woData.data!.description ?? "-",
                              style: TextStyle(
                                  color: NewColors.black,
                                  fontWeight: boldFontWeight,
                                  fontSize: buildFontSize(30)),
                            ),
                          ],
                        ),
                        const Divider(
                          color: NewColors.secondaycolor,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Expected End Date",
                                  style: TextStyle(
                                      color: NewColors.secondattextcolor,
                                      fontSize: buildFontSize(25)),
                                ),
                                Text(
                                  woData.data!.expectedEndDate ?? "-",
                                  style: TextStyle(
                                      color: NewColors.black,
                                      fontWeight: mediumFontWeight,
                                      fontSize: buildFontSize(30)),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Expected End Time",
                                  style: TextStyle(
                                      color: NewColors.secondattextcolor,
                                      fontSize: buildFontSize(25)),
                                ),
                                Text(
                                  woData.data!.expectedEndTime ?? "",
                                  style: TextStyle(
                                      color: NewColors.black,
                                      fontWeight: mediumFontWeight,
                                      fontSize: buildFontSize(30)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: aspectRatio * 40,
                  ),
                  CarouselSlider.builder(
                      itemCount: woData.data!.workorderPhotos?.length ?? 0,
                      itemBuilder: (context, index, realIndex) {
                        return InkWell(
                          onTap: () {
                            List<Photos> itemImages = [];
                            for (var i = 0;
                                i < woData.data!.workorderPhotos!.length;
                                i++) {
                              itemImages.add(Photos.fromJson(woData
                                  .data!.workorderPhotos![index]
                                  .toJson()));
                            }
                            naviagteTo(context,
                                builder: (context) => ImageViewer(
                                    index: index,
                                    itemImages: itemImages,
                                    baseUrl: AppConstants.woImageBaseUrl));
                          },
                          child: Container(
                            width: fullWidth,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "${AppConstants.woImageBaseUrl}${woData.data!.workorderPhotos?[index].photoPath}"),
                              ),
                            ),
                          ),
                        );
                      },
                      options: CarouselOptions(
                          viewportFraction: 1,
                          autoPlay: true,
                          enableInfiniteScroll: false)),
                  SizedBox(
                    height: aspectRatio * 30,
                  ),
                  //  Completion details
                  if (checkPermission(permit: "complete work order"))
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CustomTextFields(
                              label: "Completion Remarks",
                              controller: remark,
                              validator: Validators.validateRequired,
                              textInputAction: TextInputAction.done,
                              hintText: "Enter Remark"),
                          SizedBox(
                            height: aspectRatio * 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextFields(
                                    validator: Validators.validateRequired,
                                    label: "Actual End Date",
                                    controller: date,
                                    onTap: () async {
                                      print("object");

                                      final selcteddate = await showDatePicker(
                                          context: context,
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(3000));
                                      if (selcteddate != null) {
                                        final f = DateFormat('yyyy-MM-dd');
                                        date.text = f.format(selcteddate);
                                        setState(() {});
                                      }
                                    },
                                    readOnly: true,
                                    hintText: "Date"),
                              ),
                              SizedBox(
                                width: aspectRatio * 20,
                              ),
                              Expanded(
                                child: CustomTextFields(
                                    label: "Actual End Time",
                                    validator: Validators.validateRequired,
                                    controller: time,
                                    onTap: () async {
                                      setState(() {});
                                      TimeOfDay? starTime =
                                          await showTimePicker(
                                              context: context,
                                              initialTime: const TimeOfDay(
                                                  hour: 12, minute: 00));
                                      if (starTime != null) {
                                        final String time24 =
                                            '${starTime.hour.toString().padLeft(2, '0')}:${starTime.minute.toString().padLeft(2, '0')}';
                                        print(time24);
                                        time.text = time24;

                                        setState(() {});
                                      }
                                    },
                                    readOnly: true,
                                    hintText: "Time"),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: aspectRatio * 20,
                          ),
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) => SizedBox(
                              height: aspectRatio * 10,
                            ),
                            itemCount: files.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              File file = File(files[index].path);
                              return Stack(
                                children: [
                                  Container(
                                    color: NewColors.whitecolor,
                                    child: Center(
                                      child: Image.file(
                                        file,
                                        height: fullHeight / 5,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 20,
                                    right: 20,
                                    child: Container(
                                        decoration: const BoxDecoration(
                                          color: Color.fromRGBO(0, 0, 0, 0.36),
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconButton(
                                            onPressed: () {
                                              files.removeAt(index);
                                              setState(() {});
                                            },
                                            icon: const Icon(
                                              Icons.close,
                                              color: NewColors.whitecolor,
                                            ))),
                                  ),
                                ],
                              );
                            },
                          ),
                          SizedBox(
                            height: aspectRatio * 20,
                          ),
                          InkWell(
                            onTap: () async {
                              if (files.length < 10) {
                                Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const CompleteionCameraCaptureScreen()))
                                    .then((value) {
                                  if (value != null && value != "") {
                                    files.add(value);
                                    setState(() {});
                                  }
                                });
                              } else {
                                Fluttertoast.showToast(
                                    fontSize: 15.r,
                                    textColor: NewColors.whitecolor,
                                    backgroundColor: NewColors.red,
                                    msg: "Limit Reached");
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  width: 2,
                                  color: NewColors.secondaycolor,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    Graphics.add_photos,
                                    width: aspectRatio * 50,
                                  ),
                                  SizedBox(
                                    width: aspectRatio * 30,
                                  ),
                                  Text(
                                    "Add completion Photos",
                                    style: TextStyle(
                                        fontWeight: boldFontWeight,
                                        color: NewColors.black,
                                        fontSize: buildFontSize(32)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(
                    height: aspectRatio * 130,
                  ),
                ],
              ),
        bottomSheet: Container(
            width: double.infinity,
            color: NewColors.whitecolor,
            padding: EdgeInsets.all(aspectRatio * 20),
            child: NxtBtn(
              text: "Complete",
              onTap: () {
                if (formKey.currentState!.validate()) {
                  if (files.length != 0) {
                    workOrderProvider.completeWO(context,
                        id: woData.data!.id.toString(),
                        body: {
                          "actual_end_date": date.text,
                          "actual_end_time": time.text,
                          "completion_remarks": remark.text
                        },
                        file: files);
                  } else {
                    Fluttertoast.showToast(
                        backgroundColor: NewColors.whitecolor,
                        textColor: NewColors.black,
                        fontSize: 15.r,
                        msg: "Please Add Completion Photos");
                  }
                }
              },
            )),
      );
    });
  }
}
