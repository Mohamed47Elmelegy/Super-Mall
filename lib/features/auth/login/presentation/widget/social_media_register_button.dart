import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_mall/core/theme/app_color/app_color_light.dart';

class SocialMediaRegisterButton extends StatelessWidget {
  final String title;
  final Widget icon;

  const SocialMediaRegisterButton({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(AppColorLight.grey1),
          padding:
              WidgetStateProperty.all(EdgeInsets.symmetric(vertical: 11.h)),
        ),
        onPressed: () {},
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: icon,
              ),
            ),
            Center(
              child: Text(title),
            ),
          ],
        ),
      ),
    );
  }
}
