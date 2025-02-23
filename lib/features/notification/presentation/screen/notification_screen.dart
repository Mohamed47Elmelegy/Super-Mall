import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_mall/core/theme/app_color/app_color_light.dart';
import 'package:super_mall/shared/widget/appbar_back_title.dart';
import 'package:super_mall/shared/widget/bottomnavigationbar_primary.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          BottomNavigationBarPrimary(currentIndex: 3, onTap: (index) {}),
      appBar: AppbarBackTitle(
        title: 'Notifications',
        isBackable: false,
      ),
      body: _isThereNotifications()
          ? _notificationsLayout()
          : _noNotification(context),
    );
  }

  Padding _notificationsLayout() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Column(
        children: [
          _notificationItem(false,
              'Ahmed, you placed and order check your order history for full details'),
          SizedBox(height: 10.h),
          _notificationItem(true,
              'Ahmed, Thank you for shopping with us we have canceled order #24568.'),
          SizedBox(height: 10.h),
          _notificationItem(true,
              'Ahmed, your Order #24568 has been  confirmed check  your order history for full details'),
        ],
      ),
    );
  }

  Container _notificationItem(bool isRead, String notificationText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: AppColorLight.grey1,
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
      ),
      child: Row(
        children: [
          isRead
              ? SvgPicture.asset('assets/vectors/no_notification_bell.svg')
              : SvgPicture.asset('assets/vectors/unread_notification_bell.svg'),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(notificationText),
          )
        ],
      ),
    );
  }

  Widget _noNotification(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/no_notifications_bell.png'),
          SizedBox(height: 20.h),
          Text(
            'No Notifications yet',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 20),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: Text('Explore Categories'),
          ),
        ],
      ),
    );
  }

  bool _isThereNotifications() {
    return false;
  }
}
