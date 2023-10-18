import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:techincal_test_flutter/config/theme/app_color.dart';
import 'package:techincal_test_flutter/config/theme/app_font.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required this.hint,
    this.validator,
    this.obsecure = false,
    this.suffixIcon, required this.controller,
  });

  final String hint;
  final String? Function(String?)? validator;
  final bool obsecure;
  final Widget? suffixIcon;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: themeApp),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: themeApp),
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: themeApp),
        ),
        counterText: "",
        suffixIcon: suffixIcon,
      ),
      maxLength: 50,
      style: AppFontStyle().blackTextStyle.copyWith(
            fontSize: 18.sp,
            fontWeight: AppFontStyle().medium,
          ),
      obscureText: obsecure,
      validator: validator,
    );
  }
}
