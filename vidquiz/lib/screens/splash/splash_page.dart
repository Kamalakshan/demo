import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './splash_controller.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(30, 25, 30, 25),
            child: Center(
              child: Lottie.asset('assets/json/logo.json'),
              // Image.asset('assets/images/2.0x/flutter_logo.png'),
            ),
          ),
          SizedBox(height: 50),
          CircularProgressIndicator(),
        ],
      ),
    ));
  }
}
