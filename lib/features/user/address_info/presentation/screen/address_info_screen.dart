import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:super_mall/core/theme/app_color/app_color_light.dart';
import 'package:super_mall/features/user/address_info/presentation/cubit/address_cubit.dart';
import 'package:super_mall/features/user/address_info/presentation/cubit/address_state.dart';
import 'package:super_mall/features/user/address_info/presentation/screen/add_address_info_screen.dart';
import 'package:super_mall/shared/widget/appbar_back_title.dart';
import 'package:super_mall/shared/widget/button_primary.dart';
import 'package:super_mall/shared/widget/empty_pages.dart';
import '../../data/models/address_model.dart';

class AddressInfoScreen extends StatelessWidget {
  final bool selectMode;
  const AddressInfoScreen({super.key, this.selectMode = false});

  Future<void> _showDeleteConfirmationDialog(
      BuildContext context, int addressId) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete Address',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to delete this address?',
            style: TextStyle(
              fontSize: 16.sp,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColorLight.textButton,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                context.read<AddressCubit>().deleteAddress(addressId);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Delete',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarBackTitle(
        title: 'Address',
      ),
      body: BlocListener<AddressCubit, AddressState>(
        listenWhen: (previous, current) => current is AddressLoadedSucess,
        listener: (context, state) {
        
        },
        child: BlocBuilder<AddressCubit, AddressState>(
          builder: (context, state) {
            if (state is AddressLoading) {
              return Center(
                  child: SpinKitWaveSpinner(
                      size: 120,
                      trackColor: Colors.green[100]!,
                      waveColor: Colors.green[300]!,
                      color: AppColorLight.primary));
            } else if (state is AddressError) {
              return Center(child: Text(state.message));
            } else if (state is AddressLoadedSucess) {
              if (state.addresses.isEmpty) {
                return EmptyPages(
                  imageType: 'svg',
                  image: 'assets/vectors/location-plus-svgrepo-com.svg',
                  title: 'No Addresses',
                  description: 'You haven\'t added any addresses yet',
                  buttonText: 'Add New Address',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddAddressInfoScreen(),
                      ),
                    );
                  },
                );
              }
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.addresses.length,
                        itemBuilder: (context, index) {
                          final address = state.addresses[index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: _buildAddressItem(context, address),
                          );
                        },
                      ),
                    ),
                    ButtonPrimary(
                      title: 'Add New Address',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddAddressInfoScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Container _buildAddressItem(BuildContext context, AddressModel address) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
        color: AppColorLight.grey1,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  address.name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  address.address,
                  style: TextStyle(
                    fontSize: 14.sp,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5.h),
                Text(
                  '${address.city}${address.postalCode != null ? ' - ${address.postalCode}' : ''}',
                  style: TextStyle(
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 25.w),
          Column(
            children: [
              InkWell(
                onTap: () {
                  if (selectMode) {
                    Navigator.pop(context, address);
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AddAddressInfoScreen(address: address),
                      ),
                    );
                  }
                },
                child: Text(
                  selectMode ? 'Choose' : 'Edit',
                  style: TextStyle(
                    color: selectMode
                        ? Colors.green
                        : Theme.of(context).primaryColor,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              if (!selectMode)
                InkWell(
                  onTap: () {
                    _showDeleteConfirmationDialog(context, address.id);
                  },
                  child: Text(
                    'Delete',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
