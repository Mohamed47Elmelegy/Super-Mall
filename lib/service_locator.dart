import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'core/network/api_client.dart';
import 'core/network/network_info.dart';
import 'features/auth/login/data/repository/login_repository.dart';
import 'features/auth/register/data/repository/register_repository.dart';
import 'features/auth/forget_password/data/repository/forget_password_repository.dart';
import 'features/home/data/repository/category_repository.dart';
import 'features/home/data/repository/home_repository.dart';
import 'features/product/data/repository/product.dart';

final getIt = GetIt.instance;

void setupLocator() {
  _setupNetwork();
  _setupRepositories();
}

void _setupNetwork() {
  getIt.registerLazySingleton<ApiClient>(() => ApiClient());
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(InternetConnectionChecker.createInstance()),
  );
}

void _setupRepositories() {
  getIt.registerLazySingleton<LoginRepositoryBase>(
    () => LoginRepository(
      apiClient: getIt<ApiClient>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );

  getIt.registerLazySingleton<RegisterRepositoryBase>(
    () => RegisterRepository(
      apiClient: getIt<ApiClient>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );

  // Forget Password
  getIt.registerLazySingleton<ForgetPasswordRepositoryBase>(
    () => ForgetPasswordRepository(
      apiClient: getIt<ApiClient>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );

  // Home
  getIt.registerLazySingleton<HomeRepositoryBase>(
    () => HomeRepository(
      getIt<ProductRepository>(),
      getIt<CategoryRepository>(),
    ),
  );

  // Product
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepository(getIt<ApiClient>()),
  );

  // Category
  getIt.registerLazySingleton<CategoryRepository>(
    () => CategoryRepository(getIt<ApiClient>()),
  );
}
