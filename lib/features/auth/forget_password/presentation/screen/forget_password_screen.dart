import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_mall/core/theme/app_color/app_color_light.dart';
import 'package:super_mall/features/auth/forget_password/presentation/screen/email_sent_screen.dart';
import 'package:super_mall/shared/widget/appbar_back_title.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarBackTitle(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            _screenTitle(),
            SizedBox(height: 20.h),
            _emailField(),
            SizedBox(height: 11.h),
            _sendEmail(context),
          ],
        ),
      ),
    );
  }

  Align _screenTitle() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Forgot Password',
        style: TextStyle(
          fontSize: 32.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  _emailField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Enter Email Address',
        hintStyle: TextStyle(
          color: AppColorLight.grey2,
          fontSize: 16.sp,
        ),
      ),
    );
  }

  _sendEmail(context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => EmailSentScreen()));
        },
        child: Text('Send Email'),
      ),
    );
  }
}
