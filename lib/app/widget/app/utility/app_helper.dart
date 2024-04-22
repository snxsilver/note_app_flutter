import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app_flutter/app/widget/app/asset/app_icons.dart';
import 'package:note_app_flutter/app/widget/app/const/app_category.dart';

class AppHelper {
  AppHelper._();

  static String formatDate({required DateTime value}) {
    var res = DateFormat("MMMM d").format(value);
    return res;
  }

  static IconData formatIcon({required int icon}) {
    IconData res = categoryList.firstWhere((el) => el['value'] == icon)['icon'];
    return res;
  }

  static String formatIconText({required int icon}) {
    String res = categoryList.firstWhere((el) => el['value'] == icon)['text'];
    return res;
  }
}
