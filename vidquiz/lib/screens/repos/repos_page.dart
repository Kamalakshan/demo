import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './repos_controller.dart';

class ReposPage extends GetView<ReposController> {
  const ReposPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReposPage'),
      ),
      body: Container(),
    );
  }
}
