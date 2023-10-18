import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:techincal_test_flutter/config/theme/app_color.dart';
import 'package:techincal_test_flutter/config/theme/app_font.dart';
import 'package:techincal_test_flutter/config/utils/double_utils.dart';
import 'package:techincal_test_flutter/feature/auth/presentation/component/register_form_component.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackground,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        children: [
          75.0.height,
          Image.asset(
            'assets/logo.png',
            height: 100.h,
            width: 100.w,
          ),
          50.0.height,
          Text(
            'Register Account',
            style: AppFontStyle().blackTextStyle.copyWith(
                  fontSize: 20.sp,
                  fontWeight: AppFontStyle().semibold,
                ),
          ),
          SizedBox(height: 20.h),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                20,
              ),
              color: Colors.white,
            ),
            width: double.infinity,
            padding: EdgeInsets.all(22.h),
            //REGISTER FORM
            child: const RegisterForm(),
          ),
          SizedBox(height: 20.h),
          TextButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (route) => false);
            },
            child: Text(
              'Login',
              style: AppFontStyle().greyTextStyle.copyWith(
                    fontSize: 16.sp,
                  ),
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
