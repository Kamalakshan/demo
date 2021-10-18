import 'package:get/get.dart';
import 'package:vidquiz/screens/repos/repos_controller.dart';

enum QuizState { READY, QUS, RESULT, SCORE }

class QuizController extends GetxController {
  static QuizController get to => Get.find();
  final ReposController reposController = Get.find();

  double width = 0.0;
  double height = 0.0;

  QuizState myQuizState = QuizState.QUS;

  bool currentResult = false;
  int currentIndex = 0;
  int totalQus = 0;
  int currentScore = 0;
  String finalScore = 'SOME TEST';

  @override
  void onInit() {
    if (reposController.mySettings['settings.getready.enabled'] == true) {
      myQuizState = QuizState.READY;
    } else {
      myQuizState = QuizState.QUS;
    }
    totalQus = reposController.myQuiz.length;
    super.onInit();
  }

  void changeState(QuizState quizState) {
    // if (myQuizState == QuizState.QUS)

    myQuizState = quizState;
    //

    update();
  }

  void resultDeclared() {
    currentResult = false; //reset
    currentIndex++; //increment  for next Qus
    if (reposController.mySettings['settings.getready.enabled'] == true) {
      myQuizState = QuizState.READY;
    } else {
      myQuizState = QuizState.QUS;
    }
    if (currentIndex < totalQus) {
    } else {
      myQuizState = QuizState.SCORE;
      // No moree Qus Declare Score
    }

    print("Total Qus is ");
    print(totalQus);
    print("Index is ");
    print(currentIndex);
    print("Total Score is ");
    print(currentScore);
    update();
  }

  int getScore() {
    return currentScore;
  }

  incrementScore() {
    currentResult = true;
    changeState(QuizState.RESULT);
    currentScore++;
    update();
  }

  void timerExpired() {
    changeState(QuizState.RESULT);
    // if (currentIndex < totalQus) {
    //   currentIndex++;
    // }
    // myQuizState = quizState;
    //

    update();
  }
}
