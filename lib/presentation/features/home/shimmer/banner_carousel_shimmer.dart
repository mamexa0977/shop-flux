// lib/presentation/home/widgets/banner_carousel_shimmer.dart
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BannerCarouselShimmer extends StatelessWidget {
  const BannerCarouselShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 3, // show 3 placeholder banners
            itemBuilder: (_, index) {
              return Padding(
                padding: EdgeInsets.only(
                  right: 8,
                  left: index == 0 ? 0 : 0,
                ),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 64,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
            );
          }),
        ),
      ],
    );
  }
}