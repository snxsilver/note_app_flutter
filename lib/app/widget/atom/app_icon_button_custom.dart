import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:note_app_flutter/app/widget/app/theme/app_colors.dart';
import 'package:note_app_flutter/app/widget/app/theme/app_sizes.dart';

class AppIconButtonCustom extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Function() onTap;
  const AppIconButtonCustom({
    super.key,
    required this.icon,
    this.iconColor = AppColors.black,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSizes.padding / 4),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: AppColors.blackLv8,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: 24,
        ),
      ),
    );
  }
}
