import 'package:flutter/material.dart';
import 'package:super_mall/core/routes/page_routes_name.dart';
import 'package:super_mall/features/auth/forget_password/presentation/screen/forget_password_screen.dart';
import 'package:super_mall/features/auth/login/presentation/screen/login_screen.dart';
import 'package:super_mall/features/auth/register/presentation/screen/register_screen.dart';
import 'package:super_mall/features/cart/presentation/screen/cart_screen.dart';
import 'package:super_mall/features/home/presentation/screen/categories_screen.dart';
import 'package:super_mall/features/home/presentation/screen/category_screen.dart';
import 'package:super_mall/features/home/presentation/screen/home_screen.dart';
import 'package:super_mall/features/notification/presentation/screen/notification_screen.dart';
import 'package:super_mall/features/order/presentation/screen/order_screen.dart';
import 'package:super_mall/features/splash/presentation/screen/splash_screen.dart';
import 'package:super_mall/features/user/user_info/presentation/screen/user_info_screen.dart';
import '../../features/product/data/model/product.dart';
import '../../features/product/presentation/screen/product_screen.dart';
import '../../features/home/data/model/category.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PageRoutesName.initial:
      case PageRoutesName.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case PageRoutesName.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      case PageRoutesName.register:
        return MaterialPageRoute(builder: (context) => const RegisterScreen());

      case PageRoutesName.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      case PageRoutesName.forgetPassword:
        return MaterialPageRoute(
            builder: (context) => const ForgetPasswordScreen());

      case PageRoutesName.categories:
        return MaterialPageRoute(
            builder: (context) => const CategoriesScreen());

      case PageRoutesName.category:
        final category = settings.arguments as Category;
        return MaterialPageRoute(
            builder: (context) => CategoryScreen(category: category));

      case PageRoutesName.notifications:
        return MaterialPageRoute(
            builder: (context) => const NotificationScreen());

      case PageRoutesName.orders:
        return MaterialPageRoute(builder: (context) => const OrderScreen());

      case PageRoutesName.profile:
        return MaterialPageRoute(builder: (context) => const UserInfoScreen());

      case PageRoutesName.productDetails:
        final product = settings.arguments as Product;
        return MaterialPageRoute(
          builder: (context) => ProductScreen(
            product: product,
            productCode: '',
          ),
        );

      case PageRoutesName.cart:
        return MaterialPageRoute(
          builder: (context) => const CartScreen(),
        );

      default:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
    }
  }
}
