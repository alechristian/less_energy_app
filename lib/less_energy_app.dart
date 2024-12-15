import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:less_energy/bindings.dart';
import 'package:less_energy/pages/config_page/config_view.dart';
import 'package:less_energy/pages/home_page/less_enery_view.dart';

class LessEnergyApp extends StatelessWidget {
  const LessEnergyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: LessEnergyAppBindings(),
      title: 'LessEnergy',
      builder: (context, child) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: child,
      ),
      locale: const Locale('pt', 'BR'),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => LessEnergyView(),
          binding: LessEnergyAppBindings(),
        ),
        GetPage(
          name: '/config',
          page: () => ConfigView(),
          binding: LessEnergyAppBindings(),
        ),
      ],
    );
  }
}
