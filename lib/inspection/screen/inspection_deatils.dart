import 'package:fixlah/config/colors.dart';
import 'package:fixlah/config/sizes.dart';
import 'package:fixlah/config/text_fields.dart';
import 'package:fixlah/config/utils.dart';
import 'package:fixlah/inspection/screen/inspection_details2.dart';
import 'package:flutter/material.dart';

class InspectionDeatils extends StatefulWidget {
  const InspectionDeatils({super.key});

  @override
  State<InspectionDeatils> createState() => _InspectionDeatilsState();
}

class _InspectionDeatilsState extends State<InspectionDeatils> {
  TextEditingController name = TextEditingController();
  TextEditingController facilityname = TextEditingController();
  TextEditingController block = TextEditingController();
  TextEditingController unitNo = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    name.dispose();
    facilityname.dispose();
    block.dispose();
    unitNo.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: generalAppBar(context,
          title: "Unit Details",
          newColor: NewColors.inspectionscolor,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  size: aspectRatio * 50,
                  color: NewColors.whitecolor,
                  Icons.close,
                ))
          ]),
      body: ListView(
        padding: EdgeInsets.all(aspectRatio * 50),
        children: [
          CustomTextFields(
              label: "Client Name", controller: name, hintText: "Enter Name"),
          SizedBox(
            height: aspectRatio * 20,
          ),
          CustomTextFields(
              label: "Facility Name",
              controller: facilityname,
              hintText: "Enter Facility Name"),
          SizedBox(
            height: aspectRatio * 20,
          ),
          CustomTextFields(
              label: "Block", controller: block, hintText: "Block"),
          SizedBox(
            height: aspectRatio * 20,
          ),
          CustomTextFields(
              label: "Unit No", controller: unitNo, hintText: "Enter Unit No"),
          SizedBox(
            height: aspectRatio * 20,
          ),
        ],
      ),
      bottomSheet: Container(
        color: NewColors.whitecolor,
        padding: EdgeInsets.all(aspectRatio * 20),
        child: NxtBtn(
          text: "Next",
          onTap: () {
            naviagteTo(context, builder: (context) => InspectionDetails2());
          },
        ),
      ),
    );
  }
}
