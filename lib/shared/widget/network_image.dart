import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  const ProductImage({
    super.key,
    required this.imageUrl,
    this.width = 100,
    this.height = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        width: width,
        height: height,
        color: Colors.grey[300],
        child: Icon(Icons.broken_image, size: width * 0.5, color: Colors.grey),
      ),
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          width: width,
          height: height,
          color: Colors.grey[200],
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}