import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:less_energy/constants/colors.dart';
import 'package:less_energy/pages/home_page/less_energy_controller.dart';
import 'package:less_energy/services/location_service.dart';
import 'package:less_energy/utils/messages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LessEnergyView extends StatefulWidget {
  @override
  _LessEnergyViewState createState() => _LessEnergyViewState();
}

class _LessEnergyViewState extends State<LessEnergyView> {
  late LocationService locationService;
  List<Map<String, dynamic>> locations = [];

  @override
  void initState() {
    super.initState();
    locationService = LocationService();
  }

  @override
  Widget build(BuildContext context) {
    late LocationService locationService = LocationService();
    return GetBuilder<LessEnergyController>(
      init: LessEnergyController(),
      initState: (state) {},
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.secondaryYellow,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.refresh, color: AppColors.tertiaryLight),
              onPressed: () async {
                await controller.loadLocations();
              },
            ),
            actions: [
              IconButton(
                icon:
                    const Icon(Icons.settings, color: AppColors.tertiaryLight),
                onPressed: () {
                  Get.toNamed('/config');
                },
              )
            ],
            backgroundColor: AppColors.primary,
            title: const Text('Less Energy',
                style: TextStyle(fontSize: 32, color: AppColors.tertiaryLight)),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              await controller.loadLocations();
            },
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Locais Salvos',
                        style: TextStyle(
                            fontSize: 24, color: AppColors.tertiaryLight)),
                  ],
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 200.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                  ),
                  items: locations.map((location) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                location['icon'],
                                size: 50,
                                color: AppColors.tertiaryLight,
                              ),
                              Text(
                                location['name'],
                                style: const TextStyle(
                                    fontSize: 24,
                                    color: AppColors.tertiaryLight),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Latitude: ${location['latitude']}',
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: AppColors.tertiaryLight),
                              ),
                              Text(
                                'Longitude: ${location['longitude']}',
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: AppColors.tertiaryLight),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 40),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Mensagens predefinidas',
                        style: TextStyle(
                            fontSize: 24, color: AppColors.tertiaryLight)),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: ListTile(
                          leading: Icon(messages[index].icon,
                              color: AppColors.tertiaryLight),
                          title: Text(
                            messages[index].text,
                            style: const TextStyle(
                                fontSize: 16, color: AppColors.tertiaryLight),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 12,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
