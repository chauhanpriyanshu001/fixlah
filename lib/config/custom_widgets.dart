import 'package:fixlah/config/colors.dart';
import 'package:fixlah/config/graphics.dart';
import 'package:fixlah/config/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget selectionWidget(
    {required bool selected,
    void Function()? onTap,
    required String title,
    required Color primaryColor,
    bool? isFilled,
    required Color secondayColor}) {
  return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 5.r),
      tileColor: selected
          ? isFilled == true
              ? primaryColor
              : Colors.transparent
          : Colors.transparent,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60),
          borderSide: BorderSide(
            color: selected ? primaryColor : NewColors.secondayFullcolor,
            width: 2,
          )),
      minTileHeight: 40.r,
      leading: Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selected
                  ? isFilled == true
                      ? Colors.white
                      : primaryColor
                  : NewColors.secondayFullcolor),
          child: Icon(
            Icons.done,
            size: 15.r,
            color: selected
                ? isFilled == true
                    ? primaryColor
                    : NewColors.whitecolor
                : NewColors.whitecolor,
          )),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: mediumFontWeight,
          fontSize: buildFontSize(30),
          color: selected
              ? isFilled == true
                  ? Colors.white
                  : Colors.black
              : NewColors.black,
        ),
      ),
      onTap: onTap

      //  () {
      //   issueType = "Unit";
      //   setState(() {});
      // },
      );
}

// Filter
class FilterIcon extends StatelessWidget {
  final void Function()? onPressed;
  const FilterIcon({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: ImageIcon(
        size: 25.r,
        AssetImage(
          Graphics.filter,
        ),
        color: NewColors.whitecolor,
      ),
    );
  }
}
