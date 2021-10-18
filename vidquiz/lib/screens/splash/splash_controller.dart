import 'dart:async';
import 'package:get/get.dart';
import 'package:vidquiz/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    loading();
  }

  Future<void> loading() async {
    Timer(Duration(seconds: 5), () {
      Get.offAndToNamed(Routes.HOME);
      // Get.offAndToNamed(Routes.HOME, arguments: myAppSettings);
    });
  }
}
