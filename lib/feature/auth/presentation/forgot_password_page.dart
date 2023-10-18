import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:techincal_test_flutter/config/theme/app_color.dart';
import 'package:techincal_test_flutter/config/theme/app_font.dart';
import 'package:techincal_test_flutter/config/utils/double_utils.dart';
import 'package:techincal_test_flutter/feature/auth/bloc/auth_bloc.dart';
import 'package:techincal_test_flutter/widget/button_text.dart';
import 'package:techincal_test_flutter/widget/form_field.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey();

    return Scaffold(
      backgroundColor: lightBackground,
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Receive an email to\nreset your password',
            style: AppFontStyle().blackTextStyle.copyWith(
                  fontSize: 18.sp,
                  fontWeight: AppFontStyle().semibold,
                ),
            textAlign: TextAlign.center,
          ),
          8.0.height,
          Center(
            child: SizedBox(
              width: 220.w,
              child: Form(
                key: formKey,
                child: CustomFormField(
                  hint: 'Input your email',
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Required field';
                    }
                    bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value);
                    if (!emailValid) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
          8.0.height,
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthDone) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );
              }
              if (state is AuthFailed) {
                Fluttertoast.showToast(
                  msg: state.message!,
                  toastLength: Toast.LENGTH_SHORT,
                  backgroundColor: Colors.grey,
                  textColor: Colors.white,
                  fontSize: 14.0.sp,
                );
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return CustomButton(
                  title: 'Register',
                  onTap: () {},
                  isDisable: true,
                  width: 230.w,
                );
              }
              return CustomButton(
                title: 'Send me email',
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    context
                        .read<AuthBloc>()
                        .add(ForgotPassEvent(email: emailController.text));
                  }
                },
                width: 230.w,
              );
            },
          ),
        ],
      ),
    );
  }
}
