import 'dart:developer';

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
import 'package:fixlah/issues/screens/edit_issue_create.dart';
import 'package:fixlah/issues/screens/unit_issue_3.dart';
import 'package:fixlah/work%20order/model/work_order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                              // edit save api call
                              log(editData["items[0]issue_type][]"].toString());
                              issuesProvider.editIssue(context,
                                  issueId: issueData.id.toString(),
                                  body: editData);

                              Navigator.pop(context);
                            },
                          ),
                        ));
                  },
                  icon: Icon(
                    color: NewColors.whitecolor,
                    Icons.done,
                    size: 25.r,
                  ),
                ),
              ],
            ),
            body: ListView(
              padding: EdgeInsets.all(15.r),
              children: [
                // Issue Details Start
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
                              style:
                                  const TextStyle(color: NewColors.whitecolor),
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
                    final IssueItem issueItem = issueData.items![index];

                    List<Photos>? images = [];
                    for (var i = 0; i < issueData.photos!.length; i++) {
                      if (editData["items[$index][id]"] ==
                          issueData.photos![i].issueItemId) {
                        images.add(issueData.photos![i]);
                      }
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                        title:
                                            "Are you Sure you want to delete this Item ?",
                                        onTapNo: () {
                                          Navigator.pop(context);
                                        },
                                        onTapYes: () {
                                          // delete api call
                                          issuesProvider.deleteIssueItem(
                                              context,
                                              issueId: issueData.id.toString(),
                                              itemId: issueItem.id.toString());
                                          itemCount--;
                                          setState(() {});
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

                        // Item Image
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: images.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Image.network(
                                    "${AppConstants.issuesImageBaseUrl}${images[index].photoPath}"),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                      alignment: AlignmentGeometry.topRight,
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
                                                            id: images[index]
                                                                .id
                                                                .toString());
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  NewColors.secondaryBgColor),
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
                        SizedBox(
                          height: 10.r,
                        ),
                        if (images.length < 5)
                          InkWell(
                            onTap: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CameraCaptureScreen(
                                            goBack: true,
                                            addImage: true,
                                            index: index,
                                          )));
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
                              print(value);
                              editData.addAll({
                                "items[$index][item]": value,
                              });
                              setState(() {});
                            },
                            label: "Issue Item",
                            validator: Validators.validateRequired,
                            initialValue: issueItem.item,
                            hintText: "Enter Issue Item"),
                        SizedBox(
                          height: 10.r,
                        ),
                        // Area

                        TextFieldTitle(label: "Unit Location"),
                        SizedBox(
                          height: 10.r,
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: areaListResponse!.total,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 2.5,
                                  crossAxisCount: 3),
                          itemBuilder: (context, unitIndex) {
                            AreaData unitLocationData =
                                areaListResponse!.data![unitIndex];
                            String selctedUnitLocation = areaListResponse?.data
                                    ?.firstWhere((data) =>
                                        data.id.toString() ==
                                        editData["items[$index][area_id]"]
                                            .toString())
                                    .name ??
                                "";
                            return InkWell(
                              onTap: () {
                                selctedUnitLocation =
                                    unitLocationData.name ?? "-";
                                editData.addAll({
                                  "items[$index][area_id]":
                                      unitLocationData.id.toString(),
                                });

                                setState(() {});
                              },
                              child: Container(
                                padding: EdgeInsets.all(5.r),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: unitLocationData.name ==
                                            selctedUnitLocation
                                        ? NewColors.primary
                                        : NewColors.secondaycolor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(100),
                                  color: NewColors.whitecolor,
                                ),
                                child: Center(
                                  child: Text(
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                    unitLocationData.name ?? "-",
                                    style: TextStyle(
                                        color: NewColors.black,
                                        fontSize: buildFontSize(25)),
                                  ),
                                ),
                              ),
                            );
                          },
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
                            hint: Text(
                              "${editData["items[$index][issue_type][]"] ?? "-"}",
                              style: TextStyle(fontSize: buildFontSize(25)),
                            ),
                            onChanged: (value) {
                              editData.addAll(
                                  {"items[$index][issue_type][]": value?.name});
                              print(editData["items[$index][issue_type][]"]);

                              setState(() {});
                            }),
                        // Issue Item
                        // SizedBox(
                        //   height: 10.r,
                        // ),
                        // CustomTextFields(
                        //   label: "Issue Item",
                        //   hintText: "Issue Item",
                        //   validator: Validators.validateRequired,
                        // )
                        // CustomTextFields(
                        //     label: "Issue Item",
                        //     readOnly: true,
                        //     onTap: () {
                        //       if (issuesProvider.itemAssetsResponse !=
                        //           ItemAssetsResponse()) {
                        //         openDialogue(context,
                        //             title: "Select Issue Item",
                        //             data: SizedBox(
                        //               width: fullWidth - 100,
                        //               height: fullHeight / 2,
                        //               child: ListView.builder(
                        //                 itemCount: issuesProvider
                        //                         .itemAssetsResponse
                        //                         .data
                        //                         ?.length ??
                        //                     0,
                        //                 itemBuilder:
                        //                     (context, issueItemindex) {
                        //                   IssueItemData issueItemData =
                        //                       issuesProvider
                        //                           .itemAssetsResponse
                        //                           .data![issueItemindex];
                        //                   return ListTile(
                        //                     onTap: () {
                        //                       // issueItem.text = issueItemData.name!;
                        //                       editData.addAll({
                        //                         "items[$index][assets_id]":
                        //                             issueItemData.id
                        //                                 .toString(),
                        //                         "items[$index][quantity]":
                        //                             1.toString(),
                        //                         "items[$index][charge]":
                        //                             issueItemData
                        //                                 .sellingPrice
                        //                                 .toString(),
                        //                       });
                        //                       issuesProvider
                        //                           .createIssueDataController({
                        //                         editData[
                        //                                 "items[$index][quantity]"]:
                        //                             1.toString(),
                        //                         editData[
                        //                                 "items[$index][charge]"]:
                        //                             issueItemData
                        //                                 .sellingPrice,
                        //                       });
                        //                       setState(() {});
                        //                       Navigator.pop(context);
                        //                     },
                        //                     title: Text(
                        //                         issueItemData.name ?? ""),
                        //                   );
                        //                 },
                        //               ),
                        //             ));
                        //       }
                        //     },
                        //     initialValue: issuesProvider
                        //             .itemAssetsResponse.data
                        //             ?.firstWhere((data) =>
                        //                 data.id == issueItem.assetId)
                        //             .name ??
                        //         "",
                        //     hintText: "Issue Item"),
                        SizedBox(
                          height: 10.r,
                        ),
                      ],
                    );
                  },
                ),
                InkWell(
                  onTap: () async {
                    issuesProvider.resset();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditIssueCreate(
                                  issueId: issueData.id.toString(),
                                  index: itemCount,
                                ))).then((value) {
                      if (value == true) {
                        Navigator.pop(context, true);
                      }
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
                          "Add Item",
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
          if (loading || issuesProvider.loading) FullPageLoadingWidget(),
        ],
      );
    });
  }
}
