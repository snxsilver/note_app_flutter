import 'dart:convert';

// import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:intl/intl.dart';
import 'package:note_app_flutter/app/data/models/action_setting.dart';
import 'package:note_app_flutter/app/data/models/note_setting.dart';
import 'package:note_app_flutter/app/routes/app_pages.dart';
// import 'package:note_app_flutter/app/widget/app/asset/app_icons.dart';
import 'package:note_app_flutter/app/widget/app/const/app_const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as myHttp;

import '../../../widget/app/theme/app_colors.dart';
import '../../../widget/atom/app_snackbar.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> _username, _token;

  var isLoading = false.obs;

  // NotesSetting? notesSetting;
  // RxList<Note> data = <Note>[].obs;
  RxList<Note> data = RxList<Note>([]);

  // List<Note> data = [];
  var check = false.obs;

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
  }

  void getData(context) async {
    isLoading.value = true;
    update();
    // String token = await _token;
    // print("token: $token");
    final Map<String, String> headers = {
      'Authorization': 'Bearer ${await _token}'
    };
    // print(headers);
    var response = await myHttp.get(Uri.parse('${AppConst.baseApi}note'),
        headers: headers);
    // print('hello :' + response.body);
    // data.clear();
    if (response.statusCode == 200) {
      NotesSetting notesSetting =
          NotesSetting.fromJson(json.decode(response.body));
      data.value = notesSetting.data;
    } else {
      // print('Error : status code' + response.statusCode.toString());
      AppSnackbar.show(
        context,
        title: 'Error : status code' + response.statusCode.toString(),
        backgroundColor: AppColors.error,
        showCloseButton: true,
      );
    }
    // print(riwayat);
    isLoading.value = false;
    update();
  }

  void logout(context) async {
    try {
      final Map<String, String> headers = {
        'Authorization': 'Bearer ${await _token}'
      };
      var response = await myHttp
          .post(Uri.parse('${AppConst.baseApi}auth/logout'), headers: headers);
      if (response.statusCode == 200) {
        ActionSetting actionSetting =
            ActionSetting.fromJson(json.decode(response.body));
        AppSnackbar.show(
          context,
          title: actionSetting.message,
          backgroundColor: AppColors.success,
          showCloseButton: true,
        );
      } else {
        // print('Error : status code' + response.statusCode.toString());
        AppSnackbar.show(
          context,
          title: 'Error : status code' + response.statusCode.toString(),
          backgroundColor: AppColors.error,
          showCloseButton: true,
        );
      }
    } catch (err) {
      // print(err.toString());
      AppSnackbar.show(
        context,
        title: err.toString(),
        backgroundColor: AppColors.error,
        showCloseButton: true,
      );
    }
    final SharedPreferences pref = await _prefs;
    pref.setString("username", "");
    pref.setString("token", "");
    Get.offAllNamed(Routes.LOGIN);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
