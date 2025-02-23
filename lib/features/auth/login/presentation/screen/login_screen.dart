import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_mall/core/theme/app_color/app_color_light.dart';
import 'package:super_mall/features/auth/forget_password/presentation/screen/forget_password_screen.dart';
import 'package:super_mall/features/auth/login/presentation/widget/social_media_register_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_mall/features/auth/register/presentation/screen/register_screen.dart';
import 'package:super_mall/features/home/presentation/screen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: PageView(
          controller: _pageController,
          children: [
            _loginViewStep1(),
            _loginViewStep2(),
          ],
        ),
      ),
    );
  }

  Column _loginViewStep1() {
    return Column(
      children: [
        SizedBox(height: 123.h),
        _screenTitle(),
        SizedBox(height: 20.h),
        _emailField(),
        SizedBox(height: 11.h),
        _continueButton(),
        SizedBox(height: 16.h),
        _dontHaveAccountClickable(),
        SizedBox(height: 90.h),
        _appleRegisterButton(),
        SizedBox(height: 9.h),
        _googleRegisterButton(),
        SizedBox(height: 9.h),
        _facebookRegisterButton(),
      ],
    );
  }

  Align _screenTitle() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Sign In',
        style: TextStyle(
          fontSize: 32.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  TextFormField _emailField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Email Address',
        hintStyle: TextStyle(
          color: AppColorLight.grey2,
          fontSize: 16.sp,
        ),
      ),
    );
  }

  SocialMediaRegisterButton _facebookRegisterButton() {
    return SocialMediaRegisterButton(
      title: 'Continue With Facebook',
      icon: Image.asset(
        'assets/images/facebook.png',
      ),
    );
  }

  SocialMediaRegisterButton _googleRegisterButton() {
    return SocialMediaRegisterButton(
      title: 'Continue With Google',
      icon: Image.asset(
        'assets/images/google.png',
      ),
    );
  }

  SocialMediaRegisterButton _appleRegisterButton() {
    return SocialMediaRegisterButton(
      title: 'Continue With Apple',
      icon: SvgPicture.asset(
        'assets/vectors/apple.svg',
      ),
    );
  }

  Align _dontHaveAccountClickable() {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RegisterScreen(),
              ));
        },
        child: Text(
          'Dont have an Account ? Create One',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  SizedBox _continueButton() {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        child: Text('Continue'),
      ),
    );
  }

  _loginViewStep2() {
    return Column(
      children: [
        SizedBox(height: 123.h),
        _screenTitle(),
        SizedBox(height: 20.h),
        _passwordField(),
        SizedBox(height: 11.h),
        _signIn(),
        SizedBox(height: 16.h),
        _forgetPasswordClickable(),
      ],
    );
  }

  _passwordField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Password',
        hintStyle: TextStyle(
          color: AppColorLight.grey2,
          fontSize: 16.sp,
        ),
      ),
    );
  }

  _signIn() {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ));
        },
        child: Text('Sign In'),
      ),
    );
  }

  Align _forgetPasswordClickable() {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ForgetPasswordScreen(),
              ));
        },
        child: Text(
          'Forget Password? Reset',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
