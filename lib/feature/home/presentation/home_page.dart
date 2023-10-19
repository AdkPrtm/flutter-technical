import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:techincal_test_flutter/config/theme/app_color.dart';
import 'package:techincal_test_flutter/config/theme/app_font.dart';
import 'package:techincal_test_flutter/config/utils/double_utils.dart';
import 'package:techincal_test_flutter/feature/auth/bloc/auth_bloc.dart';
import 'package:techincal_test_flutter/feature/home/bloc/home_bloc.dart';
import 'package:techincal_test_flutter/feature/home/presentation/component/data_home_component.dart';
import 'package:techincal_test_flutter/feature/home/presentation/component/header_component.dart';
import 'package:techincal_test_flutter/widget/button_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<HomeBloc>().add(GetDataUserEvent());
    super.initState();
  }

  bool filterVerified = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackground,
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<HomeBloc>().add(GetDataUserEvent());
          await Future.delayed(Duration.zero);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              70.0.height,
              const HeaderHomeComponent(),
              10.0.height,
              const Divider(),
              10.0.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Data User',
                    style: AppFontStyle().blackTextStyle.copyWith(
                          fontSize: 22.sp,
                          fontWeight: AppFontStyle().semibold,
                        ),
                  ),
                  IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Filter Data'),
                            actions: [
                              TextButton(
                                child: const Text('All Data'),
                                onPressed: () {
                                  setState(() {
                                    filterVerified = false;
                                    Navigator.pop(context);
                                  });
                                },
                              ),
                              TextButton(
                                child: const Text('User Verified'),
                                onPressed: () {
                                  setState(() {
                                    filterVerified = true;
                                    Navigator.pop(context);
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(Icons.filter_list_rounded)),
                ],
              ),
              10.0.height,
              DataHomeComponent(filterVerified: filterVerified),
              10.0.height,
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthDone) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/register',
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
                      title: '',
                      onTap: () {},
                      isDisable: true,
                    );
                  }
                  return CustomButton(
                    title: 'Logout',
                    onTap: () {
                      context.read<AuthBloc>().add(LogoutEvent());
                    },
                  );
                },
              ),
              10.0.height,
            ],
          ),
        ),
      ),
    );
  }
}
