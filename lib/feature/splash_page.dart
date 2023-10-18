import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:techincal_test_flutter/config/theme/app_color.dart';
import 'package:techincal_test_flutter/feature/auth/bloc/auth_bloc.dart';
import 'package:techincal_test_flutter/feature/home/service/home_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    initTimer();
    super.initState();
  }

  void initTimer() async {
    Timer(
      const Duration(seconds: 3),
      () {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null && user.emailVerified) {
          context.read<AuthBloc>().add(GetDataByIdEvent(uid: user.uid));
          HomeService().getDataUser();
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          Navigator.pushReplacementNamed(context, '/register');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackground,
      body: Center(
        child: LottieBuilder.asset('assets/splash.json'),
      ),
    );
  }
}
