import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_mall/core/routes/page_routes_name.dart';
import 'package:super_mall/core/services/user_service.dart';
import 'package:super_mall/features/auth/login/presentation/screen/login_screen.dart';
import 'package:super_mall/features/home/presentation/screen/home_screen.dart';
import 'package:super_mall/features/splash/logic/cubit/splash_cubit.dart';
import 'package:super_mall/features/splash/logic/cubit/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(),
      child: const SplashScreenView(),
    );
  }
}

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    // Wait for splash screen animation
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    // Check if user is logged in
    final isLoggedIn = isUserLoggedIn();

    if (mounted) {
      if (isLoggedIn) {
        // User is logged in, navigate to home
        Navigator.pushReplacementNamed(context, PageRoutesName.home);
      } else {
        // User is not logged in, navigate to login
        Navigator.pushReplacementNamed(context, PageRoutesName.login);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashCubit, SplashState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: Center(
            child: Image.asset('assets/images/logo.png'),
          ),
        );
      },
    );
  }
}
