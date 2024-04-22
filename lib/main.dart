import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:note_app_flutter/app/widget/app/theme/app_colors.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  SystemChrome.setEnabledSystemUIOverlays([]);
  await initializeDateFormatting('id_ID', null);
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Application",
      initialRoute: Routes.LOGIN,
      getPages: AppPages.routes,
      defaultTransition: Transition.noTransition,
      transitionDuration: Duration(seconds: 0),
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.blackLv9,
      ),
    );
    // return FutureBuilder(
    //     future: Future.delayed(Duration(seconds: 3)),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return SplashScreen();
    //       } else {
    //         return GetMaterialApp(
    //           title: "Application",
    //           initialRoute: Routes.LOGIN,
    //           getPages: AppPages.routes,
    //         );
    //       }
    //     });
  }
}
