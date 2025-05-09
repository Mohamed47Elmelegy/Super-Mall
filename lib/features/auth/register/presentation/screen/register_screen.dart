import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_mall/core/theme/app_color/app_color_light.dart';
import 'package:super_mall/features/auth/forget_password/presentation/screen/forget_password_screen.dart';
import 'package:super_mall/shared/widget/appbar_back_title.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarBackTitle(
        isBackable: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            _screenTitle(),
            SizedBox(height: 20.h),
            _usernameField(),
            SizedBox(height: 11.h),
            _emailField(),
            SizedBox(height: 11.h),
            _passwordField(),
            SizedBox(height: 30.h),
            _registerButtton(),
            SizedBox(height: 30.h),
            _forgetPasswordClickable(context),
          ],
        ),
      ),
    );
  }

  _usernameField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Username',
        hintStyle: TextStyle(
          color: AppColorLight.grey2,
          fontSize: 16.sp,
        ),
      ),
    );
  }

  _emailField() {
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

  _screenTitle() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Create Account',
        style: TextStyle(
          fontSize: 32.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  SizedBox _registerButtton() {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () {},
        child: Text('Register'),
      ),
    );
  }

  Align _forgetPasswordClickable(BuildContext context) {
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
