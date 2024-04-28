import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:note_app_flutter/app/data/models/action_setting.dart';
import 'package:note_app_flutter/app/data/models/note_setting.dart';
import 'package:note_app_flutter/app/routes/app_pages.dart';
import 'package:note_app_flutter/app/widget/app/const/app_const.dart';
import 'package:note_app_flutter/app/widget/atom/app_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as myHttp;

import '../../../widget/app/theme/app_colors.dart';

class NoteEditController extends GetxController {
  //TODO: Implement NoteEditController
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> _username, _token;

  late Note data;

  var passedData = Get.arguments;
  var edit = false.obs;
  var title = "Add Todo";

  var selectedCategory = 0.obs;

  void changeCategory(int val) {
    selectedCategory.value = val;
  }

  var isLoading = false.obs;

  Future upload(context, {category, title, date}) async {
    isLoading.value = true;
    update();
    // print("category: $category, title: $title, date: $date");

    DateFormat dateFormat = DateFormat("EEEE, d MMMM yyyy", "id_ID");

    // Parse the formatted date string back into a DateTime object
    DateTime parsedDate = dateFormat.parse(date);

    // print(parsedDate); // Output: 2022-04-16 00:00:00.000

    Map<String, String> body = {
      "category": "$category",
      "title": title,
      "reminder": parsedDate.toString(),
    };

    final Map<String, String> headers = {
      'Authorization': 'Bearer ${await _token}'
    };

    var response = await myHttp.post(
      Uri.parse('${AppConst.baseApi}note'),
      headers: headers,
      body: body,
    );

    // print(body);

    if (response.statusCode == 200) {
      ActionSetting actionSetting =
          ActionSetting.fromJson(json.decode(response.body));
      AppSnackbar.show(
        context,
        title: actionSetting.message,
        backgroundColor: AppColors.success,
        showCloseButton: true,
      );
      Get.offAllNamed(Routes.HOME);
    } else {
      AppSnackbar.show(
        context,
        title: 'Error : status code ' + response.statusCode.toString(),
        backgroundColor: AppColors.error,
        showCloseButton: true,
      );
    }
    isLoading.value = false;
    update();
  }

  Future patch(context, {uuid, category, title, date}) async {
    isLoading.value = true;
    update();
    // print("category: $category, title: $title, date: $date");

    DateFormat dateFormat = DateFormat("EEEE, d MMMM yyyy", "id_ID");

    // Parse the formatted date string back into a DateTime object
    DateTime parsedDate = dateFormat.parse(date);

    // print(parsedDate); // Output: 2022-04-16 00:00:00.000

    Map<String, String> body = {
      "category": "$category",
      "title": title,
      "reminder": parsedDate.toString(),
    };

    final Map<String, String> headers = {
      'Authorization': 'Bearer ${await _token}'
    };

    var response = await myHttp.post(
      Uri.parse('${AppConst.baseApi}note/$uuid?_method=PATCH'),
      headers: headers,
      body: body,
    );

    // print(body);

    if (response.statusCode == 200) {
      ActionSetting actionSetting =
          ActionSetting.fromJson(json.decode(response.body));
      AppSnackbar.show(
        context,
        title: actionSetting.message,
        backgroundColor: AppColors.success,
        showCloseButton: true,
      );
      Get.offAllNamed(Routes.HOME);
    } else {
      AppSnackbar.show(
        context,
        title: 'Error : status code ' + response.statusCode.toString(),
        backgroundColor: AppColors.error,
        showCloseButton: true,
      );
    }
    isLoading.value = false;
    update();
  }

  void getData({required uuid}) async {
    isLoading.value = true;
    update();
    // print("getData");
    final Map<String, String> headers = {
      'Authorization': 'Bearer ${await _token}'
    };

    var response = await myHttp.get(
      Uri.parse('${AppConst.baseApi}note/$uuid'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      NoteSetting noteSetting =
          NoteSetting.fromJson(json.decode(response.body));
      data = noteSetting.data;

      titleController.text = data.title;
      dateController.text =
          DateFormat("EEEE, d MMMM yyyy", "id_ID").format(data.reminder);
      selectedCategory.value = data.category;
      update();
    } else {
      // print('Error : status code ' + response.statusCode.toString());
      // AppSnackbar.show(
      //   context,
      //   title: 'Error : status code ' + response.statusCode.toString(),
      //   backgroundColor: AppColors.error,
      //   showCloseButton: true,
      // );
    }
    isLoading.value = false;
    update();
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();

    _token = _prefs.then((SharedPreferences prefs) {
      return prefs.getString("token") ?? "";
      // return AppConst.token;
    });

    _username = _prefs.then((SharedPreferences prefs) {
      return prefs.getString("name") ?? "";
    });

    if (passedData[0] != 'add') {
      edit.value = true;
      title = "Edit Todo";
      getData(uuid: passedData[1]);
    }
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
