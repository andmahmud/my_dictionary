import 'package:get/get.dart';
import 'package:my_dictionary/feature/splash/controller/splash_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController(), );
    // Get.lazyPut<ChooseRoleController>(
    //   () => ChooseRoleController(),
    //   fenix: true,
    // );
    
  }
}
