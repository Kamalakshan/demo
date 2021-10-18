import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidquiz/LocaleString.dart';
import 'package:vidquiz/routes/app_pages.dart';

import 'package:vidquiz/screens/repos/repos_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Get.put<HomeController>(HomeController());
  Get.put(ReposController());

  runApp(
    GetMaterialApp(
      // key: myVidApp,
      debugShowCheckedModeBanner: false,
      translations: LocaleString(),
      locale: Locale('en', 'US'),
      title: 'title'.tr,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: AppPages.routes,
    ),
  );
}
