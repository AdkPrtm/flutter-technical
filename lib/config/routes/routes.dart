import 'package:flutter/material.dart';
import 'package:techincal_test_flutter/feature/Auth/presentation/forgot_password_page.dart';
import 'package:techincal_test_flutter/feature/Auth/presentation/login_page.dart';
import 'package:techincal_test_flutter/feature/Auth/presentation/register_page.dart';
import 'package:techincal_test_flutter/feature/home/presentation/home_page.dart';
import 'package:techincal_test_flutter/feature/splash_page.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialPageRoute(const SplashPage());
      case '/register':
        return _materialPageRoute(const RegisterPage());
      case '/login':
        return _materialPageRoute(const LoginPage());
      case '/forgot-password':
        return _materialPageRoute(const ForgotPasswordPage());
      case '/home':
        return _materialPageRoute(const HomePage());
      default:
        return _materialPageRoute(const RegisterPage());
    }
  }

  static Route<dynamic> _materialPageRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
