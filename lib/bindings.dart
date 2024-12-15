import 'package:get/get.dart';
import 'package:less_energy/pages/home_page/less_energy_controller.dart';

class LessEnergyAppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LessEnergyController>(() => LessEnergyController());
  }
}
