import 'dart:convert';

import 'package:get/get.dart';
import 'package:note_app_flutter/app/data/models/login_setting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as myHttp;

import '../../../routes/app_pages.dart';
import '../../../widget/app/theme/app_colors.dart';
import '../../../widget/atom/app_snackbar.dart';
import 'package:note_app_flutter/app/widget/app/const/app_const.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late Future<String> _username, _token;

  var isLoading = false.obs;

  checkToken(token, name) async {
    String tokenStr = await token;
    String nameStr = await name;
    // print("token: $tokenStr, username: $nameStr");
    if (tokenStr != "" && nameStr != "") {
      await Future.delayed(const Duration(seconds: 1));
      Get.offAllNamed(Routes.HOME);
    }
  }

  Future login(context, {username, password}) async {
    isLoading.value = true;
    update();
    print("username: $username, password: $password");
    LoginSetting? loginSetting;
    Map<String, String> body = {"username": username, "password": password};
    // print("check1.5");
    var response = await myHttp.post(
      Uri.parse('${AppConst.baseApi}auth/login'),
      body: body,
    );
    // print("check2");
    if (response.statusCode == 200) {
      print(response.body);
      loginSetting = LoginSetting.fromJson(json.decode(response.body));
      saveUser(
        context,
        token: loginSetting.access_token,
        username: loginSetting.data.username,
      );
      // print(loginSetting);
    } else if (response.statusCode == 401) {
      // ignore: use_build_context_synchronously
      AppSnackbar.show(
        context,
        title: 'Wrong username or password',
        backgroundColor: AppColors.error,
        showCloseButton: true,
      );
    } else {
      print("check3");
      // ignore: use_build_context_synchronously
      AppSnackbar.show(
        context,
        title: 'Error : status code' + response.statusCode.toString(),
        backgroundColor: AppColors.error,
        showCloseButton: true,
      );
    }
    isLoading.value = false;
    update();
  }

  Future saveUser(context, {token, username}) async {
    try {
      final SharedPreferences pref = await _prefs;
      pref.setString("username", username);
      pref.setString("token", token);
      Get.offAllNamed(Routes.HOME);
    } catch (err) {
      // print(err.toString());
      AppSnackbar.show(
        context,
        title: err.toString(),
        backgroundColor: AppColors.error,
        showCloseButton: true,
      );
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    _token = _prefs.then((SharedPreferences prefs) {
      return prefs.getString("token") ?? "";
    });

    _username = _prefs.then((SharedPreferences prefs) {
      return prefs.getString("username") ?? "";
    });

    checkToken(_token, _username);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
