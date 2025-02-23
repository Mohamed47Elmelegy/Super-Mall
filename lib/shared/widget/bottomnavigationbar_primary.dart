import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_mall/features/home/presentation/screen/home_screen.dart';
import 'package:super_mall/features/notification/presentation/screen/notification_screen.dart';
import 'package:super_mall/features/order/presentation/screen/order_screen.dart';
import 'package:super_mall/features/user/user_info/presentation/screen/user_info_screen.dart';

class BottomNavigationBarPrimary extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigationBarPrimary({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex, // تحديد التاب الحالي
      onTap: (index) {
        onTap(index); // تحديث التاب
        _navigateToScreen(context, index); // التنقل للصفحة المناسبة
      },
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/vectors/home.svg'),
          activeIcon: Image.asset('assets/images/hometab_active.png'),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/notificationtab_deactive.png'),
          activeIcon: Image.asset('assets/images/notificationtab_active.png'),
          label:  'Notifications',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/vectors/orders.svg'),
          activeIcon: Image.asset('assets/images/ordertab_active.png'),
          label: 'Orders',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/vectors/person.svg'),
          activeIcon: Image.asset('assets/images/usertab_active.png'),
          label: 'Profile',
        ),
      ],
    );
  }

  void _navigateToScreen(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
        break;
      case 1:
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => NotificationScreen()));
        break;
      case 2:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => OrderScreen()));
        break;
      case 3:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => UserInfoScreen()));
        break;
    }
  }
}
