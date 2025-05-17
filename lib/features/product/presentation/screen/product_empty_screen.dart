import 'package:flutter/material.dart';

import '../../../../core/routes/page_routes_name.dart';
import '../../../../shared/widget/empty_pages.dart';
import '../../../home/presentation/screen/categories_screen.dart';

class ProductEmptyScreen extends StatelessWidget {
  const ProductEmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyPages(
      imageType: 'svg',
      image: 'assets/vectors/search-shopping-svgrepo-com.svg',
      title: 'No products found',
      description: 'Browse other categories, hope found what you want',
      buttonText: 'Explore Categories',
      onPressed: () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const CategoriesScreen(),
          ),
          (route) => route.isFirst,
        );
      },
    );
  }
}
