import 'package:flutter/material.dart';
import 'package:my_dictionary/core/utils/constent/app_color.dart';
import 'package:my_dictionary/core/utils/constent/app_sizer.dart';
import 'custom_text.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? customTitleWidget;
  final Widget? leading; // NEW: leading widget (e.g. back button)
  final Widget? trailing;
  final double? fontSize;
  final Color? titleColor;
  final Color? iconColor;
  final bool centerTitle;
  final Color backgroundColor;

  const CustomAppbar({
    super.key,
    this.title,
    this.customTitleWidget,
    this.leading, // accept leading
    this.trailing,
    this.fontSize,
    this.titleColor,
    this.iconColor,
    this.centerTitle = false,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final hasTitle =
        (title != null && title!.trim().isNotEmpty) ||
        customTitleWidget != null;

    return Container(
      color: backgroundColor,
      padding: EdgeInsets.symmetric(vertical: 1.h),
      height: preferredSize.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (leading != null)
            Align(alignment: Alignment.centerLeft, child: leading!),

          if (hasTitle)
            Align(
              alignment: centerTitle ? Alignment.center : Alignment.centerLeft,
              child: Padding(
                padding: centerTitle
                    ? EdgeInsets.zero
                    : EdgeInsets.only(left: leading != null ? 50.w : 12.w),
                child:
                    customTitleWidget ??
                    CustomText(
                      text: title ?? '',
                      fontSize: fontSize ?? 18.sp,
                      fontWeight: FontWeight.w600,
                      color: titleColor ?? AppColors.textPrimary,
                    ),
              ),
            ),

          if (trailing != null)
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: trailing!,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(52.h);
}
