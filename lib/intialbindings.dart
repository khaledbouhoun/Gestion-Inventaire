import 'package:get/get.dart';
import 'package:invontar/class/crud.dart';
import 'package:invontar/constant/linkapi.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    // Start
    Get.put(Crud());
    // Get.lazyPut(() => TestController());
    Get.put(AppLink());
  }
}
