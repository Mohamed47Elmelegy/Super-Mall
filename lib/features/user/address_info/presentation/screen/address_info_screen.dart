import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_mall/core/theme/app_color/app_color_light.dart';
import 'package:super_mall/features/user/address_info/presentation/screen/add_address_info_screen.dart';
import 'package:super_mall/shared/widget/appbar_back_title.dart';
import 'package:super_mall/shared/widget/button_primary.dart';

class AddressInfoScreen extends StatelessWidget {
  const AddressInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarBackTitle(
        title: 'Address',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        child: Column(
          children: [
            _buildAddressItem(context),
            SizedBox(height: 10.h),
            _buildAddressItem(context),
            Spacer(),
            ButtonPrimary(
                title: 'Add New Address',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddAddressInfoScreen()));
                }),
          ],
        ),
      ),
    );
  }

  Container _buildAddressItem(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
        color: AppColorLight.grey1,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '2715 Ash Dr.Farid Nada, South Banha 83475',
              style: TextStyle(
                fontSize: 16.sp,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 25.w),
          InkWell(
            onTap: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => EmailSentScreen()));
            },
            child: Text(
              'Edit',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
