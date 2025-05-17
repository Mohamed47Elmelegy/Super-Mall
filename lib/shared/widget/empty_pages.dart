import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/theme/app_color/app_color_light.dart';

class EmptyPages extends StatelessWidget {
  const EmptyPages({
    super.key,
    required this.imageType,
    required this.image,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onPressed,
  });

  final String imageType;
  final String image;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (imageType == 'asset')
            Image.asset(
              image,
              width: 100.w,
              height: 100.h,
            ),
          if (imageType == 'svg')
            SvgPicture.asset(
              image,
              width: 100.w,
              height: 100.h,
            ),
          SizedBox(height: 16.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            description,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColorLight.button,
            ),
            onPressed: onPressed,
            child: Text(
              buttonText,
              style: TextStyle(
                color: AppColorLight.textButton,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}