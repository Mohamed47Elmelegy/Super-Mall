import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_mall/core/theme/app_color/app_color_light.dart';
import 'package:super_mall/features/cart/logic/cubit/cart_cubit.dart';
import 'package:super_mall/features/cart/logic/cubit/cart_state.dart';
import 'package:super_mall/features/cart/presentation/screen/cart_screen.dart';
import 'package:super_mall/features/wishlist/presentation/screen/wishlist_screen.dart';
import 'package:super_mall/features/user/address_info/data/models/address_model.dart';
import 'package:super_mall/features/user/address_info/presentation/cubit/address_cubit.dart';
import 'package:super_mall/features/user/address_info/presentation/cubit/address_state.dart';
import 'package:super_mall/features/user/user_info/presentation/screen/user_info_screen.dart';
import 'package:super_mall/features/user/address_info/presentation/screen/address_info_screen.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressCubit, AddressState>(
      builder: (context, state) {
        AddressModel? shippingAddress;

        if (state is AddressLoadedSucess) {
          try {
            shippingAddress = state.addresses.firstWhere((a) => a.isPrimary);
          } catch (_) {
            if (state.addresses.isNotEmpty) {
              shippingAddress = state.addresses.first;
            }
          }
        }

        return AppBar(
          leadingWidth: MediaQuery.of(context).size.width * 0.7,
          leading: Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Deliver to:',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddressInfoScreen(),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          shippingAddress != null
                              ? '${shippingAddress.address}, ${shippingAddress.city}'
                              : 'Add delivery address',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 20.sp,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                IconButton(
                  icon: SvgPicture.asset('assets/vectors/bag-cart.svg'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CartScreen()));
                  },
                ),
                BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    final cartCount =
                        state is CartLoaded ? state.cart.items.length : 0;
                    if (cartCount > 0) {
                      return Container(
                        padding: EdgeInsets.all(4.r),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$cartCount',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
            IconButton(
              icon: SvgPicture.asset('assets/vectors/fav-icon.svg'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WishlistScreen()));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
