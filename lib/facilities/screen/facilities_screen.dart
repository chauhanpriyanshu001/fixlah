import 'package:fixlah/config/colors.dart';
import 'package:fixlah/config/constants.dart';
import 'package:fixlah/config/graphics.dart';
import 'package:fixlah/config/sizes.dart';
import 'package:fixlah/config/utils.dart';
import 'package:fixlah/facilities/model/facilities_model.dart';
import 'package:fixlah/facilities/provider/facilities_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FacilitiesScreen extends StatefulWidget {
  const FacilitiesScreen({super.key});

  @override
  State<FacilitiesScreen> createState() => _FacilitiesScreenState();
}

class _FacilitiesScreenState extends State<FacilitiesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        // logo
        title: Image(
          image: const AssetImage(
            Graphics.logo_primary,
          ),
          width: 120.r,
        ),
        // action
        actions: [
          Consumer<FacilitiesProvider>(
              builder: (context, facilitiesProvider, child) {
            return GestureDetector(
              onTap: () {
                Navigator.pop(context, true);
              },
              child: Row(
                children: [
                  Text(
                    selectedFacilities.length ==
                            facilitiesProvider.totalFacilities
                        ? "All Facilities"
                        : facilitiesProvider.selectedFacilitiesName.join(","),
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: buildFontSize(35)),
                  ),
                  const Icon(Icons.keyboard_arrow_up)
                ],
              ),
            );
          })
        ],
      ),
      body: Consumer<FacilitiesProvider>(
          builder: (context, facilitiesProvider, child) {
        return facilitiesProvider.loading
            ? const LoadinWidget()
            : ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                shrinkWrap: true,
                padding: const EdgeInsets.all(20),
                itemCount:
                    facilitiesProvider.facilityList.data?.data!.length ?? 0,
                itemBuilder: (context, index) {
                  FacilityData facilitiData =
                      facilitiesProvider.facilityList.data!.data![index];
                  bool selctionvalue =
                      selectedFacilities.contains(facilitiData.id);
                  return InkWell(
                    onTap: () {
                      facilitiesProvider.onFacilitiChange(context,
                          name: facilitiData.name, value: facilitiData.id);
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: fullWidth,
                          height: fullHeight / 4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: NewColors.whitecolor,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(facilitiesProvider
                                      .facilitiesImages[index]))),
                        ),
                        Container(
                          height: fullHeight / 4,
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 2.r, horizontal: 10.r),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: NewColors.whitecolor),
                                child: Row(
                                  children: [
                                    Text(
                                      facilitiData.name ?? "",
                                      style: TextStyle(
                                          color: NewColors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.r),
                                    ),
                                    Checkbox(
                                        side: BorderSide.none,
                                        activeColor: NewColors.secondaycolor,
                                        fillColor: WidgetStatePropertyAll(
                                            selctionvalue
                                                ? NewColors.primary
                                                : NewColors.secondaycolor),
                                        shape: const CircleBorder(),
                                        value: selctionvalue,
                                        onChanged: (value) {
                                          facilitiesProvider.onFacilitiChange(
                                              context,
                                              name: facilitiData.name,
                                              value: facilitiData.id);
                                        }),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                });
      }),
    );
  }
}
