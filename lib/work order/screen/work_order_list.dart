// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fixlah/config/custom_widgets.dart';
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
import 'package:fixlah/issues/screens/issues_home_screen.dart';
import 'package:fixlah/work%20order/model/work_order_model.dart';
import 'package:fixlah/work%20order/provider/work_order_provider.dart';
import 'package:fixlah/work%20order/screen/filter.dart';
import 'package:fixlah/work%20order/screen/wo_deatils.dart';

class WorkOrderList extends StatefulWidget {
  const WorkOrderList({super.key});

  @override
  State<WorkOrderList> createState() => _WorkOrderListState();
}

class _WorkOrderListState extends State<WorkOrderList> {
  final ScrollController _scrollController = ScrollController();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        WorkOrderProvider workOrderProvider = Provider.of<WorkOrderProvider>(
          context,
          listen: false,
        );

        if (workOrderProvider.workOrderList.data?.data?.length.toString() !=
            workOrderProvider.workOrderList.data?.total!.toString()) {
          workOrderProvider.getMoreData(context);
        }
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<WorkOrderProvider>(
        context,
        listen: false,
      ).getData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NewColors.secondaryBgColor,
      appBar: generalAppBar(
        newColor: NewColors.workordercolor,
        context,
        title: "Work Orders",
        actions: [
          FilterIcon(
            onPressed: () {
              naviagteTo(context,
                  builder: (context) => const WorlOrderFilter());
            },
          )
        ],
      ),
      body: Consumer<WorkOrderProvider>(
          builder: (context, workOrderProvider, child) {
        String selectedFilter = workOrderProvider.tabStatus;
        String selectedOrder = workOrderProvider.woOrder;

        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(aspectRatio * 30),
                color: NewColors.workordercolor,
                child: Column(
                  children: [
                    // Urgent and not urgent tab
                    Consumer<HomeProvider>(
                        builder: (context, homeProvider, child) {
                      return Row(
                        children: [
                          Expanded(
                            child: FilterTab(
                              onTap: () {
                                workOrderProvider.changeTab(context,
                                    newTab: "Urgent");
                              },
                              title: "Urgent",
                              filter: selectedFilter,
                              count: homeProvider
                                      .dashboardData.data?.workOrders?.urgent ??
                                  0,
                              status: '',
                            ),
                          ),
                          Expanded(
                            child: FilterTab(
                              onTap: () {
                                workOrderProvider.changeTab(context,
                                    newTab: "Not Urgent");
                              },
                              title: "Not Urgent",
                              filter: selectedFilter,
                              count: homeProvider.dashboardData.data?.workOrders
                                      ?.notUrgent ??
                                  0,
                              status: '',
                            ),
                          ),
                        ],
                      );
                    }),
                    SizedBox(
                      height: aspectRatio * 10,
                    ),
                    SearchField(
                      searchText: controller,
                      onPressed: () {
                        workOrderProvider.searchRequest(context,
                            searchText: controller.text);
                        closekeyboard();
                      },
                      title: 'Search by User, Ticket and Unit #',
                      onFieldSubmitted: (value) {
                        workOrderProvider.searchRequest(context,
                            searchText: value);
                      },
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.r),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // MY WO
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              workOrderProvider.selectWoType(context,
                                  woTypeInput: "My");
                            },
                            child: Container(
                              height: 75.r,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  width: 2,
                                  color: selectedOrder == "My"
                                      ? NewColors.workordercolor
                                      : NewColors.secondaycolor,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "My Work Order",
                                  style: TextStyle(
                                      fontWeight: boldFontWeight,
                                      color: selectedOrder == "My"
                                          ? NewColors.workordercolor
                                          : NewColors.black,
                                      fontSize: buildFontSize(30)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.r,
                        ),
                        // All WO

                        Expanded(
                          child: InkWell(
                            onTap: () {
                              workOrderProvider.selectWoType(context,
                                  woTypeInput: "All");
                            },
                            child: Container(
                              height: 75.r,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  width: 2,
                                  color: selectedOrder == "All"
                                      ? NewColors.workordercolor
                                      : NewColors.secondaycolor,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "All Work Order",
                                  style: TextStyle(
                                      color: selectedOrder == "All"
                                          ? NewColors.workordercolor
                                          : NewColors.black,
                                      fontWeight: boldFontWeight,
                                      fontSize: buildFontSize(30)),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    workOrderProvider.loading
                        ? const LoadinWidget()
                        // ignore: prefer_is_empty
                        : workOrderProvider.workOrderList.data?.data?.length ==
                                0
                            ? const EmptyView()
                            : ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                // padding: const EdgeInsets.all(15),
                                separatorBuilder: (context, index) => SizedBox(
                                  height: aspectRatio * 40,
                                ),
                                itemCount: workOrderProvider
                                        .workOrderList.data?.data?.length ??
                                    0,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  WorkOrderData workOrderData =
                                      workOrderProvider
                                          .workOrderList.data!.data![index];
                                  return WorkOrderCard(
                                    onTap: () {
                                      naviagteTo(context,
                                          builder: (context) => WoDeatils(
                                                id: workOrderData.id.toString(),
                                              ));
                                    },
                                    workOrderData: workOrderData,
                                  );
                                },
                              ),
                    if (workOrderProvider.loadingMore) const LoadinWidget(),
                    if (!workOrderProvider.loading)
                      Text(
                        "${workOrderProvider.workOrderList.data?.data?.length.toString() ?? "-"} of  ${workOrderProvider.workOrderList.data?.total.toString() ?? "-"}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: NewColors.secondattextcolor,
                            fontWeight: FontWeight.bold,
                            fontSize: buildFontSize(30)),
                      )
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class WorkOrderCard extends StatelessWidget {
  final WorkOrderData workOrderData;
  final void Function()? onTap;
  const WorkOrderCard({
    super.key,
    required this.workOrderData,
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
                image: NetworkImage(workOrderData.workorderPhotos?.length == 0
                    ? "https://fixlah.myila.in/assets/desktop/img/fixlah-logo.png"
                    : "${AppConstants.woImageBaseUrl}${workOrderData.workorderPhotos?[0].photoPath}"),
              ),
            ),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Badge(
                      backgroundColor: NewColors.transperent,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      label: Text(
                        timeAgoSinceDate(
                            passdate: DateTime.parse(workOrderData.createdAt!)),
                        style: TextStyle(
                            fontWeight: mediumFontWeight,
                            color: NewColors.whitecolor,
                            fontSize: buildFontSize(25)),
                      ),
                    ),
                    SizedBox(
                      height: aspectRatio * 10,
                    ),
                    Badge(
                      backgroundColor: workOrderData.creamUnit == 0
                          ? NewColors.red
                          : NewColors.greencolor,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      label: Text(
                        workOrderData.creamUnit == 0 ? "NON-CREAM" : "CREAM",
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
                  height: aspectRatio * 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        workOrderData.woIdAuto ?? "",
                        style: TextStyle(
                          fontSize: buildFontSize(30),
                          color: NewColors.black,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        textAlign: TextAlign.end,
                        workOrderData.issue?.issueType ?? "",
                        style: TextStyle(
                            fontSize: buildFontSize(35),
                            color: NewColors.workordercolor,
                            fontWeight: mediumFontWeight),
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: aspectRatio * 40,
                  color: NewColors.secondaycolor,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        workOrderData.facility!.name ?? "-",
                        style: TextStyle(
                          fontSize: buildFontSize(30),
                          color: NewColors.black,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        workOrderData.locationTag?.name ?? "-",
                        style: TextStyle(
                            fontSize: buildFontSize(30),
                            color: NewColors.black,
                            fontWeight: mediumFontWeight),
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: aspectRatio * 40,
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
                                    text: workOrderData.createdBy?.name ?? "",
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
                        "${formateDate(value: workOrderData.createdAt!)} ${formateTime(value: workOrderData.createdAt!)}",
                        style: TextStyle(
                          fontSize: buildFontSize(25),
                          color: NewColors.secondattextcolor,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: aspectRatio * 40,
                  color: NewColors.secondaycolor,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            "Assigned to ",
                            style: TextStyle(
                              fontSize: buildFontSize(25),
                              color: NewColors.secondattextcolor,
                            ),
                          ),
                          Text(
                            workOrderData.assignedTo ?? "",
                            style: TextStyle(
                              fontSize: buildFontSize(25),
                              fontWeight: FontWeight.bold,
                              color: NewColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${formateDate(value: workOrderData.expectedEndDate!)} ",
                      style: TextStyle(
                        fontSize: buildFontSize(25),
                        fontWeight: FontWeight.w500,
                        color: NewColors.secondattextcolor,
                      ),
                    ),
                    Text(
                      workOrderData.expectedEndTime!,
                      style: TextStyle(
                        fontSize: buildFontSize(25),
                        fontWeight: FontWeight.w500,
                        color: NewColors.secondattextcolor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: aspectRatio * 20,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
