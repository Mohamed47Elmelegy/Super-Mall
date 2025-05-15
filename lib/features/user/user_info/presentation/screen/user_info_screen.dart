import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_mall/core/routes/page_routes_name.dart';
import 'package:super_mall/core/services/user_service.dart';
import 'package:super_mall/core/theme/app_color/app_color_light.dart';
import 'package:super_mall/features/user/address_info/presentation/screen/address_info_screen.dart';
import 'package:super_mall/features/user/payment_info/presentation/screen/payment_info_screen.dart';
import 'package:super_mall/features/user/user_info/data/model/user_model.dart';
import 'package:super_mall/features/user/user_info/presentation/screen/user_info_edit_screen.dart';
import 'package:super_mall/features/user/wishlist/presentation/screen/wishlist_screen.dart';
import 'package:super_mall/shared/widget/appbar_back_title.dart';
import 'package:super_mall/shared/widget/bottomnavigationbar_primary.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key, this.user});
  final dynamic user; // Accept either RegistrationModel or null

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  UserModel? userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    // Get user data directly from SharedPreferences
    final data = getUserData();
    dev.log('UserData loaded from SharedPreferences: ${data?.toJson()}');

    if (mounted) {
      setState(() {
        userData = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          BottomNavigationBarPrimary(currentIndex: 3, onTap: (index) {}),
      appBar: AppbarBackTitle(
        isBackable: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        child: Column(
          children: [
            _buildAvatarImage(),
            SizedBox(height: 20.h),
            _buildUserInfo(context),
            SizedBox(height: 30.h),
            UserInfoToGo(
                title: 'Address',
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AddressInfoScreen();
                  }));
                }),
            SizedBox(height: 10.h),
            UserInfoToGo(
                title: 'Wishlist',
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return WishlistScreen();
                  }));
                }),
            SizedBox(height: 10.h),
            UserInfoToGo(
                title: 'Payment',
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return PaymentInfoScreen();
                  }));
                }),
            SizedBox(height: 10.h),
            UserInfoToGo(title: 'Help'),
            SizedBox(height: 10.h),
            UserInfoToGo(title: 'Support'),
            Spacer(),
            TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.transparent),
              ),
              onPressed: () async {
                // حذف بيانات المستخدم
                await clearUserData();

                // العودة إلى شاشة تسجيل الدخول
                if (context.mounted) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, PageRoutesName.login, (route) => false);
                }
              },
              child: Text(
                'Sign Out',
                style: TextStyle(
                  color: AppColorLight.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  CircleAvatar _buildAvatarImage() {
    // استخدام صورة المستخدم إذا كانت متوفرة
    final userImage = userData?.image;
    return CircleAvatar(
      radius: 50.r,
      backgroundImage: userImage != null && userImage.isNotEmpty
          ? NetworkImage(userImage) as ImageProvider
          : AssetImage('assets/images/thomas_shelby.jpeg'),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    // طباعة بيانات المستخدم للتأكد
    dev.log('User name: "${userData?.name}"');
    dev.log('User email: "${userData?.email}"');
    dev.log('User phone: "${userData?.phone}"');

    return Container(
      padding: EdgeInsets.all(15.r),
      decoration: BoxDecoration(
        color: AppColorLight.grey1,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userData?.name ?? 'User Name',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 7.h),
                Text(
                  userData?.email ?? 'user@example.com',
                  style: TextStyle(
                    color: AppColorLight.grey2,
                  ),
                ),
                SizedBox(height: 7.h),
                Text(
                  userData?.phone ?? '123456789',
                  style: TextStyle(
                    color: AppColorLight.grey2,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return UserInfoEditScreen();
              }));
            },
            child: Text(
              'Edit',
              style: TextStyle(
                color: AppColorLight.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UserInfoToGo extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const UserInfoToGo({
    super.key,
    required this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          color: AppColorLight.grey1,
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: Row(
          children: [
            Text(title),
            Spacer(),
            IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                )),
          ],
        ),
      ),
    );
  }
}
