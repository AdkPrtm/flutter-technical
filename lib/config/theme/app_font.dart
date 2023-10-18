import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techincal_test_flutter/config/theme/app_color.dart';

class AppFontStyle {
  TextStyle blackTextStyle = GoogleFonts.poppins(
    color: blackColor,
    fontSize: 14.sp,
  );

  TextStyle orangeTextStyle = GoogleFonts.poppins(
    color: themeApp,
    fontSize: 14.sp,
  );

  TextStyle whiteTextStyle = GoogleFonts.poppins(
    color: Colors.white,
    fontSize: 14.sp,
  );

  TextStyle greyTextStyle = GoogleFonts.poppins(
    color: Colors.grey,
    fontSize: 14.sp,
  );

  FontWeight light = FontWeight.w300;
  FontWeight reguler = FontWeight.w400;
  FontWeight medium = FontWeight.w500;
  FontWeight semibold = FontWeight.w600;
  FontWeight bold = FontWeight.w700;
  FontWeight extrabold = FontWeight.w800;
  FontWeight black = FontWeight.w900;
}
