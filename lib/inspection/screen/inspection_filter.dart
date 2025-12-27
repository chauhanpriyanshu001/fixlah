import 'package:fixlah/config/colors.dart';
import 'package:fixlah/config/sizes.dart';
import 'package:fixlah/config/utils.dart';
import 'package:fixlah/facilities/model/facilities_model.dart';
import 'package:fixlah/facilities/provider/facilities_provider.dart';
import 'package:fixlah/inspection/provider/inspection_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class InspectionFilter extends StatefulWidget {
  const InspectionFilter({super.key});

  @override
  State<InspectionFilter> createState() => _InspectionFilterState();
}

class _InspectionFilterState extends State<InspectionFilter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: generalAppBar(context,
          title: "Filter",
          newColor: NewColors.inspectionscolor,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  size: 25.r,
                  color: NewColors.whitecolor,
                  Icons.done,
                ))
          ]),
      body: Consumer<FacilitiesProvider>(
          builder: (context, facilitiesProvider, child) {
        return Consumer<InspectionProvider>(
            builder: (context, inspectionProvider, child) {
          return Padding(
            padding: EdgeInsets.all(20.r),
            child: Wrap(
              children: List.generate(
                  facilitiesProvider.facilityList.data!.data!.length, (index) {
                FacilityData facilityData =
                    facilitiesProvider.facilityList.data!.data![index];
                return Padding(
                  padding: EdgeInsets.all(8.r),
                  child: FilterChip(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.r, vertical: 10.r),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                        side: BorderSide(
                            color: facilityData.id.toString() ==
                                    inspectionProvider.customFac
                                ? NewColors.primary
                                : NewColors.secondaycolor,
                            width: 2)),
                    backgroundColor: NewColors.whitecolor,
                    label: Text(
                      facilityData.name ?? "--",
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: mediumFontWeight,
                          color: NewColors.black,
                          fontSize: buildFontSize(35)),
                    ),
                    onSelected: (value) {
                      inspectionProvider.selectFilter(context,
                          id: facilityData.id.toString());
                    },
                  ),
                );
              }),
            ),
          );
        });
      }),
    );
  }
}
