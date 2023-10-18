import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:techincal_test_flutter/config/theme/app_font.dart';
import 'package:techincal_test_flutter/feature/auth/bloc/auth_bloc.dart';

class HeaderHomeComponent extends StatelessWidget {
  const HeaderHomeComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoaded) {
          return Text(
            'Hallo, ${state.userModel!.name}',
            style: AppFontStyle().blackTextStyle.copyWith(
                  fontSize: 22.sp,
                  fontWeight: AppFontStyle().semibold,
                ),
          );
        }
        return const CircularProgressIndicator(
          color: Colors.white,
        );
      },
    );
  }
}
