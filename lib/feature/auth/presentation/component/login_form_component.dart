import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:techincal_test_flutter/config/theme/app_font.dart';
import 'package:techincal_test_flutter/config/utils/double_utils.dart';
import 'package:techincal_test_flutter/feature/auth/bloc/auth_bloc.dart';
import 'package:techincal_test_flutter/widget/button_text.dart';
import 'package:techincal_test_flutter/widget/form_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool hidePassword = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email',
            style: AppFontStyle().blackTextStyle.copyWith(
                  fontSize: 18.sp,
                  fontWeight: AppFontStyle().bold,
                ),
          ),
          CustomFormField(
            hint: 'Masukan Email',
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
          16.0.height,
          Text(
            'Password',
            style: AppFontStyle().blackTextStyle.copyWith(
                  fontSize: 18.sp,
                  fontWeight: AppFontStyle().bold,
                ),
          ),
          CustomFormField(
            hint: 'Masukan Password',
            controller: passwordController,
            validator: (value) {
              RegExp regex =
                  RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
              if (value!.isEmpty) {
                return 'Please enter password';
              }
              if (!regex.hasMatch(value)) {
                return 'Enter valid password';
              }
              return null;
            },
            obsecure: hidePassword,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() => hidePassword = !hidePassword);
              },
              icon: Icon(
                hidePassword ? Icons.visibility_off : Icons.visibility,
              ),
            ),
          ),
          16.0.height,
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/forgot-password');
              },
              child: Text(
                'Forgot Password',
                style: AppFontStyle().orangeTextStyle.copyWith(fontSize: 16.sp),
              ),
            ),
          ),
          30.0.height,
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthLoaded) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/home',
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
                );
              }
              return CustomButton(
                title: 'Login',
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<AuthBloc>().add(
                          LoginEvent(
                            email: emailController.text,
                            password: passwordController.text,
                          ),
                        );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
