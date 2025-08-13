import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_dictionary/core/utils/constent/app_color.dart';
import 'package:my_dictionary/core/utils/constent/app_sizer.dart';


class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.fontSize = 14,
    this.textAlign = TextAlign.start,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.prefixIcon,
    this.fillColor,
    this.maxLine = 1,
    this.radius = 4,
    this.inputFormatters,
  });

  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final dynamic fillColor;
  final TextAlign textAlign;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool readOnly;
  final double fontSize;
  final int maxLine;
  final double radius;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: GoogleFonts.inter(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w400,
        fontSize: fontSize.sp,
        height: 20 / 14,
      ),
      maxLines: maxLine,
      readOnly: readOnly,
      keyboardType: keyboardType,
      obscureText: obscureText,
      controller: controller,
      textAlign: textAlign,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintStyle: GoogleFonts.dmSans(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w400,
          fontSize: fontSize.sp,
          height: 20 / 14,
        ),
        fillColor: fillColor ?? Colors.transparent,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.textFormFieldBorder,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(radius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.textFormFieldBorder,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(radius),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
        errorStyle: GoogleFonts.inter(
          color: Colors.redAccent,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      validator: validator,
      onTapOutside: (c) {
        FocusScope.of(context).unfocus();
      },
    );
  }
}