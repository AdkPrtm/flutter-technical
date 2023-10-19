import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:techincal_test_flutter/config/theme/app_color.dart';
import 'package:techincal_test_flutter/config/theme/app_font.dart';
import 'package:techincal_test_flutter/feature/home/bloc/home_bloc.dart';
import 'package:techincal_test_flutter/model/user_model.dart';
import 'package:techincal_test_flutter/widget/list_data_widget.dart';

class DataHomeComponent extends StatelessWidget {
  const DataHomeComponent({
    super.key,
    required this.filterVerified,
  });

  final bool filterVerified;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoaded) {
              List<UserModel> userData = state.listUser
                  .where((data) => data.verified == true)
                  .toList();
              return filterVerified
                  ? ListView.builder(
                      itemCount: userData.length,
                      itemBuilder: (context, index) {
                        return ListDataWidget(userData: userData[index]);
                      },
                    )
                  : ListView.builder(
                      itemCount: state.listUser.length,
                      itemBuilder: (context, index) {
                        return ListDataWidget(
                          userData: state.listUser[index],
                        );
                      },
                    );
            }
            if (state is HomeLoading) {
              return Center(
                child: SizedBox(
                    height: 25.h,
                    width: 25.h,
                    child: const CircularProgressIndicator(
                      color: themeApp,
                    )),
              );
            }
            return Center(
              child: Text(
                'No data',
                style: AppFontStyle().blackTextStyle.copyWith(
                      fontSize: 18.sp,
                      fontWeight: AppFontStyle().medium,
                    ),
              ),
            );
          },
        ),
      ),
    );
  }
}
