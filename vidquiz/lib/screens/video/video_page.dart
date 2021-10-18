import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:vidquiz/screens/components/AppBarPainter.dart';
import './video_controller.dart';
import 'package:chewie/chewie.dart';
import 'package:progresso/progresso.dart';

class VideoPage extends GetView<VideoController> {
  const VideoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VideoController.to.width = MediaQuery.of(context).size.width;
    VideoController.to.height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(elevation: 0, title: Text('vid.title'.tr), actions: [
        IconButton(
          tooltip: 'vid.edit'.tr,
          enableFeedback: true,
          icon: Icon(Icons.edit),
          onPressed: () {
            controller.videoPlayerController.pause();
            _displayTextInputDialog(context, controller);
          },
        ),
      ]),
      body: GetBuilder<VideoController>(
        init: VideoController(),
        builder: (controller) => GetBuilder<VideoController>(
            init: VideoController(),
            builder: (controller) => Stack(children: [
                  if (controller.isVideoReady)
                    Chewie(controller: controller.chewieController),

                  // Text(
                  //   "(${controller.progress})",
                  // ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Spacer(flex: 5),
                      Padding(
                          // Even Padding On All Sides
                          padding: EdgeInsets.all(10.0),
                          child: Progresso(
                              start: 0,
                              points: controller.reposController.cuePointsMark,
                              pointColor: Colors.black,
                              pointInnerColor: Colors.white,
                              pointInnerRadius: 7.0,
                              progress: controller.progress,
                              progressStrokeWidth: 15,
                              progressStrokeCap: StrokeCap.round,
                              backgroundStrokeCap: StrokeCap.round)),
                      Spacer(),
                    ],
                  ),

                  if (controller.visibleNotes)
                    AnimatedOpacity(
                      // If the widget is visible, animate to 0.0 (invisible).
                      // If the widget is hidden, animate to 1.0 (fully visible).
                      opacity: controller.visibleNotes ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 50),
                      // The green box must be a child of the AnimatedOpacity widget.
                      child: InkWell(
                        child: getOverlayNotesWidget(
                            controller.width * 0.9, controller.height * 0.5),
                        onTap: () {
                          controller.removeNotes();
                        },
                      ),
                    ),
                  CustomPaint(
                    painter: AppBarPainter(),
                    child: Container(height: 0),
                  ),
                ])),
      ),
      // ],
    );
  }

  Widget getOverlayNotesWidget(_width, _height) {
    return new Container(
      alignment: Alignment.bottomCenter,
      child: Card(
          elevation: 8,
          color: Colors.deepPurple, //.withOpacity(0.7),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            width: _width * .99,
            height: 220,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: _width * .88,
                  child: Center(
                    child: Text(
                      controller.currentNote,
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Future<void> _displayTextInputDialog(
      BuildContext context, VideoController vidController) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('vid.hint.notes'.tr),
          content: TextField(
            controller: vidController.textFieldController,
            decoration: InputDecoration(hintText: 'vid.hint.notes'.tr),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('vid.cancel'.tr),
              onPressed: () {
                vidController.videoPlayerController.play();
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('vid.ok'.tr),
              onPressed: () {
                print(vidController.textFieldController.text);
                controller.saveNotes();
                // vidController.videoPlayerController.play();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
