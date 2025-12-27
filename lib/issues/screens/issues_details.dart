// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fixlah/common/image_viewer.dart';

import 'package:fixlah/issues/screens/edit_issue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:fixlah/config/colors.dart';
import 'package:fixlah/config/constants.dart';
import 'package:fixlah/config/graphics.dart';
import 'package:fixlah/config/sizes.dart';
import 'package:fixlah/config/timer.dart';
import 'package:fixlah/config/utils.dart';
import 'package:fixlah/issues/model/issues_model.dart';
import 'package:fixlah/issues/provider/issues_provider.dart';
import 'package:fixlah/work%20order/model/work_order_model.dart';

class IssuesDetails extends StatefulWidget {
  const IssuesDetails({super.key});

  @override
  State<IssuesDetails> createState() => _IssuesDetailsState();
}

class _IssuesDetailsState extends State<IssuesDetails> {
  @override
  Widget build(BuildContext context) {
    return Consumer<IssuesProvider>(builder: (context, issuesProvider, child) {
      IssueData issueData = issuesProvider.selctedIssueId ?? IssueData();

      return Scaffold(
        backgroundColor: NewColors.secondaryBgColor,
        appBar: generalAppBar(
          context,
          title: "Issue Details",
          actions: [
            if (checkPermission(permit: "manage issues"))
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                          MaterialPageRoute(builder: (context) => EditIssue()))
                      .then((value) {
                    if (value == true) {
                      Navigator.pop(context, true);
                    }
                  });
                },
                icon: ImageIcon(
                  color: NewColors.whitecolor,
                  size: 20.r,
                  AssetImage(
                    Graphics.edit_icon,
                  ),
                ),
              ),
            if (checkPermission(permit: "delete issues"))
              IconButton(
                onPressed: () {
                  openDialogue(context,
                      data: SizedBox(
                        width: fullWidth - 100,
                        height: fullHeight / 5,
                        child: ConfirmationWidget(
                          title: "Are you Sure you want to delete ?",
                          onTapNo: () {
                            Navigator.pop(context);
                          },
                          onTapYes: () {
                            // delete api call
                            issuesProvider.deleteIssue(context,
                                issueId: issueData.id);
                            Navigator.pop(context);
                          },
                        ),
                      ));
                },
                icon: ImageIcon(
                  size: 25.r,
                  color: NewColors.whitecolor,
                  AssetImage(
                    Graphics.delete_icon,
                  ),
                ),
              ),
          ],
        ),
        body: ListView(
          padding: EdgeInsets.all(15.r),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    issueData.issueIdAuto!,
                    style: TextStyle(
                        fontSize: buildFontSize(30),
                        color: NewColors.black,
                        fontWeight: mediumFontWeight),
                  ),
                ),
                Expanded(
                  child: Text(
                    formateDate(value: issueData.createdAt!),
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
              height: aspectRatio * 40,
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
                      Expanded(
                        child: Column(
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
                      ),
                      Badge(
                        padding: EdgeInsets.symmetric(
                            vertical: 5.r, horizontal: 10.r),
                        backgroundColor: issueData.priority == "yes"
                            ? NewColors.red
                            : NewColors.greencolor,
                        label: Text(
                          issueData.priority == "yes" ? "URGENT" : "NOT URGENT",
                          style: TextStyle(
                              color: NewColors.whitecolor,
                              fontWeight: FontWeight.bold,
                              fontSize: buildFontSize(25)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: aspectRatio * 30,
            ),
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(
                height: 15,
              ),
              shrinkWrap: true,
              itemCount: issueData.items?.length ?? 0,
              itemBuilder: (context, index) {
                return IssueItemCard(
                  issueItem: issueData.items![index],
                  issueData: issueData,
                );
              },
            )
          ],
        ),
      );
    });
  }
}

class IssueItemCard extends StatelessWidget {
  final IssueItem issueItem;
  final IssueData issueData;
  const IssueItemCard({
    super.key,
    required this.issueItem,
    required this.issueData,
  });

  @override
  Widget build(BuildContext context) {
    List<Photos>? itemImages = [];
    for (var i = 0; i < issueData.photos!.length; i++) {
      issueData.photos?[i];
      if (issueItem.id == issueData.photos?[i].issueItemId) {
        itemImages.add(issueData.photos?[i] ?? Photos());
      }
    }

    return Column(
      children: [
        // TOP
        Stack(
          children: [
            SizedBox(
              width: fullWidth,
              height: 210.r,
              child: CarouselSlider.builder(
                  itemCount: itemImages.length,
                  disableGesture: false,
                  itemBuilder: (context, index, realIndex) {
                    String url =
                        "${AppConstants.issuesImageBaseUrl}${itemImages[index].photoPath}";
                    return GestureDetector(
                      onTap: () {
                        // print("object");
                        naviagteTo(context,
                            builder: (context) => ImageViewer(
                                  baseUrl: AppConstants.issuesImageBaseUrl,
                                  index: index,
                                  itemImages: itemImages,
                                ));
                      },
                      child: Container(
                        width: fullWidth,
                        height: 180.r,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(url),
                          ),
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    viewportFraction: 1,
                    enableInfiniteScroll: false,
                    autoPlay: true,
                  )),
            ),
            Container(
              width: fullWidth,
              height: 180.r,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [],
                    ),
                    Badge(
                      backgroundColor: NewColors.transperent,
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10.r),
                      label: Text(
                        timeAgoSinceDate(
                            passdate: DateTime.parse(issueData.createdAt!)),
                        style: TextStyle(
                            fontWeight: mediumFontWeight,
                            color: NewColors.whitecolor,
                            fontSize: buildFontSize(25)),
                      ),
                    ),
                    SizedBox(
                      height: 10.r,
                    ),
                    Badge(
                      backgroundColor: issueData.creamUnit == 0
                          ? Colors.red
                          : NewColors.greencolor,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      label: Text(
                        issueData.creamUnit == 0 ? "NON-CREAM" : "CREAM",
                        style: TextStyle(
                            fontWeight: mediumFontWeight,
                            color: NewColors.whitecolor,
                            fontSize: buildFontSize(25)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
              color: NewColors.whitecolor,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8))),
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
                          issueData.issueType ?? "-",
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Issue Type",
                          style: TextStyle(
                              color: NewColors.secondattextcolor,
                              fontSize: buildFontSize(25)),
                        ),
                        Text(
                          issueItem.issueType ?? "-",
                          style: TextStyle(
                              color: NewColors.black,
                              fontWeight: mediumFontWeight,
                              fontSize: buildFontSize(30)),
                        ),
                      ],
                    ),
                  ),
                  const Column(
                    children: [],
                  )
                ],
              ),
              Divider(
                height: 20.r,
                color: NewColors.secondaycolor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Issue Item",
                          style: TextStyle(
                              color: NewColors.secondattextcolor,
                              fontSize: buildFontSize(25)),
                        ),
                        Text(
                          issueItem.item ?? "-",
                          style: TextStyle(
                              color: NewColors.red,
                              fontWeight: mediumFontWeight,
                              fontSize: buildFontSize(30)),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Location",
                          style: TextStyle(
                              color: NewColors.secondattextcolor,
                              fontSize: buildFontSize(25)),
                        ),
                        Text(
                          issueData.unit?.unitNo == null
                              ? "-"
                              : areaListResponse!.data!
                                      .where(
                                          (data) => data.id == issueItem.areaId)
                                      .first
                                      .name ??
                                  "-",
                          style: TextStyle(
                              color: NewColors.black,
                              fontWeight: mediumFontWeight,
                              fontSize: buildFontSize(30)),
                        ),
                      ],
                    ),
                  ),
                  const Column(
                    children: [],
                  )
                ],
              ),
              Divider(
                height: 20.r,
                color: NewColors.secondaycolor,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Additional Remarks",
                    style: TextStyle(
                        color: NewColors.secondattextcolor,
                        fontSize: buildFontSize(25)),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          issueItem.remarks ?? "-",
                          style: TextStyle(
                              color: NewColors.black,
                              fontWeight: mediumFontWeight,
                              fontSize: buildFontSize(30)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
