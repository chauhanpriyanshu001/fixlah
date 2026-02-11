import 'package:fixlah/config/colors.dart';
import 'package:fixlah/config/constants.dart';
import 'package:fixlah/config/sizes.dart';
import 'package:fixlah/config/utils.dart';
import 'package:fixlah/inspection/model/inspection_categories_item_data.dart';
import 'package:fixlah/inspection/model/inspection_get_model.dart';
import 'package:fixlah/inspection/provider/inspection_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class InspecttionCategoryList extends StatefulWidget {
  const InspecttionCategoryList({super.key});

  @override
  State<InspecttionCategoryList> createState() =>
      _InspecttionCategoryListState();
}

class _InspecttionCategoryListState extends State<InspecttionCategoryList> {
  TextEditingController inspectionDescription = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<InspectionProvider>(
        builder: (context, inspectionProvider, child) {
      final InspectionGetData inspectionData =
          inspectionProvider.inspectionData;
      InspectionTemplate inspectionTemplate =
          inspectionData.data?.inspectionTemplate ?? InspectionTemplate();
      InspectionCategoryitemData inspectionCategoryitemData =
          inspectionProvider.inspectionCategoryData;

      inspectionDescription.text = inspectionTemplate.description ?? "-";
      return Scaffold(
        appBar: generalAppBar(context,
            title: "Inspection Details",
            newColor: NewColors.inspectionscolor,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  icon: Icon(
                    color: NewColors.whitecolor,
                    Icons.close,
                  ))
            ]),
        body: inspectionProvider.loading || inspectionData.data == null
            ? const LoadinWidget()
            : ListView(
                padding: EdgeInsets.all(25.r),
                children: [
                  Text(
                    "Inspection Categories",
                    style: TextStyle(
                        fontSize: buildFontSize(30),
                        color: NewColors.textcolor),
                  ),
                  SizedBox(
                    height: 10.r,
                  ),
                  inspectionCategoryitemData.data != null &&
                          inspectionCategoryitemData.data?.length == 0
                      ? Text(
                          "No Category Found",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: mediumFontWeight,
                            fontSize: buildFontSize(20),
                            color: NewColors.black,
                          ),
                        )
                      : ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 10.r,
                          ),
                          shrinkWrap: true,
                          itemCount:
                              inspectionCategoryitemData.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            CategoryNewData data2 =
                                inspectionCategoryitemData.data![index];

                            return InkWell(
                              onTap: () {
                                if (checkPermission(
                                    permit: "run inspections")) {
                                  inspectionProvider.selectInspectionCategory(
                                      context,
                                      chossenCategory: data2);
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(15.r),
                                decoration: BoxDecoration(
                                    color:
                                        // data.condition == null &&
                                        //         data.overallGrade == null &&
                                        //         data.overallCompliance == null
                                        //     ? NewColors.secondaryBgColor
                                        // :
                                        Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      color: NewColors.secondaycolor,
                                    )),
                                child: Row(
                                  children: [
                                    // if (data.condition == "Good")
                                    //   Container(
                                    //     width: 25.r,
                                    //     height: 25.r,
                                    //     decoration: const BoxDecoration(
                                    //         color: NewColors.greencolor,
                                    //         shape: BoxShape.circle),
                                    //     child: const Icon(
                                    //       Icons.done,
                                    //       color: NewColors.whitecolor,
                                    //     ),
                                    //   ),
                                    // if (data.condition == "Not Good")
                                    //   Container(
                                    //     width: 25.r,
                                    //     height: 25.r,
                                    //     decoration: const BoxDecoration(
                                    //         color: NewColors.red,
                                    //         shape: BoxShape.circle),
                                    //     child: const Icon(
                                    //       Icons.close,
                                    //       color: NewColors.whitecolor,
                                    //     ),
                                    //   ),
                                    // if (data.condition == "Not Applicable")
                                    //   const Icon(
                                    //     Icons.error,
                                    //     color: NewColors.primary,
                                    //   ),
                                    // if (data.condition == null &&
                                    //     data.overallGrade == null &&
                                    //     data.overallCompliance == null)
                                    //   Container(
                                    //     width: 25.r,
                                    //     height: 25.r,
                                    //     decoration: const BoxDecoration(
                                    //         color: NewColors.secondaycolor,
                                    //         shape: BoxShape.circle),
                                    //   ),
                                    // if (data.overallGrade == "Not Applicable")
                                    //   Container(
                                    //     width: 25.r,
                                    //     height: 25.r,
                                    //     decoration: const BoxDecoration(
                                    //         color: NewColors.inspectionscolor,
                                    //         shape: BoxShape.circle),
                                    //     child: Center(
                                    //         child: Text(
                                    //       "N",
                                    //       style: TextStyle(
                                    //           fontSize: buildFontSize(25),
                                    //           color: NewColors.whitecolor,
                                    //           fontWeight: FontWeight.w500),
                                    //     )),
                                    //   ),
                                    // if (data.overallGrade == "A")
                                    //   Container(
                                    //     width: 25.r,
                                    //     height: 25.r,
                                    //     decoration: const BoxDecoration(
                                    //         color: NewColors.greencolor,
                                    //         shape: BoxShape.circle),
                                    //     child: Center(
                                    //         child: Text(
                                    //       "A",
                                    //       style: TextStyle(
                                    //           fontSize: buildFontSize(25),
                                    //           color: NewColors.whitecolor,
                                    //           fontWeight: FontWeight.w500),
                                    //     )),
                                    //   ),
                                    // if (data.overallGrade == "B")
                                    //   Container(
                                    //     width: 25.r,
                                    //     height: 25.r,
                                    //     decoration: const BoxDecoration(
                                    //         color: NewColors.primary,
                                    //         shape: BoxShape.circle),
                                    //     child: Center(
                                    //         child: Text(
                                    //       "B",
                                    //       style: TextStyle(
                                    //           fontSize: buildFontSize(25),
                                    //           color: NewColors.whitecolor,
                                    //           fontWeight: FontWeight.w500),
                                    //     )),
                                    //   ),
                                    // if (data.overallCompliance == 1 &&
                                    //     data.overallGrade == null &&
                                    //     data.condition == null)
                                    //   Container(
                                    //     width: 25.r,
                                    //     height: 25.r,
                                    //     decoration: const BoxDecoration(
                                    //         color: NewColors.greencolor,
                                    //         shape: BoxShape.circle),
                                    //     child: Center(
                                    //         child: Text(
                                    //       "",
                                    //       style: TextStyle(
                                    //           fontSize: buildFontSize(25),
                                    //           color: NewColors.whitecolor,
                                    //           fontWeight: FontWeight.w500),
                                    //     )),
                                    //   ),
                                    // if (data.overallCompliance == 0 &&
                                    //     data.overallGrade == null &&
                                    //     data.condition == null)
                                    //   Container(
                                    //     width: 25.r,
                                    //     height: 25.r,
                                    //     decoration: const BoxDecoration(
                                    //         color: NewColors.red,
                                    //         shape: BoxShape.circle),
                                    //     child: Center(
                                    //         child: Text(
                                    //       "",
                                    //       style: TextStyle(
                                    //           fontSize: buildFontSize(25),
                                    //           color: NewColors.whitecolor,
                                    //           fontWeight: FontWeight.w500),
                                    //     )),
                                    //   ),
                                    // if (data.overallCompliance == 2 &&
                                    //     data.overallGrade == null &&
                                    //     data.condition == null)
                                    //   Container(
                                    //     width: 25.r,
                                    //     height: 25.r,
                                    //     decoration: const BoxDecoration(
                                    //         color: NewColors.primary,
                                    //         shape: BoxShape.circle),
                                    //     child: Center(
                                    //         child: Text(
                                    //       "",
                                    //       style: TextStyle(
                                    //           fontSize: buildFontSize(25),
                                    //           color: NewColors.whitecolor,
                                    //           fontWeight: FontWeight.w500),
                                    //     )),
                                    //   ),
                                    // if (data.overallGrade == "C")
                                    //   Container(
                                    //     width: 25.r,
                                    //     height: 25.r,
                                    //     decoration: const BoxDecoration(
                                    //         color: NewColors.red,
                                    //         shape: BoxShape.circle),
                                    //     child: Center(
                                    //         child: Text(
                                    //       "C",
                                    //       style: TextStyle(
                                    //           fontSize: buildFontSize(25),
                                    //           color: NewColors.whitecolor,
                                    //           fontWeight: FontWeight.w500),
                                    //     )),
                                    //   ),
                                    // SizedBox(
                                    //   width: 10.r,
                                    // ),
                                    Expanded(
                                      child: Text(
                                        data2.name ?? "",
                                        style: TextStyle(
                                          fontWeight: mediumFontWeight,
                                          fontSize: buildFontSize(35),
                                          color: NewColors.black,
                                        ),
                                      ),
                                    ),
                                    // if (data.condition == null &&
                                    //     data.overallGrade == null)
                                    Icon(
                                      Icons.arrow_forward,
                                      color: NewColors.black,
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                  SizedBox(
                    height: 100.r,
                  )
                ],
              ),
        bottomSheet: inspectionCategoryitemData.data != null &&
                inspectionCategoryitemData.data?.length == 0
            ? SizedBox()
            : Container(
                color: NewColors.whitecolor,
                padding: EdgeInsets.all(25.r),
                child: NxtBtn(
                  onTap: () {
                    inspectionProvider.checkAndNaviagte(context);
                  },
                  text: "Generate Report",
                ),
              ),
      );
    });
  }
}
