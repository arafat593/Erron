import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/app_colors.dart';

class CustomBlurButton extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget? child;
  final double? borderRadius;
  final double? horizontalMargin;
  final double? verticalMargin;
  final Color? buttonColor;
  final Color? borderColor;

  const CustomBlurButton({
    super.key,
    this.child,
    this.height,
    this.width,
    this.borderRadius,
    this.horizontalMargin,
    this.verticalMargin,
    this.buttonColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height?.h ?? 35.h,
      width: width?.h ?? 100.w,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius?.r ?? 30.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 6,
            sigmaY: 10,
            // tileMode: TileMode.mirror,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalMargin?.w ?? 8.w,
              vertical: verticalMargin?.h ?? 8.h,
            ),
            decoration: BoxDecoration(
              color: buttonColor ?? Color(0xff262733).withAlpha(25),
              borderRadius: BorderRadius.circular(borderRadius?.r ?? 30.r),
              border: Border.all(color: borderColor ?? Color(0xffcbccd8)),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
