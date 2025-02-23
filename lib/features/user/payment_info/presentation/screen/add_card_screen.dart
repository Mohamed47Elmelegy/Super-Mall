import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_mall/features/user/address_info/presentation/screen/add_address_info_screen.dart';
import 'package:super_mall/shared/widget/appbar_back_title.dart';
import 'package:super_mall/shared/widget/button_primary.dart';

class AddCardScreen extends StatelessWidget {
  const AddCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarBackTitle(
        title: 'Add Card',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        child: Column(
          children: [
            TextFieldPrimary(hint: 'Card Number'),
            SizedBox(height: 10.h),
            Row(children: [
              Expanded(
                child: TextFieldPrimary(hint: 'CCV'),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: TextFieldPrimary(
                  hint: 'Exp',
                ),
              ),
            ]),
            SizedBox(height: 10.h),
            TextFieldPrimary(hint: 'Card Holder Name'),
            Spacer(),
            ButtonPrimary(title: 'Save'),
          ],
        ),
      ),
    );
  }
}
