import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'glass_container.dart';
import '../../../app/constants/app_colors.dart';

class CustomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.grid_view_rounded, 'label': 'Trang chủ'},
      {'icon': Icons.thermostat_rounded, 'label': 'Thiết bị'},
      {'icon': Icons.show_chart_rounded, 'label': 'Thống kê'},
      {'icon': Icons.person_rounded, 'label': 'Cá nhân'},
    ];

    return GlassContainer(
      margin: EdgeInsets.all(16.r),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      borderRadius: 28.r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final isSelected = index == currentIndex;
          final item = items[index];

          return GestureDetector(
            onTap: () => onTap(index),
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary.withOpacity(0.15) : Colors.transparent,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                children: [
                  Icon(
                    item['icon'] as IconData,
                    color: isSelected ? AppColors.primary : AppColors.textSecondaryDark,
                    size: 22.r,
                  ),
                  if (isSelected) ...[
                    SizedBox(width: 8.w),
                    Text(
                      item['label'] as String,
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
