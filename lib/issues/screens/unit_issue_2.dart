import 'dart:developer';

import 'package:fixlah/config/colors.dart';
import 'package:fixlah/config/custom_widgets.dart';
import 'package:fixlah/config/sizes.dart';
import 'package:fixlah/config/text_fields.dart';
import 'package:fixlah/config/utils.dart';
import 'package:fixlah/config/validators.dart';
import 'package:fixlah/facilities/model/block_list_model.dart';
import 'package:fixlah/facilities/model/client_data_model.dart';
import 'package:fixlah/facilities/model/facilities_model.dart';
import 'package:fixlah/facilities/model/unit_data_model.dart';
import 'package:fixlah/facilities/provider/facilities_provider.dart';

import 'package:fixlah/issues/provider/issues_provider.dart';
import 'package:fixlah/issues/screens/unit_issue_3.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class UnitIssue2 extends StatefulWidget {
  const UnitIssue2({super.key});

  @override
  State<UnitIssue2> createState() => _UnitIssue2State();
}

class _UnitIssue2State extends State<UnitIssue2> {
  TextEditingController clientName = TextEditingController();
  TextEditingController facilityName = TextEditingController();
  TextEditingController blocktName = TextEditingController();
  TextEditingController unitNo = TextEditingController();
  String issueType = "";
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<IssuesProvider>(builder: (context, issuesProvider, child) {
      String selectedIssueTypee = issuesProvider.issueType;
      return Consumer<FacilitiesProvider>(
          builder: (context, facilitiesProvider, child) {
        if (issuesProvider.qrData == true &&
            issuesProvider.loading == false &&
            facilitiesProvider.loading == false) {
          print("QR DATA");
          facilityName.text =
              issuesProvider.qrlocationTagData.facility?.name ?? "";
          blocktName.text = issuesProvider.qrlocationTagData.block?.name ?? "";
          unitNo.text = issuesProvider.qrlocationTagData.unit?.unitNo ?? "";

          clientName.text = issuesProvider.selectedClientName;
          if (issuesProvider.qrlocationTagData.unit?.creamUnit == "Yes") {
            issueType = "CREAM";
            print(issuesProvider.selectedClientName);
          } else {
            issueType = "NON-CREAM";
          }
        }
        return Stack(
          children: [
            Scaffold(
                appBar: generalAppBar(
                  context,
                  title: "Create Issue",
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        icon: Icon(
                          Icons.close,
                          size: 25.r,
                          color: NewColors.whitecolor,
                        ))
                  ],
                ),
                // Next Btn
                bottomSheet: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Consumer<IssuesProvider>(
                      builder: (context, issuesProvider, child) {
                    return NxtBtn(
                      text: "Next",
                      onTap: () async {
                        issuesProvider.changeQrStatus(false);
                        if (formKey.currentState!.validate()) {
                          log(issuesProvider.createIssue.toString());
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CameraCaptureScreen(
                                        goBack: false,
                                      ))).then((value) {
                            if (value) {
                              Navigator.pop(context, true);
                            }
                          });
                          // await naviagteTo(context,
                          //     builder: (context) => const CameraCaptureScreen(
                          //           goBack: false,
                          //         ));
                        }
                      },
                    );
                  }),
                ),
                body: Form(
                  key: formKey,
                  child: ListView(
                    padding: const EdgeInsets.all(30),
                    children: [
                      // Client name
                      if (selectedIssueTypee == "Unit")
                        CustomTextFields(
                            label: "Client Name",
                            controller: clientName,
                            readOnly: true,
                            hintText: "Enter Client Name"),
                      SizedBox(
                        height: aspectRatio * 20,
                      ),
                      CustomTextFields(
                          label: "Facility Name",
                          controller: facilityName,
                          validator: Validators.validateRequired,
                          onTap: () {
                            issuesProvider.changeQrStatus(false);
                            openDialogue(context, title: "Select Facility",
                                data: Consumer<FacilitiesProvider>(builder:
                                    (context, facilitiesProvider, child) {
                              return SizedBox(
                                width: fullWidth - 200,
                                height: fullHeight / 4,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: facilitiesProvider
                                      .facilityList.data!.data!.length,
                                  itemBuilder: (context, index) {
                                    FacilityData facilitiData =
                                        facilitiesProvider
                                            .facilityList.data!.data![index];
                                    return facilitiesProvider
                                            .selectedFacilitiesName
                                            .contains(facilitiData.name!)
                                        ? ListTile(
                                            onTap: () {
                                              issuesProvider
                                                  .createIssueDataController({
                                                "client_id": "",
                                                "facility_block_id": "",
                                                "facility_unit_id": "",
                                                "cream_unit": "",
                                              });
                                              clientName.text = "";
                                              blocktName.text = "";
                                              unitNo.text = "";
                                              issueType = "";
                                              facilitiesProvider.getBlock(
                                                  context,
                                                  facilityId: facilitiData.id!);

                                              facilityName.text =
                                                  facilitiData.name!;
                                              issuesProvider
                                                  .createIssueDataController({
                                                "facility_id": facilitiData.id!
                                              });
                                              issuesProvider.getAssets(context);
                                              Navigator.pop(context);
                                            },
                                            title: Text(
                                              facilitiData.name ?? "",
                                              style: TextStyle(
                                                  color: NewColors.black,
                                                  fontWeight: mediumFontWeight,
                                                  fontSize: buildFontSize(30)),
                                            ),
                                          )
                                        : SizedBox();
                                  },
                                ),
                              );
                            }));
                          },
                          readOnly: true,
                          hintText: "Enter Facility Name"),
                      SizedBox(
                        height: aspectRatio * 20,
                      ),
                      CustomTextFields(
                          label: "Block",
                          validator: Validators.validateRequired,
                          controller: blocktName,
                          readOnly: true,
                          onTap: () async {
                            issuesProvider.changeQrStatus(false);
                            log(facilitiesProvider.blockResponse.toString());
                            facilitiesProvider.blockResponse.length != 0
                                ? openBlock(
                                    context, issuesProvider, selectedIssueTypee)
                                : await facilitiesProvider
                                    .getBlock(context,
                                        facilityId: issuesProvider
                                            .createIssue['facility_id'])
                                    .then((value) {
                                    openBlock(context, issuesProvider,
                                        selectedIssueTypee);
                                  });
                            ;
                          },
                          hintText: "Enter Block"),
                      SizedBox(
                        height: aspectRatio * 20,
                      ),
                      //  Unit
                      if (selectedIssueTypee == "Unit")
                        CustomTextFields(
                            label: "Unit No",
                            controller: unitNo,
                            readOnly: true,
                            validator: Validators.validateRequired,
                            onTap: () async {
                              issuesProvider.changeQrStatus(false);
                              if (facilitiesProvider.unitList.length != 0) {
                                await openUnit(context, facilitiesProvider,
                                    issuesProvider);
                              } else {
                                if (selectedIssueTypee == "Unit" &&
                                    blocktName.text != "" &&
                                    facilitiesProvider.blockResponse.length !=
                                        0) {
                                  int? tempInd = facilitiesProvider
                                      .blockResponse
                                      .indexWhere((data) =>
                                          data.name == blocktName.text);
                                  if (tempInd != -1) {
                                    BlockResponse blockResponse =
                                        facilitiesProvider
                                            .blockResponse[tempInd];
                                    facilitiesProvider.getUnit(context,
                                        facilityId: issuesProvider
                                            .createIssue['facility_id']
                                            .toString(),
                                        blockId: blockResponse.id!.toString(),
                                        floors: blockResponse.floors!);
                                  }
                                }
                              }
                            },
                            hintText: "Enter Unit No"),
                      SizedBox(
                        height: aspectRatio * 20,
                      ),
                      // Cream and non Cream
                      if (selectedIssueTypee == "Unit")
                        Row(
                          children: [
                            Expanded(
                                child: selectionWidget(
                                    selected: issueType == "CREAM",
                                    title: "CREAM",
                                    isFilled: true,
                                    primaryColor: NewColors.greencolor,
                                    secondayColor: Colors.transparent)),
                            Expanded(
                                child: selectionWidget(
                                    selected: issueType == "NON-CREAM",
                                    title: "NON-CREAM",
                                    isFilled: true,
                                    primaryColor: Colors.red,
                                    secondayColor: Colors.transparent)),
                          ],
                        )
                    ],
                  ),
                )),
            if (issuesProvider.loading || facilitiesProvider.loading)
              const FullPageLoadingWidget()
          ],
        );
      });
    });
  }

  Future<dynamic> openUnit(BuildContext context,
      FacilitiesProvider facilitiesProvider, IssuesProvider issuesProvider) {
    return openDialogue(context,
        title: "Select Unit No",
        data: SizedBox(
          width: fullWidth - 100,
          height: fullHeight / 2,
          child: ListView.builder(
            itemCount: facilitiesProvider.unitList.length,
            itemBuilder: (context, index) {
              UnitData unitData = facilitiesProvider.unitList[index];
              return ListTile(
                title: Text(
                  unitData.unitNo ?? "-",
                  style: TextStyle(
                      color: NewColors.black,
                      fontWeight: mediumFontWeight,
                      fontSize: buildFontSize(35)),
                ),
                onTap: () async {
                  unitNo.text = unitData.unitNo ?? "";
                  setState(() {});
                  issuesProvider.createIssueDataController(
                      {"facility_unit_id": unitData.id});

                  clientName.text = await facilitiesProvider.getClient(context,
                      unitId: unitData.id.toString());

                  ClientData clientData = facilitiesProvider.selectedClient;
                  if (clientData.client?.id != null) {
                    issuesProvider.createIssueDataController(
                        {"client_id": clientData.client?.id!});
                  }
                  if (unitData.creamUnit == "Yes") {
                    issueType = "CREAM";
                    issuesProvider.createIssueDataController({"cream_unit": 1});
                    if (facilitiesProvider.selectedClient != ClientData()) {
                      ClientData clientData = facilitiesProvider.selectedClient;
                      issuesProvider.createIssueDataController(
                          {"client_id": clientData.client?.id!});
                      clientName.text = clientData.client?.name ?? "-";
                    }

                    setState(() {});
                  } else {
                    issueType = "NON-CREAM";
                    issuesProvider.createIssueDataController({"cream_unit": 0});
                    setState(() {});
                  }

                  Navigator.pop(context);
                },
              );
            },
          ),
        ));
  }

  Future<dynamic> openBlock(BuildContext context, IssuesProvider issuesProvider,
      String selectedIssueTypee) {
    return openDialogue(context, title: "Select Block", data:
        Consumer<FacilitiesProvider>(
            builder: (context, facilitiesProvider, child) {
      return SizedBox(
        width: fullWidth - 200,
        height: fullHeight / 2,
        child: ListView.builder(
          itemCount: facilitiesProvider.blockResponse.length,
          itemBuilder: (context, index) {
            BlockResponse blockResponse =
                facilitiesProvider.blockResponse[index];
            return ListTile(
              onTap: () {
                issuesProvider.createIssueDataController({
                  "client_id": "",
                  "facility_unit_id": "",
                  "cream_unit": "",
                });
                clientName.text = "";
                blocktName.text = "";
                unitNo.text = "";
                issueType = "";
                log(blockResponse.floors.toString());
                print(blockResponse.floors!.length);
                print(blockResponse.floors![0].name ?? "--");
                // print(blockResponse.onefmBlockInternalId ??
                //     "--");
                // print(blockResponse.facilityId ?? "--");

                issuesProvider.createIssueDataController(
                    {"facility_block_id": blockResponse.id!});
                if (selectedIssueTypee == "Unit") {
                  facilitiesProvider.getUnit(context,
                      facilityId:
                          issuesProvider.createIssue['facility_id'].toString(),
                      blockId: blockResponse.id!.toString(),
                      floors: blockResponse.floors!);
                } else {
                  issuesProvider.createIssueDataController(
                      {"client_id": "", "cream_unit": 0});

                  issueType = "NON-CREAM";
                  setState(() {});
                }

                blocktName.text = blockResponse.name!;
                setState(() {});
                Navigator.pop(context);
              },
              title: Text(blockResponse.name ?? "-",
                  style: TextStyle(
                      color: NewColors.black,
                      fontWeight: mediumFontWeight,
                      fontSize: buildFontSize(35))),
            );
          },
        ),
      );
    }));
  }
}

class CheckBoxWidget extends StatelessWidget {
  const CheckBoxWidget({
    super.key,
    required this.issueType,
  });

  final String issueType;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile.adaptive(
      contentPadding: EdgeInsets.all(10.r),
      tileColor:
          issueType == "NON-CREAM" ? NewColors.red : NewColors.whitecolor,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60),
          borderSide: BorderSide(
            color: issueType == "NON-CREAM"
                ? NewColors.whitecolor
                : NewColors.secondaycolor,
            width: 2,
          )),
      checkboxShape: const CircleBorder(),
      checkColor: NewColors.red,
      controlAffinity: ListTileControlAffinity.leading,
      fillColor: const WidgetStatePropertyAll(NewColors.whitecolor),
      title: Text(
        "NON-CREAM",
        style: TextStyle(
          fontWeight: mediumFontWeight,
          fontSize: buildFontSize(30),
          color:
              issueType == "NON-CREAM" ? NewColors.whitecolor : NewColors.black,
        ),
      ),
      value: issueType == "NON-CREAM",
      onChanged: (value) {
        // print(value);
        // issueType = "NON-CREAM";
        // setState(() {});
      },
    );
  }
}
