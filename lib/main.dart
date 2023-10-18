import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:techincal_test_flutter/config/routes/routes.dart';
import 'package:techincal_test_flutter/feature/auth/bloc/auth_bloc.dart';
import 'package:techincal_test_flutter/feature/home/bloc/home_bloc.dart';
import 'package:techincal_test_flutter/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (BuildContext context, Widget? child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => AuthBloc()),
            BlocProvider(create: (_) => HomeBloc()),
          ],
          child: MaterialApp(
            title: 'Technical Test',
            theme: ThemeData(
              useMaterial3: true,
            ),
            onGenerateRoute: AppRoutes.onGenerateRoutes,
          ),
        );
      },
    );
  }
}
