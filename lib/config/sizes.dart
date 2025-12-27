import 'package:flutter_screenutil/flutter_screenutil.dart';

double aspectRatio = 0;
double fullWidth = 0;
double fullHeight = 0;
// ignore: non_constant_identifier_names
double text_fields_font_Size = 0;
bool bigSize = false;

buildFontSize(double fontSize) {
  double fontsize = aspectRatio * fontSize;

  if (bigSize == true) {
    return fontsize.r + 2.r;
  } else {
    return fontsize.r;
  }
}
