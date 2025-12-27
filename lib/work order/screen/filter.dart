import 'package:fixlah/config/colors.dart';
import 'package:fixlah/config/sizes.dart';
import 'package:fixlah/config/utils.dart';
import 'package:fixlah/work%20order/provider/work_order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class WorlOrderFilter extends StatefulWidget {
  const WorlOrderFilter({super.key});

  @override
  State<WorlOrderFilter> createState() => _WorlOrderFilterState();
}

class _WorlOrderFilterState extends State<WorlOrderFilter> {
  List filterList = ["ALL", "CREAM", "NON-CREAM"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: generalAppBar(
          newColor: NewColors.workordercolor,
          context,
          title: "Filter",
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.check,
                  color: NewColors.whitecolor,
                ))
          ]),
      body: Consumer<WorkOrderProvider>(builder: (context, wOProvider, child) {
        return Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            children: [
              Wrap(
                children: List.generate(
                  filterList.length,
                  (index) {
                    return Padding(
                      padding: EdgeInsets.all(5.r),
                      child: FilterChip(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.r, vertical: 10.r),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                            side: BorderSide(
                                color: filterList[index] == wOProvider.filter
                                    ? NewColors.primary
                                    : NewColors.secondayFullcolor,
                                width: 2)),
                        backgroundColor: NewColors.whitecolor,
                        label: Text(
                          filterList[index],
                          style: TextStyle(
                              fontWeight: mediumFontWeight,
                              fontSize: buildFontSize(35)),
                        ),
                        onSelected: (value) {
                          wOProvider.changeFilter(context,
                              selctedFilter: filterList[index]);
                        },
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
