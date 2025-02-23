import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_mall/core/theme/app_color/app_color_light.dart';
import 'package:super_mall/shared/widget/appbar_back_title.dart';
import 'package:super_mall/shared/widget/button_primary.dart';

class AddAddressInfoScreen extends StatelessWidget {
  const AddAddressInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarBackTitle(
        title: 'Add Address',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        child: Column(
          children: [
            TextFieldPrimary(hint: 'Street Address'),
            SizedBox(height: 10.h),
            TextFieldPrimary(hint: 'City'),
            SizedBox(height: 10.h),
            Row(children: [
              Expanded(
                child: TextFieldPrimary(hint: 'Governate'),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: TextFieldPrimary(
                  hint: 'ZIP Code',
                ),
              ),
            ]),
            Spacer(),
            ButtonPrimary(title: 'Save'),
          ],
        ),
      ),
    );
  }
}

class TextFieldPrimary extends StatelessWidget {
  final String hint;
  const TextFieldPrimary({
    super.key,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: AppColorLight.grey2,
          fontSize: 16.sp,
        ),
      ),
    );
  }
}
