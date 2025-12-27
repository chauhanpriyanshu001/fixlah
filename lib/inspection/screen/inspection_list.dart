// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fixlah/config/constants.dart';
import 'package:fixlah/config/custom_widgets.dart';
import 'package:fixlah/inspection/screen/inspection_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:fixlah/config/colors.dart';
import 'package:fixlah/config/sizes.dart';
import 'package:fixlah/config/text_fields.dart';
import 'package:fixlah/config/utils.dart';
import 'package:fixlah/inspection/model/inspection_response_model.dart';
import 'package:fixlah/inspection/model/inspection_toRun_model.dart';
import 'package:fixlah/inspection/provider/inspection_provider.dart';
import 'package:fixlah/issues/screens/issues_home_screen.dart';

class InspectionList extends StatefulWidget {
  const InspectionList({super.key});

  @override
  State<InspectionList> createState() => _InspectionListState();
}

class _InspectionListState extends State<InspectionList> {
  final ScrollController _scrollController = ScrollController();
  TextEditingController controller = TextEditingController();
  String selectedAreaFilter = "Unit Inspections";
  List filterList = [
    "Unit Inspections",
    "Unit Audit Inspections",
    "Common Area Inspections",
    "Common Area Audit Inspections",
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        InspectionProvider inspectionProvider = Provider.of<InspectionProvider>(
          context,
          listen: false,
        );
        String selectedFilter = inspectionProvider.tabStatus;
        if (selectedFilter == "In Progress") {
          if (inspectionProvider.inspectionResponse.data?.data?.length
                  .toString() !=
              inspectionProvider.inspectionResponse.data?.total!.toString()) {
            inspectionProvider.getMoreData(context);
          }
        }
        if (selectedFilter == "To Run") {
          if (inspectionProvider.inspectionToRunResponse.data?.data?.length
                  .toString() !=
              inspectionProvider.inspectionToRunResponse.data?.total!
                  .toString()) {
            inspectionProvider.getMoreData(context);
          }
        }
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<InspectionProvider>(
        context,
        listen: false,
      ).getData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NewColors.secondaryBgColor,
      appBar: generalAppBar(context,
          title: "Inspections",
          newColor: NewColors.inspectionscolor,
          actions: [
            FilterIcon(
              onPressed: () {
                naviagteTo(context, builder: (context) => InspectionFilter());
              },
            )
          ]),
      body: Consumer<InspectionProvider>(
        builder: (context, inspectionProvider, child) {
          String selectedFilter = inspectionProvider.tabStatus;
          return ListView(
            controller: _scrollController,
            children: [
              Container(
                padding: EdgeInsets.all(aspectRatio * 30),
                color: NewColors.inspectionscolor,
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizedBox(
                            width: DeviceUtils.isTablet() ? 180.r : 120.r,
                            child: FilterTab(
                              onTap: () {
                                inspectionProvider.selectTab(context,
                                    newtabStatus: "In Progress");
                              },
                              title: "In Progress",
                              filter: selectedFilter,
                              count: inspectionProvider.inProgressCount,
                              status: '',
                            ),
                          ),
                          SizedBox(
                            width: DeviceUtils.isTablet() ? 180.r : 150.r,
                            child: FilterTab(
                              onTap: () {
                                inspectionProvider.selectTab(context,
                                    newtabStatus: "2nd Inspection");
                              },
                              title: "2nd Inspection",
                              filter: selectedFilter,
                              count: inspectionProvider.InspectionCount,
                              status: '',
                            ),
                          ),
                          SizedBox(
                            width: DeviceUtils.isTablet() ? 100.r : 85.r,
                            child: FilterTab(
                              onTap: () {
                                inspectionProvider.selectTab(context,
                                    newtabStatus: "To Run");
                              },
                              title: "To Run",
                              filter: selectedFilter,
                              count: 0,
                              status: '',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: aspectRatio * 10,
                    ),
                    // Search
                    SearchField(
                      title: 'Inspector, Inspection Name & Unit #',
                      onFieldSubmitted: (value) {
                        inspectionProvider.makeSearch(context,
                            searchQuery: value);
                      },
                      searchText: controller,
                      onPressed: () {
                        inspectionProvider.makeSearch(context,
                            searchQuery: controller.text);
                        closekeyboard();
                      },
                    )
                  ],
                ),
              ),
              // Loading
              if (inspectionProvider.loading) LoadinWidget(),
              // In Progress
              if (selectedFilter == "In Progress" &&
                  inspectionProvider.loading == false)
                ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(
                    height: aspectRatio * 20,
                  ),
                  padding: EdgeInsets.all(aspectRatio * 30),
                  itemCount: inspectionProvider
                          .inspectionResponse.data?.data?.length ??
                      0,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    InspectionData inspectionData = inspectionProvider
                        .inspectionResponse.data!.data![index];
                    return InProgress(
                      inspectionData: inspectionData,
                      onTap: () {
                        inspectionProvider.selectInspection(context,
                            id: inspectionData.id.toString());
                      },
                    );
                  },
                ),
              // 2nd Inspection
              if (selectedFilter == "2nd Inspection" &&
                  inspectionProvider.loading == false)
                ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(
                    height: aspectRatio * 20,
                  ),
                  padding: EdgeInsets.all(aspectRatio * 30),
                  itemCount: inspectionProvider
                          .inspectionResponse.data?.data?.length ??
                      0,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    InspectionData inspectionData = inspectionProvider
                        .inspectionResponse.data!.data![index];
                    return InProgress(
                      inspectionData: inspectionData,
                      onTap: () {
                        inspectionProvider.selectInspection(context,
                            id: inspectionData.id.toString());
                      },
                    );
                  },
                ),
              // Unit Specific Filter
              if (selectedFilter == "To Run" &&
                  inspectionProvider.loading == false)
                GridView.builder(
                  itemCount: filterList.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      crossAxisCount: 2),
                  padding: EdgeInsets.all(aspectRatio * 30),
                  itemBuilder: (context, index) {
                    String filterListData = filterList[index];
                    bool selected =
                        filterListData == inspectionProvider.unitSpecific;
                    return InkWell(
                      onTap: () {
                        inspectionProvider.selectUnitSpecific(context,
                            selectedValue: filterListData);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10.r),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: selected
                                ? NewColors.inspectionscolor
                                : NewColors.secondaycolor,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            filterListData,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: selected
                                  ? NewColors.inspectionscolor
                                  : NewColors.black,
                              fontSize: buildFontSize(35),
                              fontWeight: boldFontWeight,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              if (selectedFilter == "To Run" &&
                  inspectionProvider.loading == false)
                ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(
                    height: aspectRatio * 20,
                  ),
                  padding: EdgeInsets.all(aspectRatio * 30),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: inspectionProvider
                          .inspectionToRunResponse.data?.data?.length ??
                      0,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    InspectionDataItem inspectionDataItem = inspectionProvider
                        .inspectionToRunResponse.data!.data![index];
                    return ToRun(
                      inspectionData: inspectionDataItem,
                      onTap: () {
                        inspectionProvider.selectToRunInspection(context,
                            inspectiondata: inspectionDataItem);
                      },
                    );
                  },
                ),

              if (inspectionProvider.loadingMore) const LoadinWidget(),
              if (!inspectionProvider.loading &&
                  selectedFilter == "2nd Inspection")
                Text(
                  "${inspectionProvider.inspectionResponse.data?.data?.length.toString() ?? "-"} of  ${inspectionProvider.inspectionResponse.data?.total.toString() ?? "-"}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: NewColors.secondattextcolor,
                      fontWeight: FontWeight.bold,
                      fontSize: buildFontSize(30)),
                ),
              if (!inspectionProvider.loading &&
                  selectedFilter == "In Progress")
                Text(
                  "${inspectionProvider.inspectionResponse.data?.data?.length.toString() ?? "-"} of  ${inspectionProvider.inspectionResponse.data?.total.toString() ?? "-"}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: NewColors.secondattextcolor,
                      fontWeight: FontWeight.bold,
                      fontSize: buildFontSize(30)),
                ),
              if (!inspectionProvider.loading && selectedFilter == "To Run")
                Text(
                  "${inspectionProvider.inspectionToRunResponse.data?.data?.length.toString() ?? "-"} of  ${inspectionProvider.inspectionToRunResponse.data?.total.toString() ?? "-"}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: NewColors.secondattextcolor,
                      fontWeight: FontWeight.bold,
                      fontSize: buildFontSize(30)),
                )
            ],
          );
        },
      ),
    );
  }
}

class InProgress extends StatelessWidget {
  final InspectionData inspectionData;
  final void Function()? onTap;
  const InProgress({
    super.key,
    required this.inspectionData,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: NewColors.whitecolor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: "${inspectionData.contracted == 0 ? "" : "ⓒ "}",
                          style: TextStyle(
                            color: NewColors.red,
                            fontWeight: boldFontWeight,
                            fontSize: buildFontSize(35),
                          ),
                          children: [
                            TextSpan(
                              text: inspectionData.inspectionCode ?? "-",
                              style: TextStyle(
                                color: NewColors.black,
                                fontWeight: boldFontWeight,
                                fontSize: buildFontSize(35),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: NewColors.secondaycolor,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        inspectionData.inspectionTemplate?.name ?? "-",
                        style: TextStyle(
                          color: NewColors.inspectionscolor,
                          fontWeight: boldFontWeight,
                          fontSize: buildFontSize(35),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: NewColors.secondaycolor,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      inspectionData.facility?.name ?? "-",
                      style: TextStyle(
                        color: NewColors.black,
                        fontWeight: mediumFontWeight,
                        fontSize: buildFontSize(35),
                      ),
                    ),
                    Text(
                      "${inspectionData.block?.name ?? '-'} ${inspectionData.unit?.unitNo ?? ""}",
                      style: TextStyle(
                        color: NewColors.black,
                        fontWeight: mediumFontWeight,
                        fontSize: buildFontSize(35),
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: NewColors.secondaycolor,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: "Inspector ",
                          style: TextStyle(
                            fontSize: buildFontSize(30),
                            fontWeight: FontWeight.w500,
                            color: NewColors.secondattextcolor,
                          ),
                          children: [
                            TextSpan(
                              text: inspectionData.creator?.username ?? "-",
                              style: TextStyle(
                                fontSize: buildFontSize(30),
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
                        "${formateDateTime(value: inspectionData.createdAt!)}",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: NewColors.secondattextcolor,
                          fontWeight: mediumFontWeight,
                          fontSize: buildFontSize(30),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SecondInspection extends StatelessWidget {
  final InspectionData inspectionData;
  final void Function()? onTap;
  const SecondInspection({
    super.key,
    required this.inspectionData,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: NewColors.whitecolor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "INS-01154451215545152",
                      style: TextStyle(
                        color: NewColors.black,
                        fontWeight: boldFontWeight,
                        fontSize: buildFontSize(35),
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: NewColors.secondaycolor,
                ),
                Row(
                  children: [
                    Text(
                      "Contractual Unit Cleaning 1st Cycle Inspection",
                      style: TextStyle(
                        color: NewColors.inspectionscolor,
                        fontWeight: boldFontWeight,
                        fontSize: buildFontSize(35),
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: NewColors.secondaycolor,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "JPD1",
                      style: TextStyle(
                        color: NewColors.black,
                        fontWeight: mediumFontWeight,
                        fontSize: buildFontSize(35),
                      ),
                    ),
                    Text(
                      "Block 60, #10-17",
                      style: TextStyle(
                        color: NewColors.black,
                        fontWeight: mediumFontWeight,
                        fontSize: buildFontSize(35),
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: NewColors.secondaycolor,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "JPD1",
                          style: TextStyle(
                            color: NewColors.secondattextcolor,
                            fontWeight: mediumFontWeight,
                            fontSize: buildFontSize(30),
                          ),
                        ),
                        Text(
                          "Ajay",
                          style: TextStyle(
                            color: NewColors.black,
                            fontSize: buildFontSize(30),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "1st Inspection Completion",
                          style: TextStyle(
                            color: NewColors.secondattextcolor,
                            fontWeight: mediumFontWeight,
                            fontSize: buildFontSize(30),
                          ),
                        ),
                        Text(
                          "15/07/2025 09:30 PM",
                          style: TextStyle(
                            color: NewColors.black,
                            fontSize: buildFontSize(30),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  color: NewColors.secondaycolor,
                ),
                SizedBox(
                  height: aspectRatio * 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "12/07/2025 09:30 PM",
                      style: TextStyle(
                        color: NewColors.black,
                        fontSize: buildFontSize(30),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: aspectRatio * 20,
                          horizontal: aspectRatio * 40),
                      decoration: BoxDecoration(
                        color: NewColors.primary,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Run",
                            style: TextStyle(
                                color: NewColors.black,
                                fontWeight: boldFontWeight,
                                fontSize: buildFontSize(
                                  35,
                                )),
                          ),
                          Icon(
                            Icons.arrow_forward,
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ToRun extends StatelessWidget {
  final InspectionDataItem inspectionData;
  final void Function()? onTap;

  const ToRun({
    super.key,
    required this.inspectionData,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: NewColors.whitecolor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      inspectionData.name ?? "-",
                      style: TextStyle(
                        color: NewColors.inspectionscolor,
                        fontWeight: boldFontWeight,
                        fontSize: buildFontSize(35),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                color: NewColors.secondaycolor,
              ),
              SizedBox(
                height: aspectRatio * 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formateDateTime(value: inspectionData.createdAt!),
                    style: TextStyle(
                      color: NewColors.black,
                      fontSize: buildFontSize(30),
                    ),
                  ),
                  if (checkPermission(permit: "run inspections"))
                    InkWell(
                      onTap: onTap,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: aspectRatio * 20,
                            horizontal: aspectRatio * 40),
                        decoration: BoxDecoration(
                          color: NewColors.primary,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Run",
                              style: TextStyle(
                                  color: NewColors.black,
                                  fontWeight: boldFontWeight,
                                  fontSize: buildFontSize(
                                    35,
                                  )),
                            ),
                            Icon(
                              Icons.arrow_forward,
                            )
                          ],
                        ),
                      ),
                    )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
