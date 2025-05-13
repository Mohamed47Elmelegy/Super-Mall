import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_mall/core/theme/app_color/app_color_light.dart';
import 'package:super_mall/features/auth/forget_password/presentation/screen/forget_password_screen.dart';
import 'package:super_mall/features/auth/register/data/model/register.dart';
import 'package:super_mall/features/auth/register/logic/cubit/register_cubit.dart';
import 'package:super_mall/features/auth/register/logic/cubit/register_state.dart';
import 'package:super_mall/shared/widget/appbar_back_title.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/routes/page_routes_name.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) async {
        if (state is RegisterError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is RegisterLoaded) {
          final token = state.response.token;
          if (token != null) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('token', token);
          }
          if (mounted) {
            Navigator.pushReplacementNamed(context, PageRoutesName.home);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppbarBackTitle(isBackable: true),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  _screenTitle(),
                  SizedBox(height: 20.h),
                  _usernameField(),
                  SizedBox(height: 11.h),
                  _emailField(),
                  SizedBox(height: 11.h),
                  _phoneField(),
                  SizedBox(height: 11.h),
                  _passwordField(),
                  SizedBox(height: 30.h),
                  _registerButton(state),
                  SizedBox(height: 30.h),
                  _forgetPasswordClickable(context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  TextFormField _usernameField() {
    return TextFormField(
      controller: _nameController,
      decoration: InputDecoration(
        hintText: 'Username',
        hintStyle: TextStyle(
          color: AppColorLight.grey2,
          fontSize: 16.sp,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your username';
        }
        return null;
      },
    );
  }

  TextFormField _emailField() {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        hintText: 'Email Address',
        hintStyle: TextStyle(
          color: AppColorLight.grey2,
          fontSize: 16.sp,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        if (!value.contains('@')) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }

  TextFormField _phoneField() {
    return TextFormField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: 'Phone Number',
        hintStyle: TextStyle(
          color: AppColorLight.grey2,
          fontSize: 16.sp,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your phone number';
        }
        // Basic phone number validation (you can adjust the regex based on your requirements)
        if (!RegExp(r'^\+?[\d\s-]{10,}$').hasMatch(value)) {
          return 'Please enter a valid phone number';
        }
        return null;
      },
    );
  }

  TextFormField _passwordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        hintStyle: TextStyle(
          color: AppColorLight.grey2,
          fontSize: 16.sp,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
    );
  }

  Widget _registerButton(RegisterState state) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: state is RegisterLoading
            ? null
            : () {
                if (_formKey.currentState!.validate()) {
                  context.read<RegisterCubit>().register(
                        RegistrationModel(
                          confirmPassword: _passwordController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                          name: _nameController.text,
                          phone: _phoneController.text,
                        ),
                      );
                }
              },
        child: state is RegisterLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text('Register'),
      ),
    );
  }

  _screenTitle() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Create Account',
        style: TextStyle(
          fontSize: 32.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Align _forgetPasswordClickable(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ForgetPasswordScreen(),
              ));
        },
        child: Text(
          'Forget Password? Reset',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
