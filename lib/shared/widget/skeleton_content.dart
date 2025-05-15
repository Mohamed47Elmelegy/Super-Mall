import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// A skeleton placeholder for text content
class SkeletonText extends StatelessWidget {
  final double width;
  final double height;

  const SkeletonText({
    super.key,
    this.width = 100,
    this.height = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        width: width.w,
        height: height.h,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(4.r),
        ),
      ),
    );
  }
}

/// A skeleton placeholder for an image
class SkeletonImage extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const SkeletonImage({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        width: width.w,
        height: height.h,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),
      ),
    );
  }
}

/// A skeleton placeholder for a circular image (like avatar)
class SkeletonAvatar extends StatelessWidget {
  final double radius;

  const SkeletonAvatar({
    super.key,
    this.radius = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: CircleAvatar(
        radius: radius.r,
        backgroundColor: Colors.grey[300],
      ),
    );
  }
}

/// A skeleton placeholder for a card
class SkeletonCard extends StatelessWidget {
  final double width;
  final double height;
  final Widget? child;

  const SkeletonCard({
    super.key,
    required this.width,
    required this.height,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        width: width.w,
        height: height.h,
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

/// A skeleton placeholder for a form field
class SkeletonFormField extends StatelessWidget {
  final double height;

  const SkeletonFormField({
    super.key,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        height: height.h,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.grey[400]!),
        ),
      ),
    );
  }
}

/// A skeleton placeholder for a button
class SkeletonButton extends StatelessWidget {
  final double width;
  final double height;

  const SkeletonButton({
    super.key,
    this.width = double.infinity,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        width: width.w,
        height: height.h,
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }
}
