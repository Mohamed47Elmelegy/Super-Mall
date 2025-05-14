import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/routes/page_routes_name.dart';
import '../cubit/category_cubit.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categories')),
      body: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CategoryError) {
            return Center(child: Text(state.message));
          } else if (state is CategoryLoaded) {
            return GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1,
              ),
              itemCount: state.categories.length,
              itemBuilder: (context, index) {
                final category = state.categories[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      PageRoutesName.category,
                      arguments: category,
                    );
                  },
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: category.image.startsWith('http')
                              ? Image.network(
                                  category.image,
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                )
                              : Icon(Icons.category, size: 80),
                        ),
                        SizedBox(height: 8),
                        Text(
                          category.name['en'] ?? category.name['ar'] ?? '',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
