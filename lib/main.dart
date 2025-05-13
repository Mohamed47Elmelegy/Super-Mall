import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_mall/core/bloc_observer.dart';
import 'package:super_mall/core/routes/page_routes_name.dart';
import 'package:super_mall/core/routes/routes.dart';
import 'package:super_mall/core/theme/theme_data/theme_data_light.dart';
import 'package:super_mall/features/home/presentation/cubit/category_cubit.dart';
import 'package:super_mall/service_locator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_mall/features/auth/login/logic/cubit/login_cubit.dart';
import 'package:super_mall/features/auth/register/logic/cubit/register_cubit.dart';
import 'package:super_mall/features/auth/login/data/repository/login_repository.dart';
import 'package:super_mall/features/auth/register/data/repository/register_repository.dart';
import 'package:super_mall/features/home/data/repository/home_repository.dart';
import 'package:super_mall/features/home/presentation/cubit/home_cubit.dart';

import 'features/home/data/repository/category_repository.dart';
import 'features/product/data/repository/product.dart';
import 'features/product/logic/cubit/product_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Register BlocObserver
  Bloc.observer = BlocObserverService();

  setupLocator();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<LoginCubit>(
              create: (context) => LoginCubit(getIt<LoginRepositoryBase>()),
            ),
            BlocProvider<RegisterCubit>(
              create: (context) =>
                  RegisterCubit(getIt<RegisterRepositoryBase>()),
            ),
            BlocProvider<HomeCubit>(
              create: (context) => HomeCubit(getIt<HomeRepositoryBase>()),
            ),
            BlocProvider<ProductCubit>(
              create: (context) => ProductCubit(getIt<ProductRepository>()),
            ),
            BlocProvider<CategoryCubit>(
              create: (context) => CategoryCubit(getIt<CategoryRepository>()),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: getThemeDataLight(),
            initialRoute: PageRoutesName.initial,
            onGenerateRoute: Routes.generateRoute,
          ),
        );
      },
    );
  }
}
