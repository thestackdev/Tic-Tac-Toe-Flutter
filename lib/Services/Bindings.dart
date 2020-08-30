import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:tic_tac_toe/Get/Core.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Core>(() => Core());
  }
}
