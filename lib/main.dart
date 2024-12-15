import 'dart:async';

import 'package:flutter/material.dart';
import 'package:less_energy/less_energy_app.dart';
import 'package:less_energy/services/location_service.dart';

FutureOr<void> main() async {
  runApp(const MyApp());
  final LocationService locationService = LocationService();
  locationService.initializeNotifications();
  locationService.startLocationUpdates();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const LessEnergyApp();
  }
}
