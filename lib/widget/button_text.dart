import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:techincal_test_flutter/config/theme/app_color.dart';
import 'package:techincal_test_flutter/config/theme/app_font.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.width = double.infinity,
    required this.title,
    required this.onTap,
    this.isDisable = false,
  });

  final double width;
  final String title;
  final VoidCallback onTap;
  final bool isDisable;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 50.h,
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          backgroundColor: themeApp,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: isDisable
            ? SizedBox(
                height: 25.h,
                width: 25.h,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Text(
                title,
                style: AppFontStyle().whiteTextStyle.copyWith(
                      fontSize: 16.sp,
                      fontWeight: AppFontStyle().semibold,
                    ),
              ),
      ),
    );
  }
}
