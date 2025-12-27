import 'package:fixlah/config/colors.dart';
import 'package:fixlah/config/graphics.dart';
import 'package:fixlah/config/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// used in : Login screen
class CustomTextFields extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final bool? isPassword;
  final bool? readOnly;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final String? initialValue;
  final Widget? suffix;
  const CustomTextFields(
      {super.key,
      required this.label,
      this.controller,
      this.isPassword,
      this.readOnly,
      this.keyboardType,
      this.textInputAction,
      this.validator,
      this.onTap,
      required this.hintText,
      this.onChanged,
      this.initialValue,
      this.suffix});

  @override
  State<CustomTextFields> createState() => _CustomTextFieldsState();
}

class _CustomTextFieldsState extends State<CustomTextFields> {
  bool? isPassword;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldTitle(label: widget.label),
          SizedBox(height: 10.r),
          SizedBox(
            height: 60.r,
            child: TextFormField(
              style: TextStyle(
                  fontWeight: FontWeight.w500, fontSize: buildFontSize(30)),
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction ?? TextInputAction.next,
              validator: widget.validator,
              controller: widget.controller,
              onTap: widget.onTap,
              initialValue: widget.initialValue,
              readOnly: widget.readOnly ?? false,
              onChanged: widget.onChanged,
              obscureText: isPassword ?? widget.isPassword ?? false,
              decoration: InputDecoration(
                suffix: widget.suffix,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15.r, horizontal: 15.r),
                fillColor: NewColors.whitecolor,
                filled: true,
                hintText: widget.hintText,
                errorStyle: TextStyle(height: 0, fontSize: 0),
                suffixIcon: widget.isPassword == true
                    ? InkWell(
                        onTap: () {
                          isPassword = isPassword == true ? false : true;
                          setState(() {});
                        },
                        child: Icon(
                          Icons.remove_red_eye,
                          size: 20.r,
                        ))
                    : const SizedBox(),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 255, 1, 1), width: 2),
                    borderRadius: BorderRadius.circular(100)),
                errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 255, 1, 1), width: 2),
                    borderRadius: BorderRadius.circular(100)),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: NewColors.secondayFullcolor, width: 2),
                    borderRadius: BorderRadius.circular(100)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: NewColors.secondayFullcolor, width: 2),
                    borderRadius: BorderRadius.circular(100)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextFieldTitle extends StatelessWidget {
  const TextFieldTitle({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
          fontWeight: mediumFontWeight,
          fontSize: buildFontSize(30),
          color: NewColors.secondattextcolor),
    );
  }
}

// Search Field

class SearchField extends StatelessWidget {
  final String title;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onPressed;
  final TextEditingController? searchText;
  const SearchField({
    super.key,
    required this.title,
    this.onFieldSubmitted,
    this.onPressed,
    this.searchText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 60.r,
      child: TextFormField(
        controller: searchText,
        style: TextStyle(
          color: Colors.white,
          fontSize: buildFontSize(35),
        ),
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
          suffixIcon: Padding(
            padding: EdgeInsets.all(10),
            child: InkWell(
              onTap: onPressed,
              child: ImageIcon(
                AssetImage(
                  Graphics.search,
                ),
                color: NewColors.whitecolor,
                size: 20,
              ),
            ),
          ),
          hintText: title,
          hintStyle: TextStyle(
            color: Colors.white,
            fontWeight: boldFontWeight,
            fontSize: buildFontSize(30),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: const BorderSide(
              width: 2,
              color: Color.fromRGBO(255, 255, 255, 0.30),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: const BorderSide(
              width: 2,
              color: Color.fromRGBO(255, 255, 255, 0.30),
            ),
          ),
        ),
      ),
    );
  }
}
