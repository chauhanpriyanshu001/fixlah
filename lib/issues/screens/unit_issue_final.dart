import 'dart:developer';
import 'dart:io';

import 'package:fixlah/config/colors.dart';
import 'package:fixlah/config/constants.dart';
import 'package:fixlah/config/custom_widgets.dart';
import 'package:fixlah/config/sizes.dart';
import 'package:fixlah/config/text_fields.dart';
import 'package:fixlah/config/utils.dart';
import 'package:fixlah/config/validators.dart';
import 'package:fixlah/home/model/area_response_model.dart';
import 'package:fixlah/home/model/issue_categories_data.dart';
import 'package:fixlah/home/provider/home_provider.dart';

import 'package:fixlah/issues/provider/issues_provider.dart';
import 'package:fixlah/issues/screens/unit_issue_3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UnitIssueFinal extends StatefulWidget {
  const UnitIssueFinal({super.key});

  @override
  State<UnitIssueFinal> createState() => _UnitIssueFinalState();
}

class _UnitIssueFinalState extends State<UnitIssueFinal> {
  List issueType = ["Urgent", "Not Urgent"];
  List issueCategories = ["Wear & Tear", "Others"];

  String selctedValue = "";
  String selctedUnitLocation = "";
  String selctedissueCategories = "";
  TextEditingController issueItem = TextEditingController();
  TextEditingController issueRemark = TextEditingController();
  var _key = GlobalKey<FormState>();
  // List issueItems = [
  //   {"location": "", "type": "", "item": "", "remark": "", "images": []}
  // ];
  @override
  Widget build(BuildContext context) {
    return Consumer<IssuesProvider>(builder: (context, issuesProvider, child) {
      if (issuesProvider.createIssue['items[0][remarks]'] != null &&
          issueRemark.text.isEmpty) {
        issueRemark.text = issuesProvider.createIssue['items[0][remarks]'];
      }
      return Consumer<HomeProvider>(builder: (context, homeProvider, child) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: NewColors.scafoldbgcolor,
              appBar: generalAppBar(
                context,
                title: "Create Issue",
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                        // naviagteToandreplace(context,
                        //     builder: (context) => const HomeScreen());
                      },
                      icon: const Icon(
                        Icons.close,
                        color: NewColors.whitecolor,
                      ))
                ],
              ),
              body: SingleChildScrollView(
                padding: EdgeInsets.all(20.r),
                child: Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: aspectRatio * 20,
                      ),
                      // Urgent and not urgent
                      Row(
                        children: [
                          Expanded(
                              child: selectionWidget(
                                  selected: selctedValue == issueType[0],
                                  title: issueType[0],
                                  // isFilled: true,
                                  onTap: () {
                                    selctedValue = issueType[0];
                                    issuesProvider.createIssueDataController(
                                        {"priority": "yes"});
                                    setState(() {});
                                  },
                                  primaryColor: Colors.red,
                                  secondayColor: Colors.transparent)),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: selectionWidget(
                                  selected: selctedValue == issueType[1],
                                  title: issueType[1],
                                  // isFilled: true,
                                  onTap: () {
                                    selctedValue = issueType[1];
                                    issuesProvider.createIssueDataController(
                                        {"priority": "no"});
                                    setState(() {});
                                  },
                                  primaryColor: Colors.green,
                                  secondayColor: Colors.transparent))
                        ],
                      ),
                      SizedBox(
                        height: aspectRatio * 20,
                      ),
                      const TitleWidget1(
                        title: 'Issue Category',
                      ),
                      SizedBox(
                        height: 10.r,
                      ),
                      Wrap(
                        children: List.generate(
                            issueCategoriesDataResponse.length, (index) {
                          IssueCategorieData issueCategoriesData =
                              issueCategoriesDataResponse[index];
                          return Padding(
                              padding: EdgeInsets.all(5.r),
                              child: FilterChip(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.r, horizontal: 10.r),
                                color: const WidgetStatePropertyAll(
                                    NewColors.whitecolor),
                                side: BorderSide(
                                  width: 2,
                                  color: issueCategoriesData.name ==
                                          selctedissueCategories
                                      ? NewColors.primary
                                      : NewColors.secondayFullcolor,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60),
                                    side: BorderSide(
                                      color: issueCategoriesData.name ==
                                              selctedissueCategories
                                          ? NewColors.primary
                                          : NewColors.secondaycolor,
                                      width: 2,
                                    )),
                                label: Text(
                                  maxLines: 2,
                                  issueCategoriesData.name.toString(),
                                  style: TextStyle(
                                      color: NewColors.black,
                                      fontSize: buildFontSize(30)),
                                ),
                                onSelected: (value) {
                                  selctedissueCategories =
                                      issueCategoriesData.name!;
                                  issuesProvider.createIssueDataController(
                                      {"issue_type": selctedissueCategories});
                                  setState(() {});
                                },
                              ));
                        }),
                      ),
                      SizedBox(
                        height: 10.r,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: issuesProvider.itemCount,
                        itemBuilder: (context, parentindex) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Divider(
                                color: NewColors.secondayFullcolor,
                              ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Item-${parentindex + 1}",
                                    style: TextStyle(
                                        fontWeight: mediumFontWeight,
                                        fontSize: buildFontSize(30),
                                        color: NewColors.black),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      issuesProvider.removeIssueDataController(
                                          "items[${parentindex}][area_id]");
                                      issuesProvider.removeIssueDataController(
                                          "items[${parentindex}][issue_type][0]");
                                      issuesProvider.removeIssueDataController(
                                          "items[${parentindex}][item]");
                                      issuesProvider.removeIssueDataController(
                                          "items[${parentindex}][remarks]");
                                      issuesProvider.removeIssueDataController(
                                          "items[${parentindex}][done_by]");
                                      issuesProvider.removeIssueDataController(
                                          "items[$parentindex][photos][]");
                                      issuesProvider.setItemCount(
                                          issuesProvider.itemCount - 1);
                                    },
                                    child: Icon(
                                      size: 20.r,
                                      Icons.delete,
                                      color: NewColors.red,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10.r,
                              ),
                              // Unit Location Selection
                              const TitleWidget1(
                                title: 'Unit Location',
                              ),

                              SizedBox(
                                height: 10.r,
                              ),

                              Wrap(
                                children: List.generate(
                                    areaListResponse!.total!, (index) {
                                  AreaData unitLocationData =
                                      areaListResponse!.data![index];
                                  return Padding(
                                    padding: EdgeInsets.all(5.r),
                                    child: FilterChip(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.r, horizontal: 10.r),
                                      color: const WidgetStatePropertyAll(
                                          NewColors.whitecolor),
                                      side: BorderSide(
                                        width: 2,
                                        color: unitLocationData.id ==
                                                issuesProvider.createIssue[
                                                    "items[${parentindex}][area_id]"]
                                            ? NewColors.primary
                                            : NewColors.secondaycolor,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(60),
                                          side: BorderSide(
                                            color: unitLocationData.id ==
                                                    issuesProvider.createIssue[
                                                        "items[${parentindex}][area_id]"]
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
                                        // issueItems[parentindex]['location'] =
                                        //     unitLocationData.name ?? "-";
                                        issuesProvider
                                            .createIssueDataController({
                                          "items[${parentindex}][area_id]":
                                              unitLocationData.id
                                        });
                                      },
                                    ),
                                  );
                                }),
                              ),

                              // Issue Category
                              SizedBox(
                                height: 10.r,
                              ),
                              const TitleWidget1(
                                title: 'Issue Type',
                              ),
                              SizedBox(
                                height: 10.r,
                              ),
                              DropdownButtonFormField(
                                  icon: Icon(
                                    size: 20.r,
                                    Icons.arrow_drop_down_circle_sharp,
                                    color: NewColors.secondayFullcolor,
                                  ),
                                  style: TextStyle(
                                      fontSize: buildFontSize(30),
                                      color: NewColors.black),
                                  dropdownColor: NewColors.whitecolor,
                                  decoration: InputDecoration(
                                    errorStyle: TextStyle(fontSize: 0),
                                    errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color:
                                                Color.fromARGB(255, 255, 1, 1),
                                            width: 2),
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 15.r, horizontal: 15.r),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: const BorderSide(
                                          color: NewColors.secondayFullcolor,
                                          width: 2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: const BorderSide(
                                          color: NewColors.primary, width: 2),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: const BorderSide(
                                          color: NewColors.secondayFullcolor,
                                          width: 2),
                                    ),
                                  ),
                                  items: issueTypeDataDropDownlistList,
                                  validator: (value) {
                                    if (value == null) {
                                      return "Select Value";
                                    }
                                    return null;
                                  },
                                  hint: Text(
                                    "Select Issue Type",
                                  ),
                                  onChanged: (value) {
                                    print(value);

                                    // issueItems[parentindex]['type'] =
                                    //     value!.name;
                                    issuesProvider.createIssueDataController({
                                      "items[${parentindex}][issue_type][0]":
                                          value!.name
                                    });
                                  }),
                              SizedBox(
                                height: 10.r,
                              ),
                              CustomTextFields(
                                // controller: issueItem,
                                initialValue: issuesProvider.createIssue[
                                        "items[${parentindex}][item]"] ??
                                    "",
                                label: "Issue Item",
                                onChanged: (val) {
                                  // issueItems[parentindex]['item'] = val;
                                  issuesProvider.createIssue.addAll({
                                    "items[${parentindex}][item]": val,
                                  });
                                  setState(() {});
                                },
                                validator: Validators.validateRequired,
                                hintText: "Enter Issue Item",
                              ),
                              CustomTextFields(
                                // controller: issueRemark,
                                initialValue: issuesProvider.createIssue[
                                        "items[${parentindex}][item]"] ??
                                    "",
                                label: "Issue Remark",
                                onChanged: (val) {
                                  // issueItems[parentindex]['remark'] = val;
                                  issuesProvider.createIssue.addAll({
                                    "items[${parentindex}][remarks]": val,
                                  });
                                  setState(() {});
                                },
                                validator: Validators.validateRequired,
                                hintText: "Enter Issue Remark",
                              ),
                              // CustomTextFields(
                              //     label: "Issue Item",
                              //     readOnly: true,
                              //     validator: Validators.validateRequired,
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
                              //                 itemBuilder: (context, index) {
                              //                   IssueItemData issueItemData =
                              //                       issuesProvider.itemAssetsResponse
                              //                           .data![index];
                              //                   return ListTile(
                              //                     onTap: () {
                              //                       issueItem.text =
                              //                           issueItemData.name!;
                              //                       issuesProvider
                              //                           .createIssueDataController({
                              //                         "items[${issuesProvider.itemCount}][asset_id]":
                              //                             issueItemData.id,
                              //                         "items[${issuesProvider.itemCount}][quantity]":
                              //                             1.toString(),
                              //                         "items[${issuesProvider.itemCount}][charge]":
                              //                             issueItemData.sellingPrice,
                              //                       });
                              //                       print(issuesProvider.createIssue);
                              //                       setState(() {});
                              //                       Navigator.pop(context);
                              //                     },
                              //                     title:
                              //                         Text(issueItemData.name ?? ""),
                              //                   );
                              //                 },
                              //               ),
                              //             ));
                              //       }
                              //     },
                              //     controller: issueItem,
                              //     hintText: "Issue Item"),
                              SizedBox(
                                height: 10.r,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextFieldTitle(label: "Images"),
                                  if (issuesProvider.finalImges.length < 5)
                                    IconButton(
                                        onPressed: () {
                                          // naviagteTo(context,
                                          //     builder: (context) =>
                                          //         CameraCaptureScreen(
                                          //           goBack: true,
                                          //         ));
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CameraCaptureScreen(
                                                        goBack: false,
                                                      ))).then((val) {
                                            if (issuesProvider.createIssue[
                                                    "items[$parentindex][photos][]"] !=
                                                null) {
                                              issuesProvider.createIssue[
                                                      "items[$parentindex][photos][]"]
                                                  .add(val.path);
                                            } else {
                                              issuesProvider.createIssue
                                                  .addAll({
                                                "items[$parentindex][photos][]":
                                                    [val.path],
                                              });
                                            }
                                            print("Data");
                                            log(issuesProvider
                                                .createIssue[
                                                    "items[$parentindex][photos][]"]
                                                .length
                                                .toString());

                                            // issueItems[parentindex]['images']
                                            //     .add(val);
                                            setState(() {});
                                            // print(issueItems[parentindex]
                                            //     ['images']);
                                          });
                                        },
                                        icon: Icon(Icons.add))
                                ],
                              ),

                              SizedBox(
                                height: 10.r,
                              ),
                              // Images
                              Wrap(
                                  children: List.generate(
                                      issuesProvider.createIssue[
                                                  "items[$parentindex][photos][]"] ==
                                              null
                                          ? 0
                                          : issuesProvider
                                              .createIssue[
                                                  "items[$parentindex][photos][]"]
                                              .length, (index) {
                                XFile file = XFile(issuesProvider.createIssue[
                                    "items[$parentindex][photos][]"][index]);
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Stack(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        width: 150.r,
                                        height: 150.r,
                                        decoration: BoxDecoration(
                                            color: NewColors.secondaryBgColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Image.file(File(file.path)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: NewColors.whitecolor),
                                          child: IconButton(
                                              onPressed: () {
                                                issuesProvider.createIssue[
                                                        "items[$parentindex][photos][]"]
                                                    .removeAt(index);
                                                setState(() {});
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                size: 20.r,
                                                color: NewColors.red,
                                              )),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              })),
                              SizedBox(
                                height: 20.r,
                              ),
                            ],
                          );
                        },
                      ),
                      NxtBtn(
                        text: "Add Item + ",
                        inverse: true,
                        onTap: () {
                          issuesProvider.createIssueDataController({
                            "items[${issuesProvider.itemCount}][done_by]":
                                "dormetry",
                          });
                          issuesProvider
                              .setItemCount(issuesProvider.itemCount + 1);
                          // issueItems.add({
                          //   "location": "",
                          //   "type": "",
                          //   "item": "",
                          //   "remark": "",
                          //   "images": []
                          // });
                        },
                      ),
                      SizedBox(
                        height: 10.r,
                      ),
                      NxtBtn(
                        text: "Submit",
                        onTap: () async {
                          if (issuesProvider.itemCount != 0) {
                            if (_key.currentState!.validate()) {
                              if (selctedValue != "" &&
                                  selctedissueCategories != "") {
                                print(issuesProvider.itemCount);
                                log(issuesProvider.createIssue.toString());
                                bool isError = false;
                                for (var i = 0;
                                    i < issuesProvider.itemCount;
                                    i++) {
                                  Map<String, dynamic> data =
                                      issuesProvider.createIssue;
                                  if (data["items[${i}][photos][]"] != null &&
                                      data["items[${i}][item]"] != null &&
                                      data["items[${i}][remarks]"] != null &&
                                      data["items[${i}][area_id]"] != null &&
                                      data["items[${i}][issue_type][0]"] !=
                                          null) {
                                    if (data["items[${i}][photos][]"].length !=
                                            0 &&
                                        data["items[${i}][item]"] != "" &&
                                        data["items[${i}][remarks]"] != "" &&
                                        data["items[${i}][area_id]"] != "" &&
                                        data["items[${i}][issue_type][0]"] !=
                                            "") {
                                      isError = false;
                                    } else {
                                      isError = true;
                                    }
                                  } else {
                                    isError = true;
                                  }
                                }
                                if (isError == false) {
                                  log("Done");
                                  await issuesProvider
                                      .createIssueApiRequest(context);
                                } else {
                                  Fluttertoast.showToast(
                                      textColor: NewColors.whitecolor,
                                      backgroundColor: NewColors.red,
                                      fontSize: 15.r,
                                      msg: "Please fill all mandatory fields");
                                }
                              } else {
                                Fluttertoast.showToast(
                                    textColor: NewColors.whitecolor,
                                    backgroundColor: NewColors.red,
                                    fontSize: 15.r,
                                    msg: "Please fill all mandatory fields");
                              }
                            }
                          } else {
                            Fluttertoast.showToast(
                                textColor: NewColors.whitecolor,
                                backgroundColor: NewColors.red,
                                fontSize: 15.r,
                                msg: "Please Add Atlest 1 Item");
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (issuesProvider.loading) FullPageLoadingWidget()
          ],
        );
      });
    });
  }
}
