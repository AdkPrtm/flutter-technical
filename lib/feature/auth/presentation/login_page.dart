import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:techincal_test_flutter/config/theme/app_color.dart';
import 'package:techincal_test_flutter/config/theme/app_font.dart';
import 'package:techincal_test_flutter/config/utils/double_utils.dart';
import 'package:techincal_test_flutter/feature/auth/presentation/component/login_form_component.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
            'Login Account',
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
            //LOGIN FORM
            child: const LoginForm(),
          ),
          SizedBox(height: 20.h),
          TextButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/register', (route) => false);
            },
            child: Text(
              'Register',
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
