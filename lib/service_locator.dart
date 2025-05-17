import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:super_mall/features/home/data/repository/banner_repository.dart';
import 'core/network/api_client.dart';
import 'core/network/api_constants.dart';
import 'core/network/network_info.dart';
import 'features/auth/login/data/repository/login_repository.dart';
import 'features/auth/register/data/repository/register_repository.dart';
import 'features/auth/forget_password/data/repository/forget_password_repository.dart';
import 'features/home/data/repository/category_repository.dart';
import 'features/home/data/repository/home_repository.dart';
import 'features/product/data/repository/product.dart';
import 'features/user/address_info/data/repositories/address_repository.dart';
import 'features/user/address_info/data/repositories/address_repository_impl.dart';
import 'features/wishlist/data/wishlist_repository.dart';
import 'features/profile/data/services/profile_service.dart';
import 'features/profile/data/repositories/profile_repository_impl.dart';
import 'features/profile/domain/repositories/profile_repository.dart';

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
      //getIt<BannerRepository>(),
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

  // Banner
  getIt.registerLazySingleton<BannerRepository>(
    () => BannerRepository(getIt<ApiClient>()),
  );

  // Address
  getIt.registerLazySingleton<AddressRepository>(
    () => AddressRepositoryImpl(
      dio: getIt<ApiClient>().dio,
    ),
  );

  // WishList
  getIt.registerLazySingleton<WishListRepository>(
    () => WishListRepository(),
  );

  // Profile
  getIt.registerLazySingleton<ProfileService>(
    () => ProfileService(getIt<ApiClient>().dio),
  );

  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(getIt<ProfileService>()),
  );
}
