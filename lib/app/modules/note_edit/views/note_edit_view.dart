import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:note_app_flutter/app/widget/app/const/app_category.dart';
import 'package:note_app_flutter/app/widget/atom/app_text_field.dart';

// import '../../../routes/app_pages.dart';
import '../../../widget/app/asset/app_icons.dart';
import '../../../widget/app/theme/app_colors.dart';
import '../../../widget/app/theme/app_sizes.dart';
import '../../../widget/atom/app_appbar.dart';
import '../../../widget/atom/app_category.dart';
import '../../../widget/atom/app_icon_button_custom.dart';
// import '../../../widget/atom/app_label.dart';
import '../controllers/note_edit_controller.dart';

class NoteEditView extends GetView<NoteEditController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(context),
        body: body(),
      ),
    );
  }

  AppAppbar appBar(context) {
    return AppAppbar(
      title: controller.title,
      // centerTitle: true,
      actions: [
        AppIconButtonCustom(
          icon: AppIcons.save,
          onTap: () {
            if (controller.passedData[0] == 'add') {
              controller.upload(
                context,
                category: controller.selectedCategory.value,
                title: controller.titleController.text,
                date: controller.dateController.text,
              );
            } else {
              controller.patch(
                context,
                uuid: controller.passedData[1],
                category: controller.selectedCategory,
                title: controller.titleController.text,
                date: controller.dateController.text,
              );
            }
          },
          iconColor: AppColors.primary,
        ),
      ],
    );
  }

  Widget body() {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.padding * 1.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            maxLines: 2,
            minLines: 2,
            controller: controller.titleController,
          ),
          const SizedBox(
            height: AppSizes.padding,
          ),
          Obx(
            () => Wrap(
              spacing: AppSizes.padding,
              children: [
                ...List.generate(categoryList.length, (i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppSizes.padding / 2),
                    child: AppCategory(
                      icon: categoryList[i]["icon"],
                      text: categoryList[i]["text"],
                      width: 150,
                      onTap: () {
                        controller.changeCategory(categoryList[i]["value"]);
                      },
                      selected: controller.selectedCategory.value ==
                          categoryList[i]["value"],
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(
            height: AppSizes.padding,
          ),
          Expanded(
            child: AppTextField(
              type: AppTextFieldType.datePicker,
              hintText: "Select Date",
              controller: controller.dateController,
            ),
          ),
        ],
      ),
    );
  }
}
