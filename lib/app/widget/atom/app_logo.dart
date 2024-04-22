import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:note_app_flutter/app/widget/app/asset/app_icons.dart';
import 'package:note_app_flutter/app/widget/app/theme/app_colors.dart';
import 'package:note_app_flutter/app/widget/app/theme/app_sizes.dart';
import 'package:note_app_flutter/app/widget/app/theme/app_text_style.dart';

class AppLogo extends StatefulWidget {
  final IconData icon;
  final String title;
  final String? pretitle;
  final String? subtitle;
  final double borderRadius;
  final EdgeInsets contentPadding;
  final Color logoColor;
  final Color titleColor;
  final Color pretitleColor;
  final Color subtitleColor;
  final Color iconColor;
  final double iconSize;
  final double size;

  const AppLogo(
      {super.key,
      this.icon = AppIcons.check,
      required this.title,
      this.pretitle,
      this.subtitle,
      this.borderRadius = AppSizes.radius,
      this.contentPadding = const EdgeInsets.all(AppSizes.padding),
      this.logoColor = AppColors.success,
      this.titleColor = AppColors.black,
      this.pretitleColor = AppColors.blackLv3,
      this.subtitleColor = AppColors.blackLv5,
      this.iconColor = AppColors.white,
      this.iconSize = 24,
      this.size = 60});

  @override
  State<AppLogo> createState() => _AppLogoState();
}

class _AppLogoState extends State<AppLogo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        logo(),
        const SizedBox(
          height: AppSizes.padding * 2,
        ),
        if (widget.pretitle != null) pretitle(),
        title(),
        if (widget.subtitle != null) subtitle(),
      ],
    );
  }

  Widget logo() {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        color: widget.logoColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      padding: widget.contentPadding,
      child: Center(
        child: Icon(
          widget.icon,
          color: widget.iconColor,
          size: widget.iconSize,
        ),
      ),
    );
  }

  Widget title() {
    return Text(
      widget.title,
      style: AppTextStyle.heading4(),
    );
  }

  Widget pretitle() {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.padding / 2),
      child: Text(
        widget.pretitle ?? '',
        style: AppTextStyle.heading4(
            fontWeight: AppFontWeight.medium, color: widget.pretitleColor),
      ),
    );
  }

  Widget subtitle() {
    return Padding(
      padding: const EdgeInsets.only(top: AppSizes.padding),
      child: Text(
        widget.subtitle ?? '',
        textAlign: TextAlign.center,
        style: AppTextStyle.bodyMedium(
            fontWeight: AppFontWeight.regular, color: widget.subtitleColor),
      ),
    );
  }
}
