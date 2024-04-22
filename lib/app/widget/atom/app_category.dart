import 'package:flutter/material.dart';
import 'package:note_app_flutter/app/widget/app/theme/app_colors.dart';
import 'package:note_app_flutter/app/widget/app/theme/app_sizes.dart';
import 'package:note_app_flutter/app/widget/app/theme/app_text_style.dart';

class AppCategory extends StatefulWidget {
  final IconData icon;
  final String text;
  final Function()? onTap;
  final bool selected;
  final double? width;

  const AppCategory({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
    this.selected = false,
    this.width,
  });

  @override
  State<AppCategory> createState() => _AppCategoryState();
}

class _AppCategoryState extends State<AppCategory> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.padding, vertical: AppSizes.padding / 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.radius * 2),
          color: widget.selected ? AppColors.primary : AppColors.white,
        ),
        width: widget.width,
        child: Row(
          children: [
            Icon(
              widget.icon,
              color: widget.selected ? AppColors.white : AppColors.primary,
            ),
            SizedBox(
              width: AppSizes.padding / 2,
            ),
            Text(
              widget.text,
              style: AppTextStyle.bodyMedium(
                fontWeight: AppFontWeight.regular,
                color: widget.selected ? AppColors.white : AppColors.secondary,
              ),
            )
          ],
        ),
      ),
    );
  }
}
