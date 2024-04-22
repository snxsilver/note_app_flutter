import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:note_app_flutter/app/widget/app/theme/app_colors.dart';
import 'package:note_app_flutter/app/widget/app/theme/app_sizes.dart';
import 'package:note_app_flutter/app/widget/app/utility/app_helper.dart';
import 'package:note_app_flutter/app/widget/atom/app_category.dart';
import 'package:note_app_flutter/app/widget/atom/app_icon_button.dart';
import 'package:note_app_flutter/app/widget/atom/app_icon_button_custom.dart';
import 'package:note_app_flutter/app/widget/atom/app_label.dart';

import '../../../routes/app_pages.dart';
import '../../../widget/app/asset/app_icons.dart';
import '../../../widget/atom/app_appbar.dart';
import '../controllers/note_detail_controller.dart';

class NoteDetailView extends GetView<NoteDetailController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(context),
        body: Padding(
          padding: const EdgeInsets.all(AppSizes.padding * 1.5),
          child: Column(
            children: [
              AppLabel(
                text: controller.data.title,
                width: double.infinity,
              ),
              const SizedBox(
                height: AppSizes.padding,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppCategory(
                    icon: AppHelper.formatIcon(icon: controller.data.category),
                    text: AppHelper.formatIconText(
                        icon: controller.data.category),
                  ),
                  AppLabel(
                    text: AppHelper.formatDate(value: controller.data.reminder),
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSizes.padding / 1.5,
                      horizontal: AppSizes.padding,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppAppbar appBar(context) {
    return AppAppbar(
      title: "Todo Detail",
      // centerTitle: true,
      actions: [
        AppIconButtonCustom(
          icon: AppIcons.edit,
          onTap: () {
            Get.toNamed(
              Routes.NOTE_EDIT,
              arguments: ["edit", controller.data.uuid],
            );
          },
          iconColor: AppColors.success,
        ),
        SizedBox(
          width: AppSizes.padding / 4,
        ),
        AppIconButtonCustom(
          icon: AppIcons.delete,
          onTap: () {
            controller.delete(context, uuid: controller.data.uuid);
          },
          iconColor: AppColors.error,
        ),
      ],
    );
  }
}
