import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:vidquiz/models/cue.dart';
import 'package:vidquiz/routes/app_routes.dart';
import 'package:vidquiz/screens/repos/repos_controller.dart';

//enum ViewState { initial, pause, notes, data }

class VideoController extends GetxController with SingleGetTickerProviderMixin {
  static VideoController get to => Get.find();
  final ReposController reposController = Get.find();

  late TextEditingController textFieldController = TextEditingController();

  late final AnimationController animationController;
  late final Animation<Offset> offsetAnimation;
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  double width = 0.0;
  double height = 0.0;
  bool visibleNotes = false;
  bool isVideoReady = false;
  double progress = 0;
  int videoInSeconds = 0;
  String currentNote = '';

  @override
  void onInit() {
    // Annimation code
    animationController = AnimationController(
        value: 0.0,
        duration: const Duration(milliseconds: 500),
        reverseDuration: const Duration(milliseconds: 250),
        vsync: this)
      ..addStatusListener((status) {
        //No need to listen right now
      });
    initializePlayer();
    super.onInit();
  }

  @override
  void onClose() {
    isVideoReady = false;
    videoPlayerController.removeListener(() {});
    animationController.dispose();
    videoPlayerController.dispose();
    chewieController.dispose();
    textFieldController.dispose();
    super.onClose();
  }

  Future<void> initializePlayer() async {
    videoPlayerController =
        VideoPlayerController.asset('assets/video/Butterfly-209.mp4');

    // await videoPlayerController.initialize();
    await Future.wait([videoPlayerController.initialize()]);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: false,
      looping: false,
      autoInitialize: true,
      showControlsOnInitialize: false,
      showOptions: false,
      showControls: false,
    );

    videoInSeconds = videoPlayerController.value.duration.inSeconds;
    // print("TOTAL Seconds of Video $videoInSeconds");
    chewieController.play();
    isVideoReady = true;

    videoPlayerController.addListener(() {
      int inSeconds = videoPlayerController.value.position.inSeconds;
      // print("current second being played $inSeconds");
      progress = inSeconds * (1 / videoInSeconds);
      // print("progress value between 0 and 1.0 $progress");

      reposController.cuePointsMark.forEach((e) {
        // for each progress point get the second
        // print(e);
        if (progress == e) {
          currentNote = reposController.cueList[0]['notes'];
          showNotes();
          videoPlayerController.seekTo(Duration(seconds: inSeconds + 1));
        }
      });

      // if (inSeconds == 9) {
      //   showNotes();
      //   videoPlayerController.seekTo(Duration(seconds: inSeconds + 1));
      //   // do some action
      // }
      if (videoPlayerController.value.position ==
          videoPlayerController.value.duration) {
        // Get.defaultDialog(
        //   title: 'title'.tr,
        //   middleText: "Would you like to proceed?",
        //   // backgroundColor: Colors.purple,
        //   // titleStyle: TextStyle(color: Colors.white),
        //   // middleTextStyle: TextStyle(color: Colors.white),
        //   onConfirm: () {
        //     Get.toNamed(Routes.QUIZ);
        //   },
        //   onCancel: () {
        //     // Get.back();
        //     Get.toNamed(Routes.VIDEOPLAYER);
        //   },
        // );

        // mov to quiz screen
        Get.toNamed(Routes.QUIZ);
      }
      update();
    });

    update();
  }

  void showNotes() {
    visibleNotes = true;
    chewieController.pause();
    update();
  }

  void removeNotes() {
    visibleNotes = false;
    chewieController.play();
    update();
  }

  void saveNotes() {
    reposController.cueList.add(Cue(progress, textFieldController.text));
    videoPlayerController.play();
    update();
  }
}
