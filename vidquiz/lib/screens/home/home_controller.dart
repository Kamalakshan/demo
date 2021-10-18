import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:vidquiz/models/settings_model.dart';
import 'package:vidquiz/screens/repos/repos_controller.dart';

class HomeController extends GetxController with SingleGetTickerProviderMixin {
  // dynamic argumentData = Get.arguments;
  final ReposController reposControler = Get.find();
  final Duration duration = const Duration(milliseconds: 300);

  late AnimationController animationController;

  // late AnimationController _controller;
  // late Animation<double> _animation;
  // late Animation<double> _animation2;

  late SettingsModel myAppSettings;

  @override
  void onInit() {
    animationController = AnimationController(vsync: this, duration: duration);
    super.onInit();
  }
}
