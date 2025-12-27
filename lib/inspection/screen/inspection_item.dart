// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:fixlah/config/colors.dart';
import 'package:fixlah/config/constants.dart';
import 'package:fixlah/config/graphics.dart';
import 'package:fixlah/config/sizes.dart';
import 'package:fixlah/config/text_fields.dart';
import 'package:fixlah/config/utils.dart';
import 'package:fixlah/config/validators.dart';
import 'package:fixlah/inspection/model/inspection_get_model.dart';
import 'package:fixlah/inspection/provider/inspection_provider.dart';
import 'package:fixlah/inspection/screen/inspection_image.dart';

class InspectionItem extends StatefulWidget {
  const InspectionItem({super.key});

  @override
  State<InspectionItem> createState() => _InspectionItemState();
}

class _InspectionItemState extends State<InspectionItem> {
  String selected = "";

  TextEditingController remark = TextEditingController();
  var formKey = GlobalKey<FormState>();
  Map<String, dynamic> body = {};
  bool loading = false;
  List statusList = [
    {
      "name": "Not Applicable",
      "value": "Not Applicable",
      "icon": Icon(
        Icons.error,
        size: 25.r,
        color: NewColors.primary,
      ),
    },
    {
      "name": "Pass",
      "value": "Good",
      "icon": Container(
          decoration: const BoxDecoration(
              color: NewColors.greencolor, shape: BoxShape.circle),
          child: Icon(
            size: 25.r,
            Icons.done,
            color: NewColors.whitecolor,
          )),
    },
    {
      "name": "Fail",
      "value": "Not Good",
      "icon": Container(
          decoration:
              const BoxDecoration(color: NewColors.red, shape: BoxShape.circle),
          child: Icon(
            size: 25.r,
            Icons.close,
            color: NewColors.whitecolor,
          )),
    },
  ];
  @override
  void initState() {
    super.initState();
    loading = true;
    setState(() {});
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      InspectionProvider inspectionProvider = Provider.of<InspectionProvider>(
        context,
        listen: false,
      );

      Items data = inspectionProvider.selctedItem;
      remark.text = data.remarks ?? "";
      if (data.condition != null) {
        selected = data.condition == "Good"
            ? "Pass"
            : data.condition == "Not Good"
                ? "Fail"
                : "Not Applicable";
      }

      if (data.condition == "Not Good") {}
      if (data.overallGrade != null) {
        print(data.overallGrade);
        selected = data.overallGrade == "A"
            ? "Very Clean"
            : data.overallGrade == "B"
                ? "Meet Min Std"
                : "Need Re-Cleaning";
      }
      loading = false;
      setState(() {});
    });
  }

  @override
  void dispose() {
    remark.dispose();
    super.dispose();
  }

  bool validation(Items data) {
    bool? status;
    if (formKey.currentState!.validate() && selected != "") {
      status = true;
      if (selected != "Not Applicable") {
        body.addAll({"remarks": remark.text});
        if (selected == "Pass" && data.goodPhotos?.length == 0) {
          Fluttertoast.showToast(
            msg: "Add Good Photo to Continue",
            textColor: NewColors.whitecolor,
            backgroundColor: NewColors.red,
            fontSize: 15.r,
          );
          status = false;
        }
        if (selected == "Fail") {
          if (data.afterPhotos?.length == 0 || data.beforePhotos?.length == 0) {
            Fluttertoast.showToast(
              msg: "Add Photo to Continue",
              textColor: NewColors.whitecolor,
              backgroundColor: NewColors.red,
              fontSize: 15.r,
            );
            status = false;
          }
        }
      }
    } else {
      if (selected == "") {
        Fluttertoast.showToast(
          msg: "Please Select Option",
          textColor: NewColors.whitecolor,
          backgroundColor: NewColors.red,
          fontSize: 15.r,
        );
      }
      status = false;
    }
    return status;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<InspectionProvider>(
        builder: (context, inspectionProvider, child) {
      Items data = inspectionProvider.selctedItem;

      return GestureDetector(
        onTap: () => closekeyboard(),
        child: Stack(
          children: [
            Scaffold(
              appBar: generalAppBar(context,
                  title: data.category?.name ?? "-",
                  newColor: NewColors.inspectionscolor,
                  actions: [
                    IconButton(
                        onPressed: () {
                          if (validation(data)) {
                            log(body.toString());
                            inspectionProvider.saveItem(context,
                                inspectionId: data.inspectionId!,
                                itemId: data.id!,
                                body: body);
                          }
                        },
                        icon: Icon(
                          size: 25.r,
                          color: NewColors.whitecolor,
                          Icons.done,
                        ))
                  ]),
              body: loading
                  ? const LoadinWidget()
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          // Reference Photo

                          Container(
                            width: fullWidth,
                            padding: EdgeInsets.symmetric(
                                vertical: 20.r, horizontal: 30.r),
                            decoration: const BoxDecoration(
                              color: NewColors.black,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Reference Photo",
                                      style: TextStyle(
                                          fontSize: buildFontSize(30),
                                          color: NewColors.secondattextcolor),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.r,
                                ),
                                if (data.categoryItem!.referencePhotos
                                        ?.length !=
                                    0)
                                  SizedBox(
                                    width: fullWidth,
                                    height: 210.r,
                                    child: CarouselSlider.builder(
                                        itemCount: data.categoryItem!
                                            .referencePhotos!.length,
                                        disableGesture: false,
                                        itemBuilder:
                                            (context, index, realIndex) {
                                          String url = data
                                              .categoryItem!
                                              .referencePhotos![index]
                                              .photoUrl!;
                                          return Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(url))),
                                            width: 200.r,
                                            height: 200.r,
                                          );
                                        },
                                        options: CarouselOptions(
                                          viewportFraction: 1,
                                          enableInfiniteScroll: false,
                                          autoPlay: true,
                                        )),
                                  ),
                              ],
                            ),
                          ),
                          // Text
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 10.r,
                              horizontal: 30.r,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    data.categoryItem?.name ?? "",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: buildFontSize(30),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),

                          // Overall Grade == 0 then Show : Good, Not Good, Not Applicable
                          if (data.categoryItem?.overallGrade == 0)
                            Column(
                              children: [
                                // Status
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.r, horizontal: 30.r),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [],
                                      ),
                                      headingField(title: "Status"),
                                      SizedBox(
                                        height: 5.r,
                                      ),
                                      Wrap(
                                          children: List.generate(
                                              statusList.length, (index) {
                                        Map data = statusList[index];
                                        return Padding(
                                          padding: EdgeInsetsGeometry.symmetric(
                                              horizontal: 5.r, vertical: 5.r),
                                          child: StatusTab(
                                            value: selected,
                                            icon: data['icon'],
                                            onTap: () {
                                              selected = data['name'];
                                              body.addAll({
                                                "condition": data['value'],
                                              });
                                              setState(() {});
                                            },
                                            title: data['name'],
                                          ),
                                        );
                                      })),
                                    ],
                                  ),
                                ),

                                Form(
                                  key: formKey,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.r, horizontal: 30.r),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (selected != "Not Applicable" &&
                                            selected != "")
                                          CustomTextFields(
                                              label: "Remarks",
                                              controller: remark,
                                              validator:
                                                  Validators.validateRequired,
                                              hintText: "Enter Remark"),
                                        // On Select of Pass

                                        if (selected == "Pass")
                                          Column(
                                            children: [
                                              ListView.separated(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                separatorBuilder:
                                                    (context, index) =>
                                                        SizedBox(
                                                  height: aspectRatio * 10,
                                                ),
                                                itemCount:
                                                    data.goodPhotos?.length ??
                                                        0,
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  InspectionPhoto file =
                                                      data.goodPhotos![index];
                                                  return ImageWidget(
                                                    file: file,
                                                    inspectionProvider:
                                                        inspectionProvider,
                                                    type: "good",
                                                  );
                                                },
                                              ),
                                              SizedBox(
                                                height: 10.r,
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  if (data.goodPhotos?.length !=
                                                      10) {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const InspectionPhotoScreen())).then(
                                                        (value) {
                                                      if (value != null &&
                                                          value != "") {
                                                        Map<String, dynamic>
                                                            photoBody = {
                                                          "inspection_item_id":
                                                              data.id,
                                                          "type": "good",
                                                        };
                                                        log(photoBody
                                                            .toString());
                                                        inspectionProvider
                                                            .saveItemPhoto(
                                                                context,
                                                                inspectionId: data
                                                                    .inspectionId!,
                                                                body: photoBody,
                                                                file: [value]);
                                                        setState(() {});
                                                      }
                                                    });
                                                  }
                                                },
                                                child: const AddPhotoBtn(
                                                  title: "Add Photo",
                                                ),
                                              ),
                                            ],
                                          ),

                                        if (selected == "Fail")
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Condition Description
                                              const TitleWidget1(
                                                title: 'Condition Description',
                                              ),
                                              SizedBox(
                                                height: aspectRatio * 10,
                                              ),
                                              DropdownButtonFormField(
                                                  validator: (value) {
                                                    if (value == null ||
                                                        data.conditionDescription ==
                                                            "") {
                                                      return 'Please select Description';
                                                    }
                                                    return null;
                                                  },
                                                  icon: const Icon(
                                                    Icons
                                                        .arrow_drop_down_circle_sharp,
                                                    color: NewColors
                                                        .secondayFullcolor,
                                                  ),
                                                  dropdownColor:
                                                      NewColors.whitecolor,
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      borderSide: const BorderSide(
                                                          color: NewColors
                                                              .secondayFullcolor,
                                                          width: 2),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      borderSide:
                                                          const BorderSide(
                                                              color: NewColors
                                                                  .primary,
                                                              width: 2),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      borderSide: const BorderSide(
                                                          color: NewColors
                                                              .secondayFullcolor,
                                                          width: 2),
                                                    ),
                                                  ),
                                                  items:
                                                      issueTypeDataDropDownlistList,
                                                  hint: Text(data
                                                              .conditionDescription !=
                                                          null
                                                      ? data
                                                          .conditionDescription!
                                                      : "Select Condition Description"),
                                                  onChanged: (value) {
                                                    body.addAll({
                                                      "condition": "Not Good",
                                                      "condition_description":
                                                          value!.name!
                                                    });
                                                    setState(() {});
                                                  }),
                                              SizedBox(
                                                height: 5.r,
                                              ),
                                              const Divider(
                                                color:
                                                    NewColors.secondayFullcolor,
                                              ),
                                              if (data.beforePhotos?.isEmpty ==
                                                  true)
                                                const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "No Before Image Added",
                                                    ),
                                                  ],
                                                ),
                                              SizedBox(
                                                height: 5.r,
                                              ),
                                              if (data.beforePhotos?.isEmpty !=
                                                  true)
                                                ListView.separated(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  separatorBuilder:
                                                      (context, index) =>
                                                          SizedBox(
                                                    height: aspectRatio * 10,
                                                  ),
                                                  itemCount: data.beforePhotos
                                                          ?.length ??
                                                      0,
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, index) {
                                                    InspectionPhoto file = data
                                                        .beforePhotos![index];
                                                    return ImageWidget(
                                                      file: file,
                                                      inspectionProvider:
                                                          inspectionProvider,
                                                      type: "before",
                                                    );
                                                  },
                                                ),
                                              SizedBox(
                                                height: 5.r,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  if (data.beforePhotos
                                                          ?.length !=
                                                      10) {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const InspectionPhotoScreen())).then(
                                                        (value) {
                                                      if (value != null &&
                                                          value != "") {
                                                        Map<String, dynamic>
                                                            photoBody = {
                                                          "inspection_item_id":
                                                              data.id,
                                                          "type": "before",
                                                        };
                                                        log(photoBody
                                                            .toString());
                                                        inspectionProvider
                                                            .saveItemPhoto(
                                                                context,
                                                                inspectionId: data
                                                                    .inspectionId!,
                                                                body: photoBody,
                                                                file: [value]);
                                                        setState(() {});
                                                      }
                                                    });
                                                  }
                                                },
                                                child: const AddPhotoBtn(
                                                    title: "Add Before Photo"),
                                              ),
                                              // After Photo
                                              SizedBox(
                                                height: 5.r,
                                              ),
                                              const Divider(
                                                color: NewColors.secondaycolor,
                                              ),
                                              if (data.afterPhotos?.isEmpty ==
                                                  true)
                                                const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "No After Image Added",
                                                    ),
                                                  ],
                                                ),
                                              SizedBox(
                                                height: 5.r,
                                              ),
                                              if (data.afterPhotos?.isEmpty !=
                                                  true)
                                                ListView.separated(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  separatorBuilder:
                                                      (context, index) =>
                                                          SizedBox(
                                                    height: aspectRatio * 10,
                                                  ),
                                                  itemCount: data.afterPhotos
                                                          ?.length ??
                                                      0,
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, index) {
                                                    InspectionPhoto file = data
                                                        .afterPhotos![index];
                                                    return ImageWidget(
                                                      file: file,
                                                      inspectionProvider:
                                                          inspectionProvider,
                                                      type: "after",
                                                    );
                                                  },
                                                ),
                                              SizedBox(
                                                height: 5.r,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  if (data.afterPhotos
                                                          ?.length !=
                                                      10) {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const InspectionPhotoScreen())).then(
                                                        (value) {
                                                      if (value != null &&
                                                          value != "") {
                                                        Map<String, dynamic>
                                                            photoBody = {
                                                          "inspection_item_id":
                                                              data.id,
                                                          "type": "after",
                                                        };
                                                        log(photoBody
                                                            .toString());
                                                        inspectionProvider
                                                            .saveItemPhoto(
                                                                context,
                                                                inspectionId: data
                                                                    .inspectionId!,
                                                                body: photoBody,
                                                                file: [value]);
                                                        setState(() {});
                                                      }
                                                    });
                                                  }
                                                },
                                                child: const AddPhotoBtn(
                                                  title: "Add After Photo",
                                                ),
                                              )
                                            ],
                                          )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          // Overall Grade == 1 then Show : A, B, C
                          if (data.categoryItem?.overallGrade == 1)
                            Column(
                              children: [
                                // Options

                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15.r, horizontal: 30.r),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      headingField(title: "Select Grade"),
                                      SizedBox(
                                        height: 5.r,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: StatusTab(
                                              value: selected,
                                              icon: Container(
                                                width: 25.r,
                                                height: 25.r,
                                                decoration: const BoxDecoration(
                                                    color: NewColors.greencolor,
                                                    shape: BoxShape.circle),
                                                child: Center(
                                                    child: Text(
                                                  "A",
                                                  style: TextStyle(
                                                      fontSize:
                                                          buildFontSize(30),
                                                      color:
                                                          NewColors.whitecolor,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                              ),
                                              onTap: () {
                                                selected = "Very Clean";
                                                body.addAll(
                                                    {"overall_grade": "A"});
                                                setState(() {});
                                              },
                                              title: "Very Clean",
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: StatusTab(
                                              value: selected,
                                              icon: Container(
                                                width: 25.r,
                                                height: 25.r,
                                                decoration: const BoxDecoration(
                                                    color: NewColors.primary,
                                                    shape: BoxShape.circle),
                                                child: Center(
                                                    child: Text(
                                                  "B",
                                                  style: TextStyle(
                                                      fontSize:
                                                          buildFontSize(30),
                                                      color:
                                                          NewColors.whitecolor,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                              ),
                                              onTap: () {
                                                selected = "Meet Min Std";
                                                body.addAll(
                                                    {"overall_grade": "B"});
                                                setState(() {});
                                              },
                                              title: "Meet Min Std",
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.r,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: StatusTab(
                                              value: selected,
                                              icon: Container(
                                                width: 25.r,
                                                height: 25.r,
                                                decoration: const BoxDecoration(
                                                    color: NewColors.red,
                                                    shape: BoxShape.circle),
                                                child: Center(
                                                    child: Text(
                                                  "C",
                                                  style: TextStyle(
                                                      fontSize:
                                                          buildFontSize(30),
                                                      color:
                                                          NewColors.whitecolor,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                              ),
                                              onTap: () {
                                                selected = "Need Re-Cleaning";
                                                body.addAll(
                                                    {"overall_grade": "C"});

                                                setState(() {});
                                              },
                                              title: "Need Re-Cleaning",
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.r,
                                      ),
                                      Form(
                                        key: formKey,
                                        child: CustomTextFields(
                                            label: "Remarks",
                                            controller: remark,
                                            validator:
                                                Validators.validateRequired,
                                            hintText: "Enter Remark"),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
            ),
            if (inspectionProvider.loading) const FullPageLoadingWidget()
          ],
        ),
      );
    });
  }
}

class ImageWidget extends StatelessWidget {
  final InspectionProvider inspectionProvider;
  final String type;
  const ImageWidget({
    super.key,
    required this.inspectionProvider,
    required this.file,
    required this.type,
  });

  final InspectionPhoto file;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: NewColors.whitecolor,
          child: Center(
            child: Image.network(
              file.photoUrl!,
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
                    inspectionProvider.deleteItemPhoto(context,
                        type: type, photoId: file.id!);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: NewColors.whitecolor,
                  ))),
        ),
      ],
    );
  }
}

class AddPhotoBtn extends StatelessWidget {
  final String title;
  const AddPhotoBtn({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            title,
            style: TextStyle(
                fontWeight: boldFontWeight,
                color: NewColors.black,
                fontSize: buildFontSize(32)),
          ),
        ],
      ),
    );
  }
}

class StatusTab extends StatelessWidget {
  final String value;
  final Widget icon;
  final Function()? onTap;
  final String title;
  const StatusTab({
    super.key,
    required this.value,
    required this.icon,
    this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            border: Border.all(
              color: value == title
                  ? NewColors.primary
                  : NewColors.secondayFullcolor,
              width: 2,
            )),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            SizedBox(
              width: 10.r,
            ),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: buildFontSize(30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget headingField({required String title}) {
  return Text(
    title,
    style: TextStyle(
        fontSize: buildFontSize(30),
        color: NewColors.secondattextcolor,
        fontWeight: FontWeight.w500),
  );
}
