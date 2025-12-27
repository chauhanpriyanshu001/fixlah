import 'package:fixlah/config/colors.dart';
import 'package:fixlah/config/sizes.dart';
import 'package:fixlah/config/utils.dart';
import 'package:fixlah/issues/provider/issues_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class IssuesFilterScreen extends StatefulWidget {
  const IssuesFilterScreen({super.key});

  @override
  State<IssuesFilterScreen> createState() => _IssuesFilterScreenState();
}

class _IssuesFilterScreenState extends State<IssuesFilterScreen> {
  List filterList = ["CREAM", "NON-CREAM", "ALL"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: generalAppBar(context, title: "Filter", actions: [
        Consumer<IssuesProvider>(builder: (context, issuesProvider, child) {
          return IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.check,
                size: 25.r,
                color: NewColors.whitecolor,
              ));
        })
      ]),
      body: Consumer<IssuesProvider>(builder: (context, issuesProvider, child) {
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
                                color:
                                    filterList[index] == issuesProvider.filter
                                        ? NewColors.primary
                                        : NewColors.secondaycolor,
                                width: 2)),
                        backgroundColor: NewColors.whitecolor,
                        label: Text(
                          filterList[index],
                          style: TextStyle(
                              fontFamily: "Inter",
                              fontWeight: mediumFontWeight,
                              color: NewColors.black,
                              fontSize: buildFontSize(35)),
                        ),
                        onSelected: (value) {
                          issuesProvider.changeFilter(context,
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
