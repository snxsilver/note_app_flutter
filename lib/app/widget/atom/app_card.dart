import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:note_app_flutter/app/widget/app/theme/app_colors.dart';
import 'package:note_app_flutter/app/widget/app/theme/app_sizes.dart';
import 'package:note_app_flutter/app/widget/app/theme/app_text_style.dart';

class AppCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool notif;
  final double size;

  const AppCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.notif = false,
    this.size = 32,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radius * 2),
        color: notif ? AppColors.greenLv6 : AppColors.white,
      ),
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: notif ? AppColors.success : AppColors.primary,
                  size: size,
                ),
                const SizedBox(
                  width: AppSizes.padding / 2,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: AppSizes.padding / 2.5),
                    child: Text(
                      title,
                      softWrap: true,
                      style: AppTextStyle.bodyLarge(
                        fontWeight: AppFontWeight.regular,
                        color: AppColors.secondary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: AppSizes.padding,
          ),
          Padding(
            padding: const EdgeInsets.only(top: AppSizes.padding / 1.75),
            child: Text(
              subtitle,
              style: AppTextStyle.bodySmall(
                fontWeight: AppFontWeight.regular,
                color: AppColors.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
