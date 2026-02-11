import 'dart:developer';

import 'package:fixlah/config/colors.dart';
import 'package:fixlah/config/sizes.dart';
import 'package:fixlah/config/text_fields.dart';
import 'package:fixlah/config/utils.dart';
import 'package:fixlah/config/validators.dart';
import 'package:fixlah/facilities/model/block_list_model.dart';
import 'package:fixlah/facilities/model/location_tag_model.dart';
import 'package:fixlah/facilities/model/unit_data_model.dart';
import 'package:fixlah/facilities/provider/facilities_provider.dart';
import 'package:fixlah/inspection/model/inspection_toRun_model.dart';
import 'package:fixlah/inspection/provider/inspection_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class StartInspection extends StatefulWidget {
  const StartInspection({super.key});

  @override
  State<StartInspection> createState() => _StartInspectionState();
}

class _StartInspectionState extends State<StartInspection> {
  final _key = GlobalKey<FormState>();
  TextEditingController block = TextEditingController();
  TextEditingController unitNo = TextEditingController();
  Map<String, dynamic> data = {};
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      InspectionProvider inspectionProvider = Provider.of<InspectionProvider>(
        context,
        listen: false,
      );
      FacilitiesProvider facilitiesProvider = Provider.of<FacilitiesProvider>(
        context,
        listen: false,
      );
      if (inspectionProvider.qrlocationTagData != null) {
        LocationTagData locationTagData = inspectionProvider.qrlocationTagData!;
        if (locationTagData.unit != null) {
          unitNo.text = locationTagData.unit?.unitNo ?? "";
          facilitiesProvider.getUnit(context,
              facilityId: locationTagData.facility!.id!.toString(),
              blockId: locationTagData.block!.id.toString(),
              floors: [Floors.fromJson(locationTagData.floor!.toJson())]);
          data.addAll({
            'facility_block_id': locationTagData.block!.id,
            'facility_unit_id': locationTagData.unit!.id,
          });
        }
        block.text = locationTagData.block?.name ?? "";
      }
      facilitiesProvider.getBlock(context,
          facilityId: inspectionProvider.toRuninspectionData.facility?.id ?? 0);
      data.addAll({
        'inspection_template_id': inspectionProvider.toRuninspectionData.id,
        'facility_id': inspectionProvider.toRuninspectionData.facility?.id,
        'start_date': formateDate(value: DateTime.now().toString()),
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    block.dispose();
    unitNo.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<InspectionProvider>(
        builder: (context, inspectionProvider, child) {
      return Consumer<FacilitiesProvider>(
          builder: (context, facilitiesProvider, child) {
        return Stack(
          children: [
            Scaffold(
              appBar: generalAppBar(context,
                  title: "Inspection Details",
                  newColor: NewColors.inspectionscolor,
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        icon: Icon(
                          size: 25.r,
                          color: NewColors.whitecolor,
                          Icons.close,
                        ))
                  ]),
              body: Consumer<InspectionProvider>(
                  builder: (context, inspectionProvider, child) {
                final InspectionDataItem inspectionData =
                    inspectionProvider.toRuninspectionData;
                return Consumer<FacilitiesProvider>(
                    builder: (context, facilitiesProvider, child) {
                  return Form(
                    key: _key,
                    child: Padding(
                      padding: EdgeInsets.all(30.r),
                      child: Column(
                        children: [
                          // Facility name
                          CustomTextFields(
                            label: "Facility Name",
                            hintText: "Enter Facility Name",
                            validator: Validators.validateRequired,
                            readOnly: true,
                            initialValue: inspectionData.facility?.name ?? "-",
                          ),
                          SizedBox(
                            height: 10.r,
                          ),
                          // Block name
                          CustomTextFields(
                            label: "Block",
                            hintText: "Select Block",
                            validator: inspectionData.unitSpecific == "Unit"
                                ? Validators.validateRequired
                                : null,
                            readOnly: true,
                            onTap: () {
                              openDialogue(context,
                                  title: "Select Block",
                                  data: SizedBox(
                                    width: fullWidth - 200,
                                    height: fullHeight / 2,
                                    child: ListView.builder(
                                      itemCount: facilitiesProvider
                                          .blockResponse.length,
                                      itemBuilder: (context, index) {
                                        BlockResponse blockResponse =
                                            facilitiesProvider
                                                .blockResponse[index];
                                        return ListTile(
                                          onTap: () {
                                            block.text = blockResponse.name!;
                                            data.addAll({
                                              'facility_block_id':
                                                  blockResponse.id,
                                            });
                                            unitNo.clear();

                                            setState(() {});
                                            Navigator.pop(context);
                                            facilitiesProvider.getUnit(context,
                                                facilityId: inspectionData
                                                    .facility!.id!
                                                    .toString(),
                                                blockId:
                                                    blockResponse.id.toString(),
                                                floors: blockResponse.floors!);
                                          },
                                          title:
                                              Text(blockResponse.name ?? "-"),
                                        );
                                      },
                                    ),
                                  ));
                            },
                            controller: block,
                          ),
                          SizedBox(
                            height: 10.r,
                          ),
                          // Unit  No name
                          if (inspectionData.unitSpecific == "Unit")
                            CustomTextFields(
                              label: "Unit No",
                              hintText: "Select Unit No",
                              validator: Validators.validateRequired,
                              readOnly: true,
                              onTap: () {
                                openDialogue(context,
                                    title: "Select Unit",
                                    data: SizedBox(
                                      width: fullWidth - 200,
                                      height: fullHeight / 2,
                                      child: ListView.builder(
                                        itemCount:
                                            facilitiesProvider.unitList.length,
                                        itemBuilder: (context, index) {
                                          UnitData unitData = facilitiesProvider
                                              .unitList[index];
                                          return ListTile(
                                            onTap: () {
                                              unitNo.text = unitData.unitNo!;
                                              data.addAll({
                                                'facility_unit_id': unitData.id,
                                              });
                                              setState(() {});
                                              Navigator.pop(context);
                                            },
                                            title: Text(unitData.unitNo ?? "-"),
                                          );
                                        },
                                      ),
                                    ));
                              },
                              controller: unitNo,
                            ),
                          const Expanded(child: SizedBox()),
                          NxtBtn(
                            text: "Next",
                            onTap: () {
                              if (_key.currentState!.validate()) {
                                log(data.toString());
                                inspectionProvider.checkDuplicate(context,
                                    body: {
                                      "inspection_template_id":
                                          inspectionData.id,
                                      "facility_id": inspectionData.facilityId,
                                      "start_date": DateFormat("yyyy-MM-dd")
                                          .format(DateTime.now()),
                                      "facility_block_id":
                                          data['facility_block_id'] ?? "",
                                      "facility_unit_id":
                                          data['facility_unit_id'] ?? ""
                                    },
                                    inspbody: data);
                                // inspectionProvider.createInspection(context,
                                //     body: data);
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  );
                });
              }),
            ),
            if (facilitiesProvider.loading || inspectionProvider.loading)
              const FullPageLoadingWidget()
          ],
        );
      });
    });
  }
}
