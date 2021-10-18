import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:vidquiz/models/cue.dart';

class ReposController extends GetxController {
  static ReposController to = Get.find();
  var mySettings;
  var myCue;
  var myQuiz;
  List<dynamic> qusList = [];
  List<dynamic> courseList = [];
  List<dynamic> cueList = [];
  List<double> cuePointsMark = [];
  late Cue myCues;

  @override
  void onInit() {
    loadDataFromJson();
    super.onInit();
  }

  loadDataFromJson() async {
    mySettings = json.decode(await getSettingsJson());
    myCue = json.decode(await getCueJson());
    myQuiz = json.decode(await getQuizJson());
    courseList = mySettings['course'];
    qusList = myQuiz;
    cueList = myCue;

    // currentNote = reposController.cueList[0]['notes'];

    // print(myQuiz[0]['data']['stimulus']);
    // print(myQuiz[0]['data']['options'][0]['label']);
    // print(myQuiz[0]['data']['options'][0]['score']);
    // print(myQuiz);
    // print(cueList);
    updateCue();
  }

  Future<String> getSettingsJson() {
    return rootBundle.loadString('assets/settings.json');
  }

  Future<String> getCueJson() {
    return rootBundle.loadString('assets/json/cue.json');
  }

  Future<String> getQuizJson() {
    return rootBundle.loadString('assets/json/q2.json');
  }

// Currently supportig only on video and its cue. Not covered any other scenarios
  void updateCue() {
    cueList.forEach((e) {
      // print(e['progress']);
      cuePointsMark.add((e['progress']).toDouble());
    });
  }
}
