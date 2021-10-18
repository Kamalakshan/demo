import 'package:get/get.dart';
import './repos_controller.dart';

class ReposBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(ReposController());
    }
}