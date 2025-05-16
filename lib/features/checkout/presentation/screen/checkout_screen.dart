import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_mall/core/theme/app_color/app_color_light.dart';
import 'package:super_mall/features/checkout/presentation/screen/successfully_checkout.dart';
import 'package:super_mall/features/product/data/model/product.dart';
import 'package:super_mall/features/user/address_info/data/models/address_model.dart';
import 'package:super_mall/features/user/address_info/presentation/cubit/address_cubit.dart';
import 'package:super_mall/features/user/address_info/presentation/cubit/address_state.dart';
import 'package:super_mall/features/user/address_info/presentation/screen/address_info_screen.dart';
import 'package:super_mall/shared/widget/appbar_back_title.dart';
import 'package:super_mall/shared/widget/button_primary.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  AddressModel? shippingAddress;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<AddressCubit>();
      final state = cubit.state;
      if (state is AddressLoadedSucess) {
        AddressModel? mainAddress;
        try {
          mainAddress = state.addresses.firstWhere((a) => a.isPrimary);
        } catch (_) {
          if (state.addresses.isNotEmpty) {
            mainAddress = state.addresses.first;
          }
        }
        if (mainAddress != null) {
          setState(() {
            shippingAddress = mainAddress;
          });
        }
      } else {
        cubit.getAddresses();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarBackTitle(
        title: 'Checkout',
      ),
      body: BlocListener<AddressCubit, AddressState>(
        listener: (context, state) {
          if (state is AddressLoadedSucess) {
            AddressModel? mainAddress;
            try {
              mainAddress = state.addresses.firstWhere((a) => a.isPrimary);
            } catch (_) {
              if (state.addresses.isNotEmpty) {
                mainAddress = state.addresses.first;
              }
            }
            if (mainAddress != null) {
              setState(() {
                shippingAddress = mainAddress;
              });
            }
          }
        },
        child: Padding(
          padding: EdgeInsets.all(20.0.r),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    CheckoutPart(
                      title: 'Shipping Address',
                      value: shippingAddress == null
                          ? 'Add Shipping Address'
                          : shippingAddress!.address,
                      onPressed: () async {
                        final selectedAddress = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const AddressInfoScreen(selectMode: true),
                          ),
                        );
                        if (selectedAddress != null && mounted) {
                          setState(() {
                            shippingAddress = selectedAddress as AddressModel;
                          });
                        }
                      },
                    ),
                    SizedBox(height: 20.h),
                    CheckoutPart(
                      title: 'Payment Method',
                      value: 'Add Payment Method',
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  children: [
                    _buildCalculationSliver('Subtotal', 100.0),
                    _buildCalculationSliver('Shipping Cost', 50.0),
                    _buildCalculationSliver('Tax', 0),
                    _buildCalculationSliver('Total', 1550),
                    if (shippingAddress != null)
                      Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: Text(
                          'Shipping to: ${shippingAddress!.address}, ${shippingAddress!.city}',
                          style: TextStyle(
                              fontSize: 14.sp, color: Colors.grey[700]),
                        ),
                      ),
                  ],
                ),
              ),
              ButtonPrimary(
                title: 'Checkout',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SuccessfullyCheckout(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildCalculationSliver(String title, double price) {
    return Padding(
      padding: EdgeInsets.all(5.r),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          Spacer(),
          Text('EGP$price'),
        ],
      ),
    );
  }
}

class CheckoutPart extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback? onPressed;

  const CheckoutPart({
    required this.title,
    required this.value,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: AppColorLight.grey1,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Color(0xff272727),
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
          Spacer(),
          IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            ),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
