// ignore_for_file: use_build_context_synchronously

import 'package:fixlah/auth/provider/login_provider.dart';
import 'package:fixlah/auth/screen/face_detector.dart';

import 'package:fixlah/config/colors.dart';
import 'package:fixlah/config/constants.dart';
import 'package:fixlah/config/graphics.dart';
import 'package:fixlah/config/sizes.dart';
import 'package:fixlah/config/utils.dart';
import 'package:fixlah/facilities/provider/facilities_provider.dart';
import 'package:fixlah/facilities/screen/facilities_screen.dart';
import 'package:fixlah/home/provider/home_provider.dart';
import 'package:fixlah/inspection/screen/inspection_list.dart';
import 'package:fixlah/issues/screens/issues_home_screen.dart';
import 'package:fixlah/userdata/userdata_provider.dart';
import 'package:fixlah/work%20order/screen/work_order_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<UserdataProvider>(
        context,
        listen: false,
      ).getUserData(context);
      await Provider.of<HomeProvider>(
        context,
        listen: false,
      ).getData(context);
      await Provider.of<HomeProvider>(
        context,
        listen: false,
      ).getAreaList(context);
      await Provider.of<HomeProvider>(
        context,
        listen: false,
      ).getIssueType(context);
      await Provider.of<HomeProvider>(
        context,
        listen: false,
      ).getIssueCategory(context);
      await Provider.of<FacilitiesProvider>(
        context,
        listen: false,
      ).getAllFacilities(context);
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: NewColors.scafoldbgcolor,
        child: Consumer<UserdataProvider>(builder: (context, userData, child) {
          return userData.loading || context.watch<LoginState>().loading
              ? LoadinWidget()
              : ListView(
                  children: [
                    DrawerHeader(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Text(
                        //   userData.userData.r ?? "",
                        //   style: TextStyle(
                        //       color: NewColors.black,
                        //       fontWeight: FontWeight.bold,
                        //       fontSize: buildFontSize(30)),
                        // ),
                        Text(
                          userData.userData.username ?? "",
                          style: TextStyle(
                              color: NewColors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: buildFontSize(30)),
                        ),
                      ],
                    )),
                    ListTile(
                      onTap: () async {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FaceDetector()))
                            .then((value) {
                          if (value == true) {
                            _scaffoldKey.currentState!.closeDrawer();
                          }
                        });
                      },
                      title: Text(
                        "Face Lock",
                        style: TextStyle(
                          color: NewColors.black,
                          fontSize: buildFontSize(35),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Icon(
                        Icons.person_outline,
                        color: NewColors.black,
                      ),
                    ),
                    ListTile(
                      onTap: () async {
                        context.read<LoginState>().logOut(context);
                      },
                      title: Text(
                        "Logout",
                        style: TextStyle(
                          color: NewColors.black,
                          fontSize: buildFontSize(35),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Icon(
                        Icons.login,
                        color: NewColors.red,
                      ),
                    ),
                  ],
                );
        }),
      ),
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        // logo
        title: Row(
          children: [
            IconButton(
                onPressed: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
                icon: Icon(
                  Icons.menu_sharp,
                  color: NewColors.black,
                )),
            Image(
              image: const AssetImage(
                Graphics.logo_primary,
              ),
              width: 120.r,
            ),
          ],
        ),
        // action
        actions: [
          Consumer<HomeProvider>(builder: (context, homeProvider, child) {
            return Row(
              children: [
                Consumer<FacilitiesProvider>(
                    builder: (context, facilitiesProvider, child) {
                  return GestureDetector(
                      onTap: () async {
                        Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.bottomToTop,
                                    child: const FacilitiesScreen()))
                            .then((value) async {
                          if (value == true) {
                            await homeProvider.getData(
                              context,
                            );
                          }
                        });
                      },
                      child: Row(
                        children: [
                          Text(
                            selectedFacilities.length ==
                                    facilitiesProvider.totalFacilities
                                ? "All Facilities"
                                : facilitiesProvider.selectedFacilitiesName
                                    .join(","),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: buildFontSize(35)),
                          ),
                          const Icon(Icons.keyboard_arrow_down)
                        ],
                      ));
                }),
              ],
            );
          })
        ],
      ),
      body: Consumer<UserdataProvider>(builder: (context, userData, child) {
        return Consumer<HomeProvider>(builder: (context, homeProvider, child) {
          return ListView(
            padding: const EdgeInsets.all(15),
            children: [
              Text(
                "Welcome back",
                style: TextStyle(
                    fontWeight: mediumFontWeight,
                    color: NewColors.textcolor,
                    fontSize: buildFontSize(30)),
              ),
              userData.loading
                  ? const SizedBox()
                  : Text(
                      userData.userData.username ?? "Test",
                      style: TextStyle(
                          fontWeight: boldFontWeight,
                          fontSize: buildFontSize(35)),
                    ),
              SizedBox(
                height: 15.r,
              ),
              if (checkPermission(permit: "all issues"))
                TypeCard(
                  bgColor: NewColors.issuesBgcolor,
                  title: "Issues",
                  label1Name: "URGENT",
                  label1Count: homeProvider.dashboardData.data?.issues!.urgent
                          .toString() ??
                      "0",
                  label2Name: "NOT URGENT",
                  label2Count: homeProvider
                          .dashboardData.data?.issues!.notUrgent
                          .toString() ??
                      "0",
                  image: Graphics.issue_icon,
                  onTap: () {
                    naviagteTo(context,
                        builder: (context) => const IssuesHomeScreen());
                  },
                  titleColor: NewColors.issuescolor,
                ),
              SizedBox(
                height: aspectRatio * 30,
              ),
              if (checkPermission(permit: "view work order"))
                TypeCard(
                  bgColor: NewColors.workorderBgcolor,
                  titleColor: NewColors.workordercolor,
                  title: "Work Order",
                  label1Name: "URGENT",
                  label1Count: homeProvider
                          .dashboardData.data?.workOrders!.urgent
                          .toString() ??
                      "0",
                  label2Name: "NOT URGENT",
                  label2Count: homeProvider
                          .dashboardData.data?.workOrders!.notUrgent
                          .toString() ??
                      "0",
                  image: Graphics.work_order,
                  onTap: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WorkOrderList()))
                        .then((value) {
                      homeProvider.getData(context);
                    });
                  },
                ),
              SizedBox(
                height: aspectRatio * 30,
              ),
              if (checkPermission(permit: "view inspections"))
                TypeCard(
                  bgColor: NewColors.inspectionsBgcolor,
                  titleColor: NewColors.inspectionscolor,
                  title: "Inspection",
                  label1Name: "Unit",
                  label1Count: homeProvider
                          .dashboardData.data?.inspection!.units
                          .toString() ??
                      "0",
                  label2Name: "Common Area",
                  label2Count: homeProvider
                          .dashboardData.data?.inspection!.commonArea
                          .toString() ??
                      "0",
                  image: Graphics.inspection,
                  onTap: () {
                    naviagteTo(context,
                        builder: (context) => const InspectionList());
                  },
                ),
            ],
          );
        });
      }),
    );
  }
}

class TypeCard extends StatelessWidget {
  final String title;
  final String label1Name;
  final String label1Count;
  final String label2Name;
  final String label2Count;
  final String image;
  final void Function()? onTap;
  final Color bgColor;
  final Color titleColor;
  const TypeCard({
    super.key,
    required this.title,
    required this.label1Name,
    required this.label1Count,
    required this.label2Name,
    required this.label2Count,
    required this.image,
    required this.bgColor,
    this.onTap,
    required this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(aspectRatio * 40),
        height: fullHeight / 4,
        width: fullWidth,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: borderRadiusStyle(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: boldFontWeight,
                    fontSize: buildFontSize(50),
                    color: titleColor,
                  ),
                ),
                SizedBox(
                  height: aspectRatio * 20,
                ),
                SubLabel(
                  label: label1Name,
                  count: label1Count,
                ),
                SizedBox(
                  height: aspectRatio * 10,
                ),
                SubLabel(
                  label: label2Name,
                  count: label2Count,
                ),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      padding: EdgeInsets.all(25.r),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: NewColors.primary,
                      ),
                      child: Image(image: AssetImage(image))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SubLabel extends StatelessWidget {
  final String label;
  final String count;
  const SubLabel({
    super.key,
    required this.label,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
              fontWeight: mediumFontWeight,
              fontSize: buildFontSize(30),
              color: Colors.black),
        ),
        SizedBox(
          width: aspectRatio * 10,
        ),
        Badge.count(
          count: int.parse(count),
          textColor: Colors.black,
          backgroundColor: NewColors.primary,
          textStyle:
              TextStyle(color: Colors.black, fontSize: buildFontSize(35)),
        )
      ],
    );
  }
}

borderRadiusStyle() {
  return const BorderRadius.only(
    topLeft: Radius.circular(20),
    bottomLeft: Radius.circular(20),
    bottomRight: Radius.circular(500),
    topRight: Radius.circular(500),
  );
}
