import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_mall/core/theme/app_color/app_color_light.dart';
import 'package:super_mall/features/user/address_info/presentation/screen/address_info_screen.dart';
import 'package:super_mall/features/user/payment_info/presentation/screen/payment_info_screen.dart';
import 'package:super_mall/features/user/user_info/presentation/screen/user_info_edit_screen.dart';
import 'package:super_mall/features/user/wishlist/presentation/screen/wishlist_screen.dart';
import 'package:super_mall/shared/widget/appbar_back_title.dart';
import 'package:super_mall/shared/widget/bottomnavigationbar_primary.dart';

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          BottomNavigationBarPrimary(currentIndex: 3, onTap: (index) {}),
      appBar: AppbarBackTitle(
        isBackable: true,
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
              onPressed: () {},
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
    return CircleAvatar(
      radius: 50.r,
      backgroundImage: AssetImage('assets/images/thomas_shelby.jpeg'),
    );
  }

  Container _buildUserInfo(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.r),
      decoration: BoxDecoration(
        color: AppColorLight.grey1,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ahmed Bahaa'),
              SizedBox(height: 7.h),
              Text(
                'ab360180@gmail.com',
                style: TextStyle(
                  color: AppColorLight.grey2,
                ),
              ),
              SizedBox(height: 7.h),
              Text(
                '01206497455',
                style: TextStyle(
                  color: AppColorLight.grey2,
                ),
              ),
            ],
          ),
          Spacer(),
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
