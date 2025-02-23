import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_mall/core/theme/app_color/app_color_light.dart';
import 'package:super_mall/features/order/presentation/screen/order_details_screen.dart';
import 'package:super_mall/shared/widget/appbar_back_title.dart';
import 'package:super_mall/shared/widget/bottomnavigationbar_primary.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBarPrimary(
          currentIndex: 2,
          onTap: (index) {},
        ),
        appBar: AppbarBackTitle(
          title: 'Orders',
          isBackable: false,
        ),
        body: _isThereOrders() ? _ordersLayout(context) : _noOrder(context),
      ),
    );
  }

  Padding _ordersLayout(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Column(
        children: [
          TabBar(
            labelColor: Colors.brown,
            unselectedLabelColor: Colors.grey,
            indicator: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            dividerColor: Colors.transparent,
            tabs: [
              Tab(text: "Shipped"),
              Tab(text: "Delivered"),
              Tab(text: "Returned"),
              Tab(text: "Canceled"),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _orderListView(context),
                _orderListView(context),
                _orderListView(context),
                _orderListView(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListView _orderListView(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      children: [
        _orderItem(context, true, "Order #1234"),
        SizedBox(height: 10.h),
        _orderItem(context, false, "Order #5678"),
      ],
    );
  }

  Container _orderItem(BuildContext context, bool isRead, String orderText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: AppColorLight.grey1,
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
      ),
      child: Row(
        children: [
          SvgPicture.asset('assets/vectors/orders_black.svg'),
          SizedBox(width: 16.w),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Order  #456765'),
            SizedBox(height: 3.h),
            Text(
              '4 items',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.sp,
              ),
            ),
          ]),
          Spacer(),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OrderDetailsScreen()));
              },
              icon: Icon(Icons.arrow_forward_ios)),
        ],
      ),
    );
  }

  Widget _noOrder(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/no_orders_bag.png'),
          SizedBox(height: 20.h),
          Text(
            'No Orders yet',
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
          )
        ],
      ),
    );
  }

  bool _isThereOrders() {
    return true;
  }
}
