import 'dart:developer';
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
import 'package:fixlah/work%20order/provider/work_order_provider.dart';
import 'package:fixlah/work%20order/screen/completion_pic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
  CarouselSliderController workOrderPhotosController = CarouselSliderController();
  CarouselSliderController completionPhotosController = CarouselSliderController();

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
                      if (woData.data?.createdBy?.createdAt != null)
                        Expanded(
                          child: Text(
                            formateDate(
                                value: woData.data?.createdBy?.createdAt ?? ""),
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
                                text: woData.data?.createdBy?.username ?? "",
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
                      if (woData.data?.createdBy?.createdAt != null)
                        Expanded(
                          child: Text(
                            formateTime(
                                value: woData.data?.createdBy?.createdAt ?? ""),
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                color: NewColors.black,
                                fontSize: buildFontSize(30)),
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
                                  woData.data?.issue?.block?.name.toString() !=
                                          null
                                      ? woData.data!.issue!.block!.name
                                          .toString()
                                      : "-",
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
                                  woData.data?.issue?.unit?.unitNo ?? "-",
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
                                      text: woData.data!.assignee?.name ?? "",
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
                              "Asset Assigned",
                              style: TextStyle(
                                  color: NewColors.secondattextcolor,
                                  fontSize: buildFontSize(25)),
                            ),
                            Text(
                              workOrderProvider
                                      .assetDetails.data?.clientShownName ??
                                  "",
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
                              woData.data!.locationTag?.name ?? "-",
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
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CarouselSlider.builder(
                          carouselController: workOrderPhotosController,
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
                      if ((woData.data!.workorderPhotos?.length ?? 0) > 1)
                        Positioned(
                          left: 0,
                          child: IconButton(
                            onPressed: () =>
                                workOrderPhotosController.previousPage(),
                            icon: const Icon(Icons.arrow_back_ios,
                                color: Colors.white70),
                          ),
                        ),
                      if ((woData.data!.workorderPhotos?.length ?? 0) > 1)
                        Positioned(
                          right: 0,
                          child: IconButton(
                            onPressed: () =>
                                workOrderPhotosController.nextPage(),
                            icon: const Icon(Icons.arrow_forward_ios,
                                color: Colors.white70),
                          ),
                        ),
                    ],
                  ),

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
                                    // validator: Validators.validateRequired,
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
                                        // Clear time if it's now invalid for today
                                        if (date.text ==
                                                DateFormat('yyyy-MM-dd')
                                                    .format(DateTime.now()) &&
                                            time.text.isNotEmpty) {
                                          TimeOfDay nowTime = TimeOfDay.now();
                                          List<String> parts =
                                              time.text.split(":");
                                          int h = int.parse(parts[0]);
                                          int m = int.parse(parts[1]);
                                          if (h < nowTime.hour ||
                                              (h == nowTime.hour &&
                                                  m < nowTime.minute)) {
                                            time.clear();
                                          }
                                        }
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
                                    // validator: Validators.validateRequired,
                                    controller: time,
                                    onTap: () async {
                                      setState(() {});
                                      TimeOfDay? starTime =
                                          await showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now());
                                      if (starTime != null) {
                                        if (date.text ==
                                            DateFormat('yyyy-MM-dd')
                                                .format(DateTime.now())) {
                                          TimeOfDay nowTime = TimeOfDay.now();
                                          if (starTime.hour < nowTime.hour ||
                                              (starTime.hour == nowTime.hour &&
                                                  starTime.minute <
                                                      nowTime.minute)) {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Cannot select previous time");
                                            return;
                                          }
                                        }
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
                          if (files.isNotEmpty)
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                CarouselSlider.builder(
                                  carouselController:
                                      completionPhotosController,
                                  itemCount: files.length,
                                  itemBuilder: (context, index, realIndex) {
                                    File file = File(files[index].path);
                                    return Stack(
                                      children: [
                                        Container(
                                          width: fullWidth,
                                          color: NewColors.whitecolor,
                                          child: Center(
                                            child: Image.file(
                                              file,
                                              height: fullHeight / 5,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 10,
                                          right: 10,
                                          child: Container(
                                              decoration: const BoxDecoration(
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.36),
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
                                  options: CarouselOptions(
                                    viewportFraction: 1,
                                    aspectRatio: 16 / 9,
                                    height: fullHeight / 5,
                                    enableInfiniteScroll: false,
                                  ),
                                ),
                                if (files.length > 1)
                                  Positioned(
                                    left: 0,
                                    child: IconButton(
                                      onPressed: () =>
                                          completionPhotosController
                                              .previousPage(),
                                      icon: const Icon(Icons.arrow_back_ios,
                                          color: Colors.black54),
                                    ),
                                  ),
                                if (files.length > 1)
                                  Positioned(
                                    right: 0,
                                    child: IconButton(
                                      onPressed: () =>
                                          completionPhotosController.nextPage(),
                                      icon: const Icon(Icons.arrow_forward_ios,
                                          color: Colors.black54),
                                    ),
                                  ),
                              ],
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
                    DateTime now = DateTime.now();
                    if (date.text.isEmpty) {
                      date.text = DateFormat('yyyy-MM-dd').format(now);
                    }
                    if (time.text.isEmpty) {
                      time.text = DateFormat('HH:mm').format(now);
                    }

                    String selectedDate = date.text;
                    String selectedTime = time.text;

                    // Auto-adjust if selected date/time is in the past
                    try {
                      DateTime selectedDateTime =
                          DateFormat('yyyy-MM-dd HH:mm')
                              .parse("$selectedDate $selectedTime");
                      if (selectedDateTime.isBefore(now)) {
                        selectedDate = DateFormat('yyyy-MM-dd').format(now);
                        selectedTime = DateFormat('HH:mm').format(now);
                        date.text = selectedDate;
                        time.text = selectedTime;
                      }
                      setState(() {});
                    } catch (e) {
                      log("Date parsing error: $e");
                    }

                    workOrderProvider.completeWO(context,
                        id: woData.data!.id.toString(),
                        body: {
                          "actual_end_date": selectedDate,
                          "actual_end_time": selectedTime,
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
