import 'package:flutter/material.dart';
import 'package:vision_website/screens/app/providers/theme_provider.dart';

class PageIndicator extends StatelessWidget {
  final int currentPage;
  final int pageCount;
  
  const PageIndicator({
    super.key,
    required this.currentPage,
    required this.pageCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pageCount, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == currentPage 
                ? AppTheme.diSerria  // Active circle color
                : AppTheme.silverSand.withOpacity(0.5), // Inactive circle color
          ),
        );
      }),
    );
  }
}