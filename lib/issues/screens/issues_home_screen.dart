// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fixlah/config/custom_widgets.dart';
import 'package:fixlah/facilities/provider/facilities_provider.dart';
import 'package:fixlah/issues/screens/unit_issue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:fixlah/config/colors.dart';
import 'package:fixlah/config/constants.dart';
import 'package:fixlah/config/sizes.dart';
import 'package:fixlah/config/text_fields.dart';
import 'package:fixlah/config/timer.dart';
import 'package:fixlah/config/utils.dart';
import 'package:fixlah/home/provider/home_provider.dart';
import 'package:fixlah/issues/model/issues_model.dart';
import 'package:fixlah/issues/provider/issues_provider.dart';

import 'package:fixlah/issues/screens/filter_screen.dart';

class IssuesHomeScreen extends StatefulWidget {
  const IssuesHomeScreen({super.key});

  @override
  State<IssuesHomeScreen> createState() => _IssuesHomeScreenState();
}

class _IssuesHomeScreenState extends State<IssuesHomeScreen> {
  final ScrollController _scrollController = ScrollController();
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    IssuesProvider issuesProvider = Provider.of<IssuesProvider>(
      context,
      listen: false,
    );
    HomeProvider homeProvider = Provider.of<HomeProvider>(
      context,
      listen: false,
    );
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (issuesProvider.issuesList.data?.data?.length.toString() !=
            issuesProvider.issuesList.data?.total!.toString()) {
          issuesProvider.getMoreData(context);
        }
      }
    });
    issuesProvider.urgentIssueCount =
        homeProvider.dashboardData.data?.issues?.urgent ?? 0;
    issuesProvider.noturgentIssueCount =
        homeProvider.dashboardData.data?.issues?.notUrgent ?? 0;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<IssuesProvider>(
        context,
        listen: false,
      ).getData(context);
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NewColors.secondaryBgColor,
      floatingActionButton: checkPermission(permit: "create issues")
          ? Container(
              padding: EdgeInsets.all(10.r),
              decoration: const BoxDecoration(
                  color: NewColors.primary, shape: BoxShape.circle),
              child: IconButton(
                  onPressed: () {
                    context.read<IssuesProvider>().resset();
                    context.read<FacilitiesProvider>().resetFacilityData();
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UnitIssue()))
                        .then((value) {
                      if (value) {
                        Navigator.pop(context, true);
                      }
                    });
                  },
                  icon: Icon(
                    size: 30.r,
                    color: NewColors.black,
                    Icons.add,
                  )),
            )
          : SizedBox(),
      appBar: generalAppBar(context, title: "Issues", actions: [
        // Filter Icon

        FilterIcon(
          onPressed: () {
            naviagteTo(context,
                builder: (context) => const IssuesFilterScreen());
          },
        )
      ]),
      body: Consumer<IssuesProvider>(builder: (context, issuesProvider, child) {
        String filter = issuesProvider.status;
        return ListView(
          controller: _scrollController,
          children: [
            Container(
              padding: EdgeInsets.all(aspectRatio * 20),
              color: NewColors.issuescolor,
              child: Column(
                children: [
                  Consumer<HomeProvider>(
                      builder: (context, homeProvider, child) {
                    return Row(
                      // Tab
                      children: [
                        // Urgent tab
                        Expanded(
                          child: FilterTab(
                              onTap: () {
                                issuesProvider.changeIssueStatus(context,
                                    newstatus: issuesStatus[0]);
                              },
                              status: issuesStatus[0],
                              filter: filter,
                              title: issuesStatus[0],
                              count: issuesStatus[0] == "Urgent"
                                  ? issuesProvider.urgentIssueCount
                                  : issuesProvider.noturgentIssueCount),
                        ),
                        //  Not Urgent Tab
                        Expanded(
                          child: FilterTab(
                            onTap: () {
                              issuesProvider.changeIssueStatus(context,
                                  newstatus: issuesStatus[1]);
                            },
                            status: issuesStatus[1],
                            filter: filter,
                            title: issuesStatus[1],
                            count: issuesStatus[1] == "Urgent"
                                ? issuesProvider.urgentIssueCount
                                : issuesProvider.noturgentIssueCount,
                          ),
                        )
                      ],
                    );
                  }),
                  SizedBox(
                    height: 10.r,
                  ),
                  SearchField(
                    searchText: controller,
                    onPressed: () {
                      issuesProvider.makeSearch(context,
                          searchText: controller.text);
                      closekeyboard();
                    },
                    title: 'Search by User, Block and Unit #',
                    onFieldSubmitted: (value) {
                      issuesProvider.makeSearch(context, searchText: value);
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.r,
            ),
            // Issue List
            issuesProvider.loading
                ? const LoadinWidget()
                // ignore: prefer_is_empty
                : issuesProvider.issuesList.data?.data?.length == 0
                    ? EmptyView()
                    : ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(15),
                        separatorBuilder: (context, index) => SizedBox(
                          height: aspectRatio * 40,
                        ),
                        itemCount:
                            issuesProvider.issuesList.data?.data?.length ?? 0,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          IssueData issueData =
                              issuesProvider.issuesList.data!.data![index];

                          return IssueCard(
                            issueData: issueData,
                            onTap: () {
                              issuesProvider.selectIssue(context, issueData);
                            },
                          );
                        },
                      ),
            if (issuesProvider.loadingMore) const LoadinWidget(),
            if (!issuesProvider.loading)
              Text(
                "${issuesProvider.issuesList.data?.data?.length.toString() ?? "-"} of  ${issuesProvider.issuesList.data?.total.toString() ?? "-"}",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: NewColors.secondattextcolor,
                    fontWeight: FontWeight.bold,
                    fontSize: buildFontSize(30)),
              )
          ],
        );
      }),
    );
  }
}

class EmptyView extends StatelessWidget {
  final String? title;
  const EmptyView({
    super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      title ?? "No records found",
      style:
          TextStyle(fontSize: buildFontSize(35), fontWeight: FontWeight.w700),
    ));
  }
}

class FilterTab extends StatelessWidget {
  final String status;
  final String filter;
  final String title;
  final void Function()? onTap;
  final int count;
  const FilterTab({
    super.key,
    required this.status,
    required this.filter,
    required this.title,
    this.onTap,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(5.r),
          child: SizedBox(
              height: 55.r,
              child: InkWell(
                  onTap: onTap,
                  child: Container(
                    // width: fullWidth / 2.3,
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.r, vertical: 5.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: filter == title ? NewColors.primary : Colors.white,
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            title,
                            style: TextStyle(
                              fontSize: buildFontSize(30),
                              fontWeight: boldFontWeight,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))),
        ),
        if (count != 0)
          SizedBox(
            height: 70.r,
            // width: fullWidth / 2.3,
            child: Align(
              alignment: AlignmentGeometry.topRight,
              child: Badge.count(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.all(8.r),
                  textStyle: TextStyle(
                      fontSize: buildFontSize(25),
                      color: Colors.white,
                      fontWeight: mediumFontWeight),
                  count: count),
            ),
          )
      ],
    );
  }
}

class IssueCard extends StatelessWidget {
  final IssueData issueData;
  final void Function()? onTap;

  const IssueCard({
    super.key,
    required this.issueData,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: fullWidth,
            height: fullHeight / 4,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                // ignore: prefer_is_empty
                image: NetworkImage(issueData.photos?.length == 0
                    ? "https://fixlah.myila.in/assets/desktop/img/fixlah-logo.png"
                    : "${AppConstants.issuesImageBaseUrl}${issueData.photos![0].photoPath}"),
              ),
            ),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Badge(
                      backgroundColor: NewColors.transperent,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      label: Text(
                        timeAgoSinceDate(
                            passdate: DateTime.parse(issueData.createdAt!)),
                        style: TextStyle(
                            fontWeight: mediumFontWeight,
                            color: NewColors.whitecolor,
                            fontSize: buildFontSize(25)),
                      ),
                    ),
                    SizedBox(height: 8.r),
                    Badge(
                      backgroundColor: issueData.creamUnit == 0
                          ? NewColors.red
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
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                )),
            child: Column(
              children: [
                SizedBox(
                  height: 10.r,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        issueData.issueIdAuto.toString(),
                        style: TextStyle(
                            fontSize: buildFontSize(28),
                            color: NewColors.black,
                            fontWeight: boldFontWeight),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        textAlign: TextAlign.end,
                        // ignore: prefer_is_empty
                        issueData.items?.length == 0
                            ? "-"
                            : issueData.items?[0].item ?? "-",
                        style: TextStyle(
                            fontSize: buildFontSize(30),
                            color: NewColors.red,
                            fontWeight: boldFontWeight),
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 20.r,
                  color: NewColors.secondaycolor,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      issueData.facility?.name ?? "",
                      style: TextStyle(
                          fontSize: buildFontSize(30),
                          color: NewColors.black,
                          fontWeight: mediumFontWeight),
                    ),
                    Text(
                      '${issueData.block?.name ?? ""} ${issueData.unit?.unitNo ?? ""}',
                      style: TextStyle(
                          fontSize: buildFontSize(30),
                          color: NewColors.black,
                          fontWeight: mediumFontWeight),
                    ),
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
                      child: Row(
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
                                    text: issueData.createdBy?.name ?? "",
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
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        textAlign: TextAlign.end,
                        formateDateTime(value: issueData.createdAt ?? '') ?? "",
                        style: TextStyle(
                          fontSize: buildFontSize(25),
                          color: NewColors.secondattextcolor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.r,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
