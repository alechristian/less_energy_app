import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LessEnergyController extends GetxController {
  var locations = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadLocations();
  }

  Future<void> loadLocations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    locations.value = [
      {
        'name': 'Casa',
        'latitude': double.parse(prefs.getString('homeLat') ?? '-23.550520'),
        'longitude': double.parse(prefs.getString('homeLng') ?? '-46.633308'),
        'icon': Icons.home_outlined,
      },
      {
        'name': 'Universidade',
        'latitude':
            double.parse(prefs.getString('universityLat') ?? '-23.561414'),
        'longitude':
            double.parse(prefs.getString('universityLng') ?? '-46.655881'),
        'icon': Icons.school_outlined,
      },
      {
        'name': 'Trabalho',
        'latitude': double.parse(prefs.getString('workLat') ?? '-16.647747'),
        'longitude': double.parse(prefs.getString('workLng') ?? '-49.259431'),
        'icon': Icons.work_outline,
      },
    ];
  }
}
