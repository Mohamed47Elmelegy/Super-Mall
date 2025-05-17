import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_mall/features/product/data/model/product.dart';
import 'package:super_mall/shared/widget/item.dart';

class AnimatedProductList extends StatefulWidget {
  final List<Product> products;
  final double childAspectRatio;
  final int crossAxisCount;
  final double spacing;
  final EdgeInsets padding;

  const AnimatedProductList({
    super.key,
    required this.products,
    this.childAspectRatio = 0.65,
    this.crossAxisCount = 2,
    this.spacing = 16,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  State<AnimatedProductList> createState() => _AnimatedProductListState();
}

class _AnimatedProductListState extends State<AnimatedProductList>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final List<AnimationController> _animationControllers = [];
  final List<Animation<double>> _animations = [];
  bool _hasScrolled = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _scrollController.addListener(_onScroll);
  }

  void _initializeAnimations() {
    for (int i = 0; i < widget.products.length; i++) {
      final controller = AnimationController(
        duration: Duration(milliseconds: 500 + (i * 100)),
        vsync: this,
      );
      final animation = Tween<double>(begin: 1.0, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.easeOut,
        ),
      );
      _animationControllers.add(controller);
      _animations.add(animation);
    }
  }

  void _onScroll() {
    if (!_hasScrolled && _scrollController.position.pixels > 0) {
      setState(() {
        _hasScrolled = true;
      });
      for (int i = 0; i < _animationControllers.length; i++) {
        final controller = _animationControllers[i];
        final animation = Tween<double>(begin: 1.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Curves.easeOut,
          ),
        );
        _animations[i] = animation;
        controller.forward();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    for (var controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: _scrollController,
      padding: widget.padding,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount,
        crossAxisSpacing: widget.spacing.w,
        mainAxisSpacing: widget.spacing.h,
        childAspectRatio: widget.childAspectRatio,
      ),
      itemCount: widget.products.length,
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: _animations[index],
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                  0, _hasScrolled ? 20 * (1 - _animations[index].value) : 0),
              child: child,
            );
          },
          child: Item(product: widget.products[index]),
        );
      },
    );
  }
}
