import 'dart:convert';

import 'package:get/get.dart';
import 'package:note_app_flutter/app/data/models/action_setting.dart';
import 'package:note_app_flutter/app/widget/app/theme/app_colors.dart';
import 'package:note_app_flutter/app/widget/atom/app_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/note_setting.dart';
import '../../../routes/app_pages.dart';
import '../../../widget/app/const/app_const.dart';
import 'package:http/http.dart' as myHttp;

class NoteDetailController extends GetxController {
  //TODO: Implement NoteDetailController
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> _username, _token;

  var passedData = Get.arguments;
  late Note data;

  Future delete(context, {uuid}) async {
    final Map<String, String> headers = {
      'Authorization': 'Bearer ${await _token}'
    };

    var response = await myHttp.delete(
      Uri.parse('${AppConst.baseApi}note/$uuid'),
      headers: headers,
    );

    // print(response.statusCode);

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

    data = passedData[0] as Note;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
