import 'package:super_mall/features/home/data/model/category_model.dart';
import 'package:super_mall/features/product/data/model/product.dart';

class HomeDataModel {
  final List<Category> categories;
  final List<Product> topSelling;
  final List<Product> newProducts;
  //final List<dynamic> banners;

  HomeDataModel({
    required this.categories,
    required this.topSelling,
    required this.newProducts,
    //required this.banners,
  });
}
