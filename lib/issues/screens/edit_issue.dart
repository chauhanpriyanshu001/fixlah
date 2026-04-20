import 'dart:developer';
import 'dart:io';

import 'package:fixlah/config/colors.dart';
import 'package:fixlah/config/constants.dart';
import 'package:fixlah/config/graphics.dart';
import 'package:fixlah/config/sizes.dart';
import 'package:fixlah/config/text_fields.dart';
import 'package:fixlah/config/utils.dart';
import 'package:fixlah/config/validators.dart';
import 'package:fixlah/home/model/area_response_model.dart';
import 'package:fixlah/home/model/issue_type_data.dart';

import 'package:fixlah/issues/model/issues_model.dart';
import 'package:fixlah/issues/provider/issues_provider.dart';

import 'package:fixlah/issues/screens/unit_issue_3.dart';
import 'package:fixlah/work%20order/model/work_order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class EditIssue extends StatefulWidget {
  const EditIssue({super.key});

  @override
  State<EditIssue> createState() => _EditIssueState();
}

class _EditIssueState extends State<EditIssue> {
  IssueTypeData? issueType;
  bool loading = false;
  Map<String, dynamic> editData = {};
  int itemCount = 0;
  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loading = true;
    setState(() {});
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      IssuesProvider issuesProvider = Provider.of<IssuesProvider>(
        context,
        listen: false,
      );
      IssueData issueData = issuesProvider.selctedIssueId ?? IssueData();
      editData = {
        "facility_id": issueData.facilityId,
        "facility_block_id": issueData.facilityBlockId,
        "facility_unit_id":
            issueData.facilityUnitId == null ? "" : issueData.facilityUnitId,
        "issue_type": issueData.issueType,
        "priority": issueData.priority,
        "client_id": issueData.client?.id,
        "location_tag_id": issueData.locationTagId ?? "",
        "cream_unit": issueData.creamUnit,
        "issue_raised_by": "Dorm Ops",
      };
      // get assets
      await issuesProvider.getAssets(context,
          facilityId: issueData.facilityId.toString());
      itemCount = issueData.items!.length;
      setState(() {});
      for (var i = 0; i < itemCount; i++) {
        final IssueItem issueItem = issueData.items![i];
        Map<String, dynamic> item = {
          "items[$i][id]": issueItem.id,
          "items[$i][item]": issueItem.item,
          "items[$i][area_id]": issueItem.areaId,
          "items[$i][issue_type][]": issueItem.issueType,
          "items[$i][quantity]": issueItem.quantity,
          "items[$i][charge]": issueItem.charge,
          "items[$i][remarks]": issueItem.remarks,
          "items[$i][done_by]": issueItem.doneBy,
          "items[$i][photos][]": <String>[],
        };
        editData.addAll(item);
        setState(() {});
      }
      log(editData.toString());
      loading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<IssuesProvider>(builder: (context, issuesProvider, child) {
      IssueData issueData = issuesProvider.selctedIssueId ?? IssueData();
      return Stack(
        children: [
          Scaffold(
            backgroundColor: NewColors.secondaryBgColor,
            appBar: generalAppBar(
              context,
              title: "Edit Issue",
              actions: [
                IconButton(
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      for (int i = 0; i < itemCount; i++) {
                        bool isNewItem = editData["items[$i][id]"] == null;
                        if (isNewItem) {
                          var photos = editData["items[$i][photos][]"];
                          if (photos == null || (photos as List).isEmpty) {
                            Fluttertoast.showToast(
                                msg:
                                    "Please add at least one photo for newly added Item ${i + 1}",
                                backgroundColor: NewColors.red,
                                textColor: NewColors.whitecolor);
                            return;
                          }
                        }
                      }
                      openDialogue(context,
                          data: SizedBox(
                            width: fullWidth - 100,
                            height: fullHeight / 5,
                            child: ConfirmationWidget(
                              title:
                                  "Are you Sure you want to save the changes ?",
                              onTapNo: () {
                                Navigator.pop(context);
                              },
                              onTapYes: () {
                                Map<String, dynamic> finalData =
                                    Map.from(editData);
                                for (var i = 0; i < itemCount; i++) {
                                  if (finalData["items[$i][photos][]"] !=
                                          null &&
                                      (finalData["items[$i][photos][]"] as List)
                                          .isEmpty) {
                                    finalData.remove("items[$i][photos][]");
                                  }
                                }
                                issuesProvider.editIssue(context,
                                    issueId: issueData.id.toString(),
                                    itemCount: itemCount,
                                    body: finalData);

                                Navigator.pop(context);
                              },
                            ),
                          ));
                    }
                  },
                  icon: Icon(
                    color: NewColors.whitecolor,
                    Icons.done,
                    size: 25.r,
                  ),
                ),
              ],
            ),
            body: Form(
              key: _key,
              child: ListView(
                padding: EdgeInsets.all(15.r),
                children: [
                  // Issue Header Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          issueData.issueIdAuto ?? "-",
                          style: TextStyle(
                              fontSize: buildFontSize(30),
                              color: NewColors.black,
                              fontWeight: mediumFontWeight),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          formateDate(value: issueData.createdAt ?? "") ?? "",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: buildFontSize(30),
                            color: NewColors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                text: issueData.createdBy!.name ?? "",
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
                          formateTime(value: issueData.createdAt!),
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: buildFontSize(25),
                            color: NewColors.secondattextcolor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.r,
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: NewColors.whitecolor,
                        borderRadius: BorderRadius.circular(8)),
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
                                    "Facility",
                                    style: TextStyle(
                                        color: NewColors.secondattextcolor,
                                        fontSize: buildFontSize(25)),
                                  ),
                                  Text(
                                    issueData.facility!.name!,
                                    style: TextStyle(
                                        color: NewColors.black,
                                        fontWeight: mediumFontWeight,
                                        fontSize: buildFontSize(30)),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Block",
                                    style: TextStyle(
                                        color: NewColors.secondattextcolor,
                                        fontSize: buildFontSize(25)),
                                  ),
                                  Text(
                                    issueData.block!.name!,
                                    style: TextStyle(
                                        color: NewColors.black,
                                        fontWeight: mediumFontWeight,
                                        fontSize: buildFontSize(30)),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Unit No",
                                    style: TextStyle(
                                        color: NewColors.secondattextcolor,
                                        fontSize: buildFontSize(25)),
                                  ),
                                  Text(
                                    issueData.unit?.unitNo ?? "-",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: NewColors.black,
                                        fontWeight: mediumFontWeight,
                                        fontSize: buildFontSize(30)),
                                  ),
                                ],
                              ),
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
                                  "Client Name",
                                  style: TextStyle(
                                      color: NewColors.secondattextcolor,
                                      fontSize: buildFontSize(25)),
                                ),
                                Text(
                                  issueData.client?.name ?? "-",
                                  style: TextStyle(
                                      color: NewColors.black,
                                      fontWeight: mediumFontWeight,
                                      fontSize: buildFontSize(30)),
                                ),
                              ],
                            ),
                            Badge(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              backgroundColor: NewColors.red,
                              label: Text(
                                issueData.status ?? "-",
                                style: const TextStyle(
                                    color: NewColors.whitecolor),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Issue Details End
                  SizedBox(
                    height: 10.r,
                  ),

                  // Items
                  ListView.builder(
                    itemCount: itemCount,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      bool isExisting = index < (issueData.items?.length ?? 0);
                      final IssueItem? issueItem =
                          isExisting ? issueData.items![index] : null;

                      List<Photos> existingPhotos = [];
                      if (isExisting) {
                        for (var i = 0; i < issueData.photos!.length; i++) {
                          if (issueItem?.id ==
                              issueData.photos![i].issueItemId) {
                            existingPhotos.add(issueData.photos![i]);
                          }
                        }
                      }

                      List localPhotos =
                          editData["items[$index][photos][]"] ?? [];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(
                            color: NewColors.secondayFullcolor,
                          ),
                          // Title and delete icon
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Item: ${index + 1}",
                                style: TextStyle(
                                  color: NewColors.black,
                                  fontSize: buildFontSize(30),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  openDialogue(context,
                                      data: SizedBox(
                                        width: fullWidth - 100,
                                        height: fullHeight / 5,
                                        child: ConfirmationWidget(
                                          title: isExisting
                                              ? "Are you Sure you want to delete this Item ?"
                                              : "Remove this newly added item?",
                                          onTapNo: () {
                                            Navigator.pop(context);
                                          },
                                          onTapYes: () {
                                            if (isExisting) {
                                              // delete api call
                                              issuesProvider.deleteIssueItem(
                                                  context,
                                                  issueId:
                                                      issueData.id.toString(),
                                                  itemId:
                                                      issueItem!.id.toString());
                                            }
                                            // Shift following items in state
                                            setState(() {
                                              for (int i = index;
                                                  i < itemCount - 1;
                                                  i++) {
                                                editData["items[$i][id]"] =
                                                    editData[
                                                        "items[${i + 1}][id]"];
                                                editData["items[$i][item]"] =
                                                    editData[
                                                        "items[${i + 1}][item]"];
                                                editData["items[$i][remarks]"] =
                                                    editData[
                                                        "items[${i + 1}][remarks]"];
                                                editData["items[$i][area_id]"] =
                                                    editData[
                                                        "items[${i + 1}][area_id]"];
                                                editData[
                                                        "items[$i][issue_type][]"] =
                                                    editData[
                                                        "items[${i + 1}][issue_type][]"];
                                                editData[
                                                        "items[$i][photos][]"] =
                                                    editData[
                                                        "items[${i + 1}][photos][]"];
                                                editData["items[$i][done_by]"] =
                                                    editData[
                                                        "items[${i + 1}][done_by]"];
                                                editData[
                                                        "items[$i][quantity]"] =
                                                    editData[
                                                        "items[${i + 1}][quantity]"];
                                                editData["items[$i][charge]"] =
                                                    editData[
                                                        "items[${i + 1}][charge]"];
                                              }

                                              // Remove last index data
                                              int lastIndex = itemCount - 1;
                                              editData.remove(
                                                  "items[$lastIndex][id]");
                                              editData.remove(
                                                  "items[$lastIndex][item]");
                                              editData.remove(
                                                  "items[$lastIndex][remarks]");
                                              editData.remove(
                                                  "items[$lastIndex][area_id]");
                                              editData.remove(
                                                  "items[$lastIndex][issue_type][]");
                                              editData.remove(
                                                  "items[$lastIndex][photos][]");
                                              editData.remove(
                                                  "items[$lastIndex][done_by]");
                                              editData.remove(
                                                  "items[$lastIndex][quantity]");
                                              editData.remove(
                                                  "items[$lastIndex][charge]");

                                              itemCount--;
                                            });
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ));
                                },
                                icon: ImageIcon(
                                  size: 25.r,
                                  color: NewColors.red,
                                  AssetImage(
                                    Graphics.delete_icon,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10.r,
                          ),

                          // Item Existing Images
                          if (isExisting && existingPhotos.isNotEmpty)
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: existingPhotos.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 9 / 16,
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10),
                              itemBuilder: (context, photoIndex) {
                                return Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.r),
                                      child: Image.network(
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                          "${AppConstants.issuesImageBaseUrl}${existingPhotos[photoIndex].photoPath}"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Align(
                                          alignment: Alignment.topRight,
                                          child: InkWell(
                                            onTap: () {
                                              openDialogue(context,
                                                  data: SizedBox(
                                                    width: fullWidth - 100,
                                                    height: fullHeight / 5,
                                                    child: ConfirmationWidget(
                                                      title:
                                                          "Are you Sure you want to delete this Image ?",
                                                      onTapNo: () {
                                                        Navigator.pop(context);
                                                      },
                                                      onTapYes: () {
                                                        // delete api call
                                                        issuesProvider
                                                            .deleteIssueItemPhoto(
                                                                context,
                                                                id: existingPhotos[
                                                                        photoIndex]
                                                                    .id
                                                                    .toString());
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ));
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(4.r),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: NewColors
                                                      .secondaryBgColor),
                                              child: Icon(
                                                  size: 15.r,
                                                  color: NewColors.red,
                                                  Icons.delete),
                                            ),
                                          )),
                                    )
                                  ],
                                );
                              },
                            ),

                          // Local Photos (Newly added images)
                          if (localPhotos.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.r),
                              child: Wrap(
                                children: List.generate(localPhotos.length,
                                    (photoIndex) {
                                  return Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Stack(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(5),
                                          width: 100.r,
                                          height: 150.r,
                                          decoration: BoxDecoration(
                                              color: NewColors.secondaryBgColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Image.file(
                                              fit: BoxFit.cover,
                                              File(localPhotos[photoIndex])),
                                        ),
                                        Positioned(
                                          top: 5,
                                          right: 5,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: NewColors.whitecolor),
                                            child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    localPhotos
                                                        .removeAt(photoIndex);
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  size: 15.r,
                                                  color: NewColors.red,
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                              ),
                            ),

                          SizedBox(
                            height: 10.r,
                          ),
                          // Add Photos Button
                          if ((existingPhotos.length + localPhotos.length) < 5)
                            InkWell(
                              onTap: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CameraCaptureScreen(
                                              goBack: true,
                                            ))).then((val) {
                                  if (val != null && val is File) {
                                    setState(() {
                                      if (editData["items[$index][photos][]"] ==
                                          null) {
                                        editData["items[$index][photos][]"] = [
                                          val.path
                                        ];
                                      } else {
                                        editData["items[$index][photos][]"]
                                            .add(val.path);
                                      }
                                    });
                                  }
                                });
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
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
                                      "Add Photos",
                                      style: TextStyle(
                                          fontWeight: boldFontWeight,
                                          color: NewColors.black,
                                          fontSize: buildFontSize(32)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          SizedBox(
                            height: 10.r,
                          ),
                          // Issue name
                          CustomTextFields(
                              onChanged: (value) {
                                editData.addAll({
                                  "items[$index][item]": value,
                                });
                                setState(() {});
                              },
                              label: "Issue Item",
                              validator: Validators.validateRequired,
                              initialValue: isExisting
                                  ? issueItem?.item
                                  : editData["items[$index][item]"],
                              hintText: "Enter Issue Item"),
                          SizedBox(
                            height: 10.r,
                          ),
                          CustomTextFields(
                              onChanged: (value) {
                                editData.addAll({
                                  "items[$index][remarks]": value,
                                });
                                setState(() {});
                              },
                              label: "Issue Remarks",
                              validator: Validators.validateRequired,
                              initialValue: isExisting
                                  ? issueItem?.remarks
                                  : editData["items[$index][remarks]"],
                              hintText: "Enter Issue Remarks"),
                          SizedBox(
                            height: 10.r,
                          ),
                          // Area

                          TextFieldTitle(label: "Unit Location"),
                          SizedBox(
                            height: 10.r,
                          ),
                          Wrap(
                            children: List.generate(areaListResponse!.total!,
                                (unitIndex) {
                              AreaData unitLocationData =
                                  areaListResponse!.data![unitIndex];
                              return Padding(
                                padding: EdgeInsets.all(5.r),
                                child: FilterChip(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.r, horizontal: 10.r),
                                  color: const WidgetStatePropertyAll(
                                      NewColors.whitecolor),
                                  side: BorderSide(
                                    width: 2,
                                    color: unitLocationData.id.toString() ==
                                            editData["items[$index][area_id]"]
                                                .toString()
                                        ? NewColors.primary
                                        : NewColors.secondaycolor,
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(60),
                                      side: BorderSide(
                                        color: unitLocationData.id.toString() ==
                                                editData[
                                                        "items[$index][area_id]"]
                                                    .toString()
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
                                    setState(() {
                                      editData.addAll({
                                        "items[$index][area_id]":
                                            unitLocationData.id.toString(),
                                      });
                                    });
                                  },
                                ),
                              );
                            }),
                          ),

                          SizedBox(
                            height: 10.r,
                          ),
                          //  Issue Type
                          const TitleWidget1(
                            title: 'Issue Type',
                          ),
                          SizedBox(
                            height: 10.r,
                          ),
                          DropdownButtonFormField(
                              icon: Icon(
                                Icons.arrow_drop_down_circle_sharp,
                                size: 20.r,
                                color: NewColors.secondaycolor,
                              ),
                              style: TextStyle(
                                  fontSize: buildFontSize(30),
                                  color: NewColors.black),
                              dropdownColor: NewColors.whitecolor,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 18.r, horizontal: 15.r),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  borderSide: const BorderSide(
                                      color: NewColors.secondaycolor, width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  borderSide: const BorderSide(
                                      color: NewColors.primary, width: 2),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  borderSide: const BorderSide(
                                      color: NewColors.secondaycolor, width: 2),
                                ),
                              ),
                              items: issueTypeDataDropDownlistList,
                              validator: (value) {
                                if (editData["items[$index][issue_type][]"] ==
                                        null ||
                                    editData["items[$index][issue_type][]"] ==
                                        "") {
                                  return "Select Issue Type";
                                }
                                return null;
                              },
                              hint: Text(
                                "${editData["items[$index][issue_type][]"] ?? "Select Issue Type"}",
                                style: TextStyle(fontSize: buildFontSize(25)),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  editData.addAll({
                                    "items[$index][issue_type][]": value?.name
                                  });
                                });
                              }),
                          SizedBox(
                            height: 20.r,
                          ),
                        ],
                      );
                    },
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        int index = itemCount;
                        editData.addAll({
                          "items[$index][done_by]": "dormetry",
                          "items[$index][item]": "",
                          "items[$index][remarks]": "",
                          "items[$index][area_id]": "",
                          "items[$index][issue_type][]": "",
                          "items[$index][photos][]": <String>[],
                          "items[$index][quantity]": "1",
                          "items[$index][charge]": "0",
                        });
                        itemCount++;
                      });
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
                            Graphics.issue_icon,
                            width: aspectRatio * 50,
                          ),
                          SizedBox(
                            width: aspectRatio * 30,
                          ),
                          Text(
                            "Add Item +",
                            style: TextStyle(
                                fontWeight: boldFontWeight,
                                color: NewColors.black,
                                fontSize: buildFontSize(32)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.r,
                  ),
                ],
              ),
            ),
          ),
          if (loading || issuesProvider.loading) FullPageLoadingWidget(),
        ],
      );
    });
  }
}
