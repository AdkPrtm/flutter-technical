import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:techincal_test_flutter/config/theme/app_font.dart';
import 'package:techincal_test_flutter/config/utils/double_utils.dart';
import 'package:techincal_test_flutter/feature/auth/bloc/auth_bloc.dart';
import 'package:techincal_test_flutter/widget/button_text.dart';
import 'package:techincal_test_flutter/widget/form_field.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool hidePassword = true;
  bool hideKonfirmPassword = true;

  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController konfirmasiPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    passwordController.dispose();
    konfirmasiPasswordController.dispose();
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
            'Nama',
            style: AppFontStyle().blackTextStyle.copyWith(
                  fontSize: 18.sp,
                  fontWeight: AppFontStyle().bold,
                ),
          ),
          CustomFormField(
            hint: 'Masukan Nama',
            controller: namaController,
            validator: (value) {
              if (value!.length < 2 || value.length > 31) {
                return 'Minimum 3 - 50 characters';
              }

              if (value.isEmpty) {
                return 'Required field';
              }
              return null;
            },
          ),
          16.0.height,
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
              if (value!.isEmpty) {
                return 'Required field';
              }
              if (value.length < 8) {
                return 'Minimum 8 characters';
              }
              RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])');
              if (!regex.hasMatch(value)) {
                return 'Password should contain upper, lower, and digit';
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
          Text(
            'Konfirmasi Password',
            style: AppFontStyle().blackTextStyle.copyWith(
                  fontSize: 18.sp,
                  fontWeight: AppFontStyle().bold,
                ),
          ),
          CustomFormField(
            hint: 'Masukan Konfirmasi Password',
            controller: konfirmasiPasswordController,
            validator: (value) {
              if (value != passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
            obsecure: hideKonfirmPassword,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() => hideKonfirmPassword = !hideKonfirmPassword);
              },
              icon: Icon(
                hideKonfirmPassword ? Icons.visibility_off : Icons.visibility,
              ),
            ),
          ),
          30.0.height,
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthLoaded) {
                Fluttertoast.showToast(
                  msg: 'Please check and verif your email before login',
                  toastLength: Toast.LENGTH_SHORT,
                  backgroundColor: Colors.grey,
                  textColor: Colors.white,
                  fontSize: 14.0.sp,
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
                title: 'Register',
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<AuthBloc>().add(
                          RegisterEvent(
                            nama: namaController.text,
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
