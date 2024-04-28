import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:note_app_flutter/app/widget/app/asset/app_icons.dart';
import 'package:note_app_flutter/app/widget/app/theme/app_colors.dart';
import 'package:note_app_flutter/app/widget/app/theme/app_sizes.dart';
import 'package:note_app_flutter/app/widget/app/theme/app_text_style.dart';
import 'package:note_app_flutter/app/widget/app/utility/app_helper.dart';
import 'package:note_app_flutter/app/widget/atom/app_appbar.dart';
import 'package:note_app_flutter/app/widget/atom/app_card.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    controller.getData(context);
    return SafeArea(
      child: Scaffold(
        appBar: appBar(context),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.padding * 1.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppCard(
                title:
                    "Complete Flutter UI App challenge and upload it on Github",
                subtitle: "1h 25m",
                icon: AppIcons.checkCircle,
                notif: true,
              ),
              SizedBox(
                height: AppSizes.padding * 1.5,
              ),
              todoList(),
            ],
          ),
        ),
        floatingActionButton: addButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  AppAppbar appBar(context) {
    return AppAppbar(
      leading: Icon(AppIcons.hamburger),
      title: "My Todo",
      centerTitle: true,
      actions: [
        GestureDetector(
          onTap: () {
            controller.logout(context);
            // Get.toNamed(Routes.LOGIN);
          },
          child: Icon(AppIcons.logout),
        ),
      ],
    );
  }

  Widget todoList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Remaining Tasks",
              style: AppTextStyle.bodyXLarge(
                fontWeight: AppFontWeight.regular,
              ),
            ),
            const SizedBox(
              width: AppSizes.padding / 4,
            ),
            Obx(
              () => Text(
                "(${controller.data.length})",
                style: AppTextStyle.bodyLarge(
                  fontWeight: AppFontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: AppSizes.padding,
        ),
        Obx(
          () => controller.isLoading.value
              ? Center(
                  child: SizedBox(
                    child: CircularProgressIndicator(),
                    width: 20,
                    height: 20,
                  ),
                )
              : controller.data.isEmpty
                  ? SizedBox.shrink()
                  : Column(
                      children: [
                        ...List.generate(
                          controller.data.length,
                          (i) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: AppSizes.padding / 2),
                              child: GestureDetector(
                                onTap: () => Get.toNamed(Routes.NOTE_DETAIL,
                                    arguments: [controller.data[i]]),
                                child: AppCard(
                                  title: controller.data[i].title,
                                  subtitle: AppHelper.formatDate(
                                      value: controller.data[i].reminder),
                                  icon: AppHelper.formatIcon(
                                      icon: controller.data[i].category),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
        )
      ],
    );
  }

  Widget addButton() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.NOTE_EDIT, arguments: ["add"]);
      },
      child: Container(
        padding: const EdgeInsets.all(AppSizes.padding / 1.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.radius * 2),
          color: AppColors.primary,
        ),
        child: Icon(
          AppIcons.add,
          size: 32,
          color: AppColors.white,
        ),
      ),
    );
  }
}
