import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:vidquiz/screens/home/home_page.dart';
import './quiz_controller.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class QuizPage extends GetView<QuizController> {
  const QuizPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuizController.to.width = MediaQuery.of(context).size.width;
    QuizController.to.height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: GetBuilder<QuizController>(
        init: QuizController(),
        builder: (controller) => Stack(
          children: [
            (controller.myQuizState == QuizState.RESULT)
                ? (controller.currentResult == true)
                    ? Align(
                        alignment: Alignment.center,
                        child: Lottie.asset(
                            'assets/json/69030-confetti-full-screen.json'),
                      )
                    : Align(
                        alignment: Alignment.center,
                        child: Lottie.asset('assets/json/wrong.json'),
                      )
                : Align(
                    alignment: Alignment.center,
                    child: Lottie.asset('assets/json/65932-testimonial.json'),
                  ),

            Align(
              alignment: Alignment.center,
              child: Container(
                height: controller.height,
                width: controller.width,
                color: Colors.deepPurple.withOpacity(0.4),
              ),
            ),
            (controller.myQuizState == QuizState.READY)
                ? _buildGetReadyBody(context, controller)
                : (controller.myQuizState == QuizState.RESULT)
                    ? _buildResultBody(
                        context, controller, controller.currentResult)
                    : (controller.myQuizState == QuizState.SCORE)
                        ? _buildFinalScoreBody(context, controller)
                        : _buildQuestionBody(context, controller)

            // _buildAnsWidget(context, controller),
          ],
        ),
      ),
    );
  }
}

_buildGetReadyBody(BuildContext context, QuizController controller) {
  TextStyle _HeadingTxtStyle = TextStyle(
    fontSize: 70,
    color: Colors.black87,
    shadows: [
      Shadow(
        blurRadius: 7.0,
        color: Colors.purple,
        offset: Offset(0, 0),
      ),
    ],
  );

  TextStyle _numberStyle = TextStyle(
      color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 200);
  return Center(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(
        height: 100,
      ),
      SizedBox(
        child: DefaultTextStyle(
          style: _HeadingTxtStyle,
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              ScaleAnimatedText('quiz.ready.title'.tr),
            ],
            onTap: () {},
          ),
        ),
      ),
      SizedBox(
        height: 160,
      ),
      SizedBox(
        width: controller.width,
        child: DefaultTextStyle(
          style: _HeadingTxtStyle,
          child: AnimatedTextKit(
            totalRepeatCount: 1,
            isRepeatingAnimation: false,
            animatedTexts: [
              ScaleAnimatedText('quiz.ready.three'.tr,
                  textAlign: TextAlign.center, textStyle: _numberStyle),
              ScaleAnimatedText('quiz.ready.two'.tr,
                  textAlign: TextAlign.center, textStyle: _numberStyle),
              ScaleAnimatedText('quiz.ready.one'.tr,
                  textAlign: TextAlign.center, textStyle: _numberStyle),
            ],
            onFinished: () {
              controller.changeState(QuizState.QUS);
            },
          ),
        ),
      )
    ],
  ));
}

_buildQuestionBody(BuildContext context, QuizController controller) {
  TextStyle _HeadingTxtStyle = TextStyle(
    fontSize: 70,
    color: Colors.black87,
    shadows: [
      Shadow(
        blurRadius: 7.0,
        color: Colors.purple,
        offset: Offset(0, 0),
      ),
    ],
  );

  TextStyle _numberStyle = TextStyle(
      color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 200);

  const colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.red,
  ];

  const questionTextStyle = TextStyle(
    fontSize: 35.0,
    fontWeight: FontWeight.bold,
  );

  const colorizeTextStyle = TextStyle(
    fontSize: 50.0,
    fontWeight: FontWeight.bold,
  );
  return Center(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(
        height: 60,
      ),
      SizedBox(
        child: AnimatedTextKit(
          animatedTexts: [
            ColorizeAnimatedText(
              'quiz.title'.tr,
              textStyle: colorizeTextStyle,
              colors: colorizeColors,
            ),
          ],
          isRepeatingAnimation: true,
        ),
      ),
      Center(
          child: Container(
              padding: EdgeInsets.fromLTRB(10, 25, 10, 25),
              child: Text(
                controller.reposController.myQuiz[controller.currentIndex]
                    ['data']['stimulus'],
                // 'What is the fastest Animal in the world?',
                style: questionTextStyle,
                textScaleFactor: 1.0,
                textAlign: TextAlign.justify,
              ))),
      _buildTimerWidget(context, controller),
      SizedBox(
        height: 70,
      ),
      (controller.reposController.myQuiz[controller.currentIndex]['data']
                  ['type'] ==
              "LIST")
          ? _buildVerticalCardWidget(context, controller)
          : (controller.reposController.myQuiz[controller.currentIndex]['data']
                      ['type'] ==
                  "GRID")
              ? _buildGridCardWidget(context, controller)
              : _buildHorizontalCardWidget(context, controller),
    ],
  ));
}

_buildResultBody(
    BuildContext context, QuizController controller, bool correctAns) {
  TextStyle _HeadingTxtStyle = TextStyle(
    fontSize: 70,
    color: Colors.black87,
    shadows: [
      Shadow(
        blurRadius: 7.0,
        color: Colors.purple,
        offset: Offset(0, 0),
      ),
    ],
  );

  return Center(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      (correctAns)
          ? SizedBox(
              width: controller.width,
              child: DefaultTextStyle(
                style: _HeadingTxtStyle,
                child: AnimatedTextKit(
                  totalRepeatCount: 1,
                  // pause: Duration(milliseconds: 300),
                  isRepeatingAnimation: false,
                  animatedTexts: [
                    ScaleAnimatedText('quiz.correct'.tr,
                        textAlign: TextAlign.center,
                        textStyle: _HeadingTxtStyle),
                  ],
                  onFinished: () {
                    controller.resultDeclared();
                    // controller.changeState(QuizState.SCORE);
                  },
                ),
              ),
            )
          : SizedBox(
              width: controller.width,
              child: DefaultTextStyle(
                style: _HeadingTxtStyle,
                child: AnimatedTextKit(
                  totalRepeatCount: 1,
                  // pause: Duration(milliseconds: 300),
                  isRepeatingAnimation: false,
                  animatedTexts: [
                    ScaleAnimatedText('quiz.wrong'.tr,
                        textAlign: TextAlign.center,
                        textStyle: _HeadingTxtStyle),
                  ],
                  onFinished: () {
                    controller.resultDeclared();
                  },
                ),
              ),
            ),
      // Lottie.asset('assets/json/69030-confetti-full-screen.json'),
    ],
  ));
}

_buildFinalScoreBody(BuildContext context, QuizController controller) {
  const colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.red,
  ];

  const colorizeTextStyle = TextStyle(
    fontSize: 50.0,
    // fontFamily: 'Horizon',
    fontWeight: FontWeight.bold,
  );
  TextStyle _HeadingTxtStyle = TextStyle(
    fontSize: 70,
    color: Colors.black87,
    shadows: [
      Shadow(
        blurRadius: 7.0,
        color: Colors.purple,
        offset: Offset(0, 0),
      ),
    ],
  );

  return Center(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        height: 60,
      ),
      SizedBox(
        child: AnimatedTextKit(
          animatedTexts: [
            ColorizeAnimatedText(
              'quiz.finalScores'.tr,
              textStyle: colorizeTextStyle,
              colors: colorizeColors,
            ),
          ],
          totalRepeatCount: 7,
          isRepeatingAnimation: false,
          onFinished: () {
            // Get.snackbar('User 123', 'Successfully created',
            //     snackPosition: SnackPosition.BOTTOM);
            Get.offAll(HomePage());
          },
        ),
      ),

      // SizedBox(
      //   height: 60,
      // ),
      SizedBox(
        child: AnimatedTextKit(
          animatedTexts: [
            ColorizeAnimatedText(
              controller.currentScore.toString(),
              textStyle: TextStyle(
                fontSize: 100.0,
                fontFamily: 'Horizon',
                fontWeight: FontWeight.bold,
              ),
              colors: colorizeColors,
            ),
          ],
          isRepeatingAnimation: true,
        ),
      ),
      Lottie.asset('assets/json/71613-sprinkles.json'),
    ],
  ));
}

_buildTimerWidget(BuildContext context, QuizController controller) {
  return SizedBox(
    width: controller.width,
    child: CircularCountDownTimer(
      duration:
          controller.reposController.mySettings['settings.timer.duration'],
      initialDuration: 0,
      controller: CountDownController(),
      width: controller.width / 6,
      height: controller.height / 6,
      ringColor: Colors.grey[300]!,
      ringGradient: null,
      fillColor: Colors.purpleAccent[100]!,
      fillGradient: null,
      backgroundColor: Colors.purple[500],
      backgroundGradient: null,
      strokeWidth: 20.0,
      strokeCap: StrokeCap.round,
      textStyle: TextStyle(
          fontSize: 33.0, color: Colors.white, fontWeight: FontWeight.bold),
      textFormat: CountdownTextFormat.MM_SS,
      isReverse: true,
      isReverseAnimation: true,
      isTimerTextShown: true,
      autoStart: true,
      onStart: () {
        print('Countdown Started');
      },
      onComplete: () {
        print('Countdown Ended');
        controller.timerExpired();
        // Countdown ended so not attempted
      },
    ),
  );
}

_buildVerticalCardWidget(BuildContext context, QuizController controller) {
  TextStyle _HeadingTxtStyle = TextStyle(
    fontSize: 10,
    color: Colors.black87,
    shadows: [
      Shadow(
        blurRadius: 7.0,
        color: Colors.purple,
        offset: Offset(0, 0),
      ),
    ],
  );

  return SizedBox(
      // width: controller.width,

      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <ElevatedButton>[
        for (int i = 0; i < 4; i++)
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize:
                    Size(controller.width * 0.9, controller.height * 0.05),
                primary: Colors.deepOrange,
              ),
              onPressed: () {
                if (controller.reposController.myQuiz[controller.currentIndex]
                        ['data']['options'][i]['isCorrect'] ==
                    1) {
                  controller.incrementScore();
                } else {
                  controller.timerExpired();
                }
              },
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Icon(Icons.brightness_1,
                    size: controller.height * 0.05, color: Colors.purple),
                SizedBox(
                  width: 20,
                ),
                Text(
                  controller.reposController.myQuiz[controller.currentIndex]
                      ['data']['options'][i]['label'],
                  style: new TextStyle(
                      color: Colors.white,
                      fontSize: 21.0,
                      fontWeight: FontWeight.w500),
                ),
              ])
              //
              ),
      ]));
}

_buildHorizontalCardWidget(BuildContext context, QuizController controller) {
  TextStyle _HeadingTxtStyle = TextStyle(
    fontSize: 10,
    color: Colors.black87,
    shadows: [
      Shadow(
        blurRadius: 7.0,
        color: Colors.purple,
        offset: Offset(0, 0),
      ),
    ],
  );

  return SizedBox(
      // width: controller.width,

      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <ElevatedButton>[
        for (int i = 0; i < 4; i++)
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize:
                    Size(controller.width * 0.1, controller.height * 0.07),
                primary: Colors.deepOrange,
              ),
              onPressed: () {
                if (controller.reposController.myQuiz[controller.currentIndex]
                        ['data']['options'][i]['isCorrect'] ==
                    1) {
                  controller.incrementScore();
                } else {
                  controller.timerExpired();
                }
              },
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.brightness_1,
                        size: controller.height * 0.02, color: Colors.purple),
                    // SizedBox(
                    //   width: 20,
                    // ),
                    Text(
                      controller.reposController.myQuiz[controller.currentIndex]
                          ['data']['options'][i]['label'],
                      style: new TextStyle(
                          color: Colors.white,
                          // fontSize: 21.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ])
              //
              ),
      ]));
}

_buildGridCardWidget(BuildContext context, QuizController controller) {
  TextStyle _HeadingTxtStyle = TextStyle(
    fontSize: 10,
    color: Colors.black87,
    shadows: [
      Shadow(
        blurRadius: 7.0,
        color: Colors.purple,
        offset: Offset(0, 0),
      ),
    ],
  );

  return SizedBox(
      // width: controller.width,
      child: Column(
    children: [
      Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <ElevatedButton>[
            for (int i = 0; i < 2; i++)
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize:
                        Size(controller.width * 0.35, controller.height * 0.10),
                    primary: Colors.deepOrange,
                  ),
                  onPressed: () {
                    if (controller
                                .reposController.myQuiz[controller.currentIndex]
                            ['data']['options'][i]['isCorrect'] ==
                        1) {
                      controller.incrementScore();
                    } else {
                      controller.timerExpired();
                    }
                  },
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.brightness_1,
                            size: controller.height * 0.05,
                            color: Colors.purple),
                        Text(
                          controller.reposController
                                  .myQuiz[controller.currentIndex]['data']
                              ['options'][i]['label'],
                          style: new TextStyle(
                              color: Colors.white,
                              // fontSize: 12.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ])
                  //
                  ),
          ]),
      SizedBox(
        height: controller.height * 0.05,
      ),
      Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <ElevatedButton>[
            for (int i = 2; i < 4; i++)
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize:
                        Size(controller.width * 0.35, controller.height * 0.10),
                    primary: Colors.deepOrange,
                  ),
                  onPressed: () {
                    if (controller
                                .reposController.myQuiz[controller.currentIndex]
                            ['data']['options'][i]['isCorrect'] ==
                        1) {
                      controller.incrementScore();
                    } else {
                      controller.timerExpired();
                    }
                  },
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.brightness_1,
                            size: controller.height * 0.05,
                            color: Colors.purple),
                        Text(
                          controller.reposController
                                  .myQuiz[controller.currentIndex]['data']
                              ['options'][i]['label'],
                          style: new TextStyle(
                              color: Colors.white,
                              // fontSize: 21.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ])
                  //
                  ),
          ]),
    ],
  ));
}






// Forr correct ans
// Lottie.asset('assets/json/68726-orange.json'),
// Lottie.asset('assets/json/69030-confetti-full-screen.json'),
