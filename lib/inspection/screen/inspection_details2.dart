import 'package:fixlah/config/colors.dart';
import 'package:fixlah/config/constants.dart';
import 'package:fixlah/config/sizes.dart';
import 'package:fixlah/config/text_fields.dart';
import 'package:fixlah/config/utils.dart';
import 'package:fixlah/inspection/model/inspection_get_model.dart';
import 'package:fixlah/inspection/provider/inspection_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class InspectionDetails2 extends StatefulWidget {
  const InspectionDetails2({super.key});

  @override
  State<InspectionDetails2> createState() => _InspectionDetails2State();
}

class _InspectionDetails2State extends State<InspectionDetails2> {
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
                  // Text(
                  //   inspectionTemplate.name ?? "-",
                  //   style: TextStyle(
                  //     fontSize: buildFontSize(35),
                  //     fontWeight: boldFontWeight,
                  //     color: NewColors.inspectionscolor,
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: aspectRatio * 40,
                  // ),
                  // TextFieldTitle(label: "Inspection Description"),
                  // SizedBox(
                  //   height: 10.r,
                  // ),
                  // Container(
                  //   padding:
                  //       EdgeInsets.symmetric(horizontal: 15.r, vertical: 10.r),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(100),
                  //     border: Border.all(
                  //       width: 2,
                  //       color: NewColors.secondayFullcolor,
                  //     ),
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //           child: Text(
                  //         inspectionDescription.text,
                  //       ))
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10.r,
                  // ),
                  // const Divider(
                  //   color: NewColors.secondaycolor,
                  // ),
                  // SizedBox(
                  //   height: 10.r,
                  // ),
                  Text(
                    "Inspection Items",
                    style: TextStyle(
                        fontSize: buildFontSize(30),
                        color: NewColors.textcolor),
                  ),
                  SizedBox(
                    height: 10.r,
                  ),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 10.r,
                    ),
                    shrinkWrap: true,
                    itemCount: inspectionData.data!.items!.length,
                    itemBuilder: (context, index) {
                      Items data = inspectionData.data!.items![index];

                      return InkWell(
                        onTap: () {
                          if (checkPermission(permit: "manage inspections"))
                            inspectionProvider.selectInspectionItem(context,
                                chossenItem: data);
                        },
                        child: Container(
                          padding: EdgeInsets.all(15.r),
                          decoration: BoxDecoration(
                              color: data.condition == null &&
                                      data.overallGrade == null
                                  ? NewColors.secondaryBgColor
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: NewColors.secondaycolor,
                              )),
                          child: Row(
                            children: [
                              if (data.condition == "Good")
                                Container(
                                  width: 25.r,
                                  height: 25.r,
                                  decoration: const BoxDecoration(
                                      color: NewColors.greencolor,
                                      shape: BoxShape.circle),
                                  child: const Icon(
                                    Icons.done,
                                    color: NewColors.whitecolor,
                                  ),
                                ),
                              if (data.condition == "Not Good")
                                Container(
                                  width: 25.r,
                                  height: 25.r,
                                  decoration: const BoxDecoration(
                                      color: NewColors.red,
                                      shape: BoxShape.circle),
                                  child: const Icon(
                                    Icons.close,
                                    color: NewColors.whitecolor,
                                  ),
                                ),
                              if (data.condition == "Not Applicable")
                                const Icon(
                                  Icons.error,
                                  color: NewColors.primary,
                                ),
                              if (data.condition == null &&
                                  data.overallGrade == null)
                                Container(
                                  width: 25.r,
                                  height: 25.r,
                                  decoration: const BoxDecoration(
                                      color: NewColors.secondaycolor,
                                      shape: BoxShape.circle),
                                ),
                              if (data.overallGrade == "A")
                                Container(
                                  width: 25.r,
                                  height: 25.r,
                                  decoration: const BoxDecoration(
                                      color: NewColors.greencolor,
                                      shape: BoxShape.circle),
                                  child: Center(
                                      child: Text(
                                    "A",
                                    style: TextStyle(
                                        fontSize: buildFontSize(25),
                                        color: NewColors.whitecolor,
                                        fontWeight: FontWeight.w500),
                                  )),
                                ),
                              if (data.overallGrade == "B")
                                Container(
                                  width: 25.r,
                                  height: 25.r,
                                  decoration: const BoxDecoration(
                                      color: NewColors.primary,
                                      shape: BoxShape.circle),
                                  child: Center(
                                      child: Text(
                                    "B",
                                    style: TextStyle(
                                        fontSize: buildFontSize(25),
                                        color: NewColors.whitecolor,
                                        fontWeight: FontWeight.w500),
                                  )),
                                ),
                              if (data.overallGrade == "C")
                                Container(
                                  width: 25.r,
                                  height: 25.r,
                                  decoration: const BoxDecoration(
                                      color: NewColors.red,
                                      shape: BoxShape.circle),
                                  child: Center(
                                      child: Text(
                                    "C",
                                    style: TextStyle(
                                        fontSize: buildFontSize(25),
                                        color: NewColors.whitecolor,
                                        fontWeight: FontWeight.w500),
                                  )),
                                ),
                              SizedBox(
                                width: 10.r,
                              ),
                              Expanded(
                                child: Text(
                                  data.category?.name ?? "",
                                  style: TextStyle(
                                    fontWeight: mediumFontWeight,
                                    fontSize: buildFontSize(35),
                                    color: NewColors.black,
                                  ),
                                ),
                              ),
                              if (data.condition == null &&
                                  data.overallGrade == null)
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
        bottomSheet: Container(
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
