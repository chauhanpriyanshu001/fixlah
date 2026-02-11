// ignore_for_file: public_member_api_docs, sort_constructors_first
// custom navigator
import 'package:fixlah/config/graphics.dart';
import 'package:flutter/material.dart';
import 'package:fixlah/config/colors.dart';
import 'package:fixlah/config/sizes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

naviagteTo(context,
    {required Widget Function(BuildContext) builder,
    Function(dynamic)? onValue}) {
  Navigator.push(context, MaterialPageRoute(builder: builder))
      .then(onValue != null ? onValue : (val) {});
}

naviagteToandreplace(context,
    {required Widget Function(BuildContext) builder}) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: builder));
}

// app bar
PreferredSizeWidget generalAppBar(context,
    {required String title, List<Widget>? actions, Color? newColor}) {
  return AppBar(
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      // ignore: prefer_const_constructors
      icon: ImageIcon(
        AssetImage(
          Graphics.back,
        ),
        size: 25.r,
        color: NewColors.whitecolor,
      ),
    ),
    backgroundColor: newColor ?? NewColors.issuescolor,
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(
          fontWeight: boldFontWeight,
          color: Colors.white,
          fontSize: buildFontSize(35)),
    ),
    actions: actions,
  );
}

// next btn
class NxtBtn extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  const NxtBtn({
    super.key,
    this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          height: 50.r,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: NewColors.primary,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                    color: NewColors.black,
                    fontSize: aspectRatio * 40,
                    fontWeight: boldFontWeight),
              ),
              if (text == "Next")
                SizedBox(
                  width: aspectRatio * 10,
                ),
              if (text == "Next")
                Icon(
                  size: aspectRatio * 50,
                  Icons.arrow_forward,
                )
            ],
          )),
    );
  }
}

// title
class TitleWidget1 extends StatelessWidget {
  final String title;
  const TitleWidget1({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontWeight: mediumFontWeight,
          fontSize: buildFontSize(30),
          color: NewColors.secondattextcolor),
    );
  }
}

// Loading Widget

class LoadinWidget extends StatelessWidget {
  const LoadinWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
      color: NewColors.primary,
    ));
  }
}
// Full page Loading Widget

class FullPageLoadingWidget extends StatelessWidget {
  const FullPageLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: fullHeight,
      width: fullWidth,
      color: Colors.black26,
      child: const LoadinWidget(),
    );
  }
}

// formate date
formateDate({required String value}) {
  final f = DateFormat('dd-MM-yyyy');
  return f.format(DateTime.parse(value));
}

// formate date
formateDateTime({required String value}) {
  final f = DateFormat('dd/MM/yyyy hh:mm a');
  return f.format(DateTime.parse(value));
}

// formate time
formateTime({required String value}) {
  final f = DateFormat('hh:mm a');
  return f.format(DateTime.parse(value));
}

// Dialogue
Future openDialogue(context, {String? title, required Widget data}) {
  return showDialog(
      context: context,
      builder: (context) {
        return title != "" && title != null
            ? SimpleDialog(
                contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(30)),
                backgroundColor: NewColors.whitecolor,
                title: Text(
                  textAlign: TextAlign.center,
                  title,
                ),
                children: [data],
              )
            : SimpleDialog(
                contentPadding: const EdgeInsets.only(
                    top: 20, left: 20, right: 20, bottom: 20),
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(30)),
                backgroundColor: NewColors.whitecolor,
                children: [data],
              );
      });
}

// Confirmation widget
class ConfirmationWidget extends StatelessWidget {
  final String title;
  final void Function()? onTapNo;
  final void Function()? onTapYes;
  const ConfirmationWidget({
    super.key,
    required this.title,
    this.onTapNo,
    this.onTapYes,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Expanded(child: SizedBox()),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    textAlign: TextAlign.center,
                    title,
                    style: TextStyle(
                        color: NewColors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: buildFontSize(30)),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    child: InkWell(
                  onTap: onTapNo,
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: NewColors.secondaycolor, width: 3),
                        borderRadius: BorderRadius.circular(100)),
                    child: Text(
                      "No",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: NewColors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: buildFontSize(30),
                      ),
                    ),
                  ),
                )),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: InkWell(
                  onTap: onTapYes,
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: NewColors.primary,
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      "Yes",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: NewColors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: buildFontSize(30),
                      ),
                    ),
                  ),
                )),
              ],
            ),
          ),
        )
      ],
    );
  }
}
