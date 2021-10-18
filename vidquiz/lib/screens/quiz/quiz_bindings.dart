import 'package:get/get.dart';
import './quiz_controller.dart';

class QuizBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(QuizController());
    }
}