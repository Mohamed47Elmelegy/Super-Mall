import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_mall/core/theme/app_color/app_color_light.dart';
import 'package:super_mall/features/user/address_info/data/models/address_model.dart';
import 'package:super_mall/features/user/address_info/presentation/cubit/address_cubit.dart';
import 'package:super_mall/features/user/address_info/presentation/cubit/address_state.dart';
import 'package:super_mall/shared/widget/appbar_back_title.dart';
import 'package:super_mall/shared/widget/button_primary.dart';

class AddAddressInfoScreen extends StatefulWidget {
  final AddressModel? address;

  const AddAddressInfoScreen({super.key, this.address});

  @override
  State<AddAddressInfoScreen> createState() => _AddAddressInfoScreenState();
}

class _AddAddressInfoScreenState extends State<AddAddressInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _postalCodeController = TextEditingController();
  bool _isPrimary = false;

  @override
  void initState() {
    super.initState();
    if (widget.address != null) {
      _nameController.text = widget.address!.name;
      _phoneController.text = widget.address!.phone;
      _addressController.text = widget.address!.address;
      _cityController.text = widget.address!.city;
      _postalCodeController.text = widget.address!.postalCode ?? '';
      _isPrimary = widget.address!.isPrimary;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final address = AddressModel(
        id: widget.address?.id ?? 0,
        userId: 1, // This should come from your auth system
        name: _nameController.text,
        phone: _phoneController.text,
        address: _addressController.text,
        city: _cityController.text,
        postalCode: _postalCodeController.text.isEmpty
            ? null
            : _postalCodeController.text,
        isPrimary: _isPrimary,
        createdAt: widget.address?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );

      if (widget.address == null) {
        context.read<AddressCubit>().createAddress(address);
      } else {
        context.read<AddressCubit>().updateAddress(address);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarBackTitle(
        title: widget.address == null ? 'Add Address' : 'Edit Address',
      ),
      body: BlocListener<AddressCubit, AddressState>(
        listener: (context, state) {
          if (state is AddressLoadedSucess) {
            Navigator.pop(context);
          } else if (state is AddressError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
            child: Column(
              children: [
                TextFieldPrimary(
                  controller: _nameController,
                  hint: 'Full Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.h),
                TextFieldPrimary(
                  controller: _phoneController,
                  hint: 'Phone Number',
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.h),
                TextFieldPrimary(
                  controller: _addressController,
                  hint: 'Street Address',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.h),
                TextFieldPrimary(
                  controller: _cityController,
                  hint: 'City',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your city';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Checkbox(
                      value: _isPrimary,
                      onChanged: (value) {
                        setState(() {
                          _isPrimary = value ?? false;
                        });
                      },
                    ),
                    Text(
                      'Set as primary address',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ],
                ),
                const Spacer(),
                ButtonPrimary(
                  title: widget.address == null ? 'Save' : 'Update',
                  onPressed: _submitForm,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextFieldPrimary extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const TextFieldPrimary({
    super.key,
    required this.hint,
    this.controller,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: AppColorLight.grey2,
          fontSize: 16.sp,
        ),
      ),
    );
  }
}
