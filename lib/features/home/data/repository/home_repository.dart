import '../../../product/data/repository/product.dart';
import '../model/home_data_model.dart';
import 'banner_repository.dart';
import 'category_repository.dart';

abstract class HomeRepositoryBase {
  Future<HomeDataModel> getHomeData();
}

class HomeRepository implements HomeRepositoryBase {
  final ProductRepository _productRepository;
  final CategoryRepository _categoryRepository;
  //final BannerRepository _bannerRepository;

  HomeRepository(
    this._productRepository,
    this._categoryRepository,
    //this._bannerRepository,
  );

  @override
  Future<HomeDataModel> getHomeData() async {
    try {
      // جمع البيانات من repositories مختلفة
      //final categories = await _categoryRepository.getCategories();
      final topSelling = await _productRepository.getTopSellingProducts();
      final newProducts = await _productRepository.getNewProducts();
      //final banners = await _bannerRepository.getBanners();

      return HomeDataModel(
        categories: [],
        topSelling: topSelling,
        newProducts: newProducts,
        //banners: [],
      );
    } catch (e) {
      throw Exception('Failed to load home data: $e');
    }
  }
}
