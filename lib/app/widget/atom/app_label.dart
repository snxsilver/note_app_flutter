import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:note_app_flutter/app/widget/app/theme/app_colors.dart';
import 'package:note_app_flutter/app/widget/app/theme/app_sizes.dart';
import 'package:note_app_flutter/app/widget/app/theme/app_text_style.dart';

class AppLabel extends StatelessWidget {
  final String text;
  final bool expanded;
  final EdgeInsets padding;
  final TextStyle? textStyle;
  final double? width;

  const AppLabel({
    super.key,
    required this.text,
    this.expanded = false,
    this.padding = const EdgeInsets.all(AppSizes.padding),
    this.textStyle,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return buildContainer(context);
  }

  Widget buildContainer(BuildContext context) {
    if (expanded) {
      return Expanded(
        child: Container(
          width: width,
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.radius * 2),
            color: AppColors.white,
          ),
          child: buildText(),
        ),
      );
    } else {
      return Container(
        width: width,
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.radius * 2),
          color: AppColors.white,
        ),
        child: buildText(),
      );
    }
  }

  Widget buildText() {
    if (expanded) {
      return SingleChildScrollView(
        child: Text(
          text,
          style: textStyle ??
              AppTextStyle.bodyMedium(fontWeight: AppFontWeight.regular),
        ),
      );
    } else {
      return Text(
        text,
        style: textStyle ??
            AppTextStyle.bodyMedium(fontWeight: AppFontWeight.regular),
      );
    }
  }
}
