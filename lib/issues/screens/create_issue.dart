import 'package:fixlah/config/colors.dart';
import 'package:fixlah/config/sizes.dart';
import 'package:fixlah/config/utils.dart';
import 'package:fixlah/issues/provider/issues_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CreateIssue extends StatefulWidget {
  const CreateIssue({super.key});

  @override
  State<CreateIssue> createState() => _CreateIssueState();
}

class _CreateIssueState extends State<CreateIssue> {
  String issueType = "";
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      IssuesProvider issuesProvider = Provider.of<IssuesProvider>(
        context,
        listen: false,
      );
      issuesProvider.clearCreateData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: generalAppBar(
          context,
          title: "Create Issue",
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              icon: Icon(
                color: NewColors.whitecolor,
                size: 25.r,
                Icons.close,
              ),
            ),
          ],
        ),
        body: ListView(
          padding: EdgeInsets.all(25.r),
          children: [
            ListTile(
              minTileHeight: 20,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15.r, vertical: 8.r),
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60),
                  borderSide: BorderSide(
                    color: issueType == "Unit"
                        ? NewColors.primary
                        : NewColors.secondayFullcolor,
                    width: 2,
                  )),
              leading: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: issueType == "Unit"
                          ? NewColors.primary
                          : NewColors.secondayFullcolor),
                  child: Icon(
                    Icons.done,
                    size: 20.r,
                    color: NewColors.whitecolor,
                  )),
              title: Text(
                "Unit",
                style: TextStyle(
                  fontWeight: mediumFontWeight,
                  fontSize: buildFontSize(35),
                  color: NewColors.black,
                ),
              ),
              onTap: () {
                issueType = "Unit";
                setState(() {});
              },
            ),
            SizedBox(
              height: 20.r,
            ),
            ListTile(
              minTileHeight: 20,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15.r, vertical: 8.r),
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60),
                  borderSide: BorderSide(
                    color: issueType == "Common Area"
                        ? NewColors.primary
                        : NewColors.secondayFullcolor,
                    width: 2,
                  )),
              title: Text(
                "Common Area",
                style: TextStyle(
                  fontWeight: mediumFontWeight,
                  fontSize: buildFontSize(35),
                  color: NewColors.black,
                ),
              ),
              leading: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: issueType == "Common Area"
                          ? NewColors.primary
                          : NewColors.secondayFullcolor),
                  child: Icon(
                    Icons.done,
                    size: 20.r,
                    color: NewColors.whitecolor,
                  )),
              onTap: () {
                issueType = "Common Area";
                setState(() {});
              },
            ),
          ],
        ),
        bottomSheet: Padding(
          padding: EdgeInsets.all(20),
          child: NxtBtn(
              text: "Next",
              onTap: () {
                context
                    .read<IssuesProvider>()
                    .setIssueType(context, type: issueType);
              }),
        ));
  }
}
