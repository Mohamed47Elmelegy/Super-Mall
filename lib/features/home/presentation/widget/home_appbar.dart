import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_mall/features/cart/presentation/screen/cart_screen.dart';

import '../../../user/user_info/presentation/screen/user_info_screen.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: SvgPicture.asset('assets/vectors/user.svg'),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const UserInfoScreen()));
        },
      ),
      actions: [
        IconButton(
          icon: SvgPicture.asset('assets/vectors/bag.svg'),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CartScreen()));
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
