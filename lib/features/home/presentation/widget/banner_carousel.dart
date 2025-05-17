import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/network/api_constants.dart' show ApiConstants;
import '../../../../core/theme/app_color/app_color_light.dart';
import '../../../../shared/widget/skeleton_screen.dart';
import '../../logic/cubit/banner_cubit.dart';

class BannerCarousel extends StatelessWidget {
  const BannerCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannerCubit, BannerState>(
      builder: (context, state) {
        if (state is BannerLoading) {
          return const SkeletonBannerCarousel();
        } else if (state is BannerError) {
          return Center(child: Text(state.message));
        } else if (state is BannerLoaded) {
          // Determine how many active banners we need to display
          int activeCount = 0;
          final selectedBanners = state.banners.where((banner) {
            if (banner.isActive == 1) {
              activeCount++;
              return true;
            }
            return false;
          }).toList();
          
          return CarouselSlider(
            options: CarouselOptions(
              height: 200.h,
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
            items: selectedBanners.map((banner) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.r),
                      child: Image.network(
                        '${ApiConstants.bannerslink}${banner.image}',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Icon(Icons.error),
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}