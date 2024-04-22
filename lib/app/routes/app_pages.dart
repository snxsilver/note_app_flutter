import 'package:get/get.dart';

import 'package:note_app_flutter/app/modules/home/bindings/home_binding.dart';
import 'package:note_app_flutter/app/modules/home/views/home_view.dart';
import 'package:note_app_flutter/app/modules/login/bindings/login_binding.dart';
import 'package:note_app_flutter/app/modules/login/views/login_view.dart';
import 'package:note_app_flutter/app/modules/note_detail/bindings/note_detail_binding.dart';
import 'package:note_app_flutter/app/modules/note_detail/views/note_detail_view.dart';
import 'package:note_app_flutter/app/modules/note_edit/bindings/note_edit_binding.dart';
import 'package:note_app_flutter/app/modules/note_edit/views/note_edit_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.NOTE_DETAIL,
      page: () => NoteDetailView(),
      binding: NoteDetailBinding(),
    ),
    GetPage(
      name: _Paths.NOTE_EDIT,
      page: () => NoteEditView(),
      binding: NoteEditBinding(),
    ),
  ];
}
