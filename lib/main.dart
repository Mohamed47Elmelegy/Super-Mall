import 'package:flutter/material.dart';
import 'package:super_mall/core/theme/theme_data/theme_data_light.dart';
import 'package:super_mall/features/auth/login/presentation/screen/login_screen.dart';
import 'package:super_mall/features/splash/presentation/screen/splash_screen.dart';
import 'package:super_mall/service_locator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: getThemeDataLight(),
          home: SplashScreen(),
        );
      },
    );
  }
}
