import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:note_app_flutter/app/widget/app/theme/app_colors.dart';
import 'package:note_app_flutter/app/widget/app/theme/app_sizes.dart';
import 'package:note_app_flutter/app/widget/atom/app_button.dart';
import 'package:note_app_flutter/app/widget/atom/app_logo.dart';
import 'package:note_app_flutter/app/widget/atom/app_text_field.dart';

// import '../../../routes/app_pages.dart';
import '../../../widget/app/theme/app_text_style.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(AppSizes.padding * 1.5),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: AppSizes.padding * 4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppLogo(
                    title: "My Todo",
                    pretitle: "Welcome to",
                    subtitle:
                        "My Todo helps you stay organized and perform your task much faster",
                  ),
                  form(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget form(context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSizes.padding * 2),
      child: Column(
        children: [
          AppTextField(
            labelText: "username",
            controller: controller.usernameController,
          ),
          const SizedBox(
            height: AppSizes.padding,
          ),
          AppTextField(
            labelText: "password",
            controller: controller.passwordController,
            type: AppTextFieldType.password,
          ),
          const SizedBox(
            height: AppSizes.padding,
          ),
          AppButton(
            onTap: () {
              controller.login(
                context,
                username: controller.usernameController.text,
                password: controller.passwordController.text,
              );
              // controller.showSnack(context);
              // Get.toNamed(Routes.HOME);
            },
            // text: "Login",
            textWidget: Obx(
              () => controller.isLoading.value
                  ? Center(
                      child: SizedBox(
                        child: CircularProgressIndicator(),
                        width: 20,
                        height: 20,
                      ),
                    )
                  : Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.padding / 2),
                        child: Text(
                          "login",
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.custom(
                            size: 16,
                            color: AppColors.white,
                            fontWeight: AppFontWeight.bold,
                          ),
                        ),
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
