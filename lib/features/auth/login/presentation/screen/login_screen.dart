import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_mall/core/routes/page_routes_name.dart';
import 'package:super_mall/core/theme/app_color/app_color_light.dart';
import 'package:super_mall/features/auth/forget_password/presentation/screen/forget_password_screen.dart';
import 'package:super_mall/features/auth/login/data/model/login.dart';
import 'package:super_mall/features/auth/login/logic/cubit/login_cubit.dart';
import 'package:super_mall/features/auth/login/logic/cubit/login_state.dart';
import 'package:super_mall/features/auth/login/presentation/widget/social_media_register_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_mall/features/auth/register/presentation/screen/register_screen.dart';
import 'package:super_mall/service_locator.dart';

import '../../data/repository/login_repository.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _pageController = PageController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _pageController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is LoginError) {
          _showErrorSnackBar(state.message);
        } else if (state is LoginSucces) {
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
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: PageView(
              controller: _pageController,
              children: [
                SingleChildScrollView(child: _loginViewStep1(state)),
                SingleChildScrollView(child: _loginViewStep2(state)),
              ],
            ),
          ),
        );
      },
    );
  }

  Column _loginViewStep1(LoginState state) {
    return Column(
      children: [
        SizedBox(height: 123.h),
        _screenTitle(),
        SizedBox(height: 20.h),
        _emailField(),
        SizedBox(height: 11.h),
        _continueButton(state),
        SizedBox(height: 16.h),
        _dontHaveAccountClickable(),
        SizedBox(height: 90.h),
        _appleRegisterButton(),
        SizedBox(height: 9.h),
        _googleRegisterButton(),
        SizedBox(height: 9.h),
        _facebookRegisterButton(),
      ],
    );
  }

  Align _screenTitle() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Sign In',
        style: TextStyle(
          fontSize: 32.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  TextFormField _emailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Email',
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

  SocialMediaRegisterButton _facebookRegisterButton() {
    return SocialMediaRegisterButton(
      title: 'Continue With Facebook',
      icon: Image.asset(
        'assets/images/facebook.png',
      ),
    );
  }

  SocialMediaRegisterButton _googleRegisterButton() {
    return SocialMediaRegisterButton(
      title: 'Continue With Google',
      icon: Image.asset(
        'assets/images/google.png',
      ),
    );
  }

  SocialMediaRegisterButton _appleRegisterButton() {
    return SocialMediaRegisterButton(
      title: 'Continue With Apple',
      icon: SvgPicture.asset(
        'assets/vectors/apple.svg',
      ),
    );
  }

  Align _dontHaveAccountClickable() {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RegisterScreen(),
              ));
        },
        child: Text(
          'Dont have an Account ? Create One',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _continueButton(LoginState state) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: state is LoginLoading
            ? null
            : () {
                if (_emailController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter your email'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
        child: state is LoginLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text('Continue'),
      ),
    );
  }

  _loginViewStep2(LoginState state) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 123.h),
          _screenTitle(),
          SizedBox(height: 20.h),
          _passwordField(),
          SizedBox(height: 11.h),
          _signIn(state),
          SizedBox(height: 16.h),
          _forgetPasswordClickable(),
        ],
      ),
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

  Widget _signIn(LoginState state) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: state is LoginLoading
            ? null
            : () {
                if (_formKey.currentState?.validate() ?? false) {
                  context.read<LoginCubit>().login(
                        UserLoginModel(
                          email: _emailController.text,
                          password: _passwordController.text,
                        ),
                      );
                }
              },
        child: state is LoginLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text('Sign In'),
      ),
    );
  }

  Align _forgetPasswordClickable() {
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
