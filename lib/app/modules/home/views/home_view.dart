import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loco/app/core/values/s_dimension.dart';
import 'package:loco/app/core/values/s_spacing.dart';
import 'package:loco/app/modules/home/views/home_widget_view.dart';
import 'package:lottie/lottie.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Where am I ?'),
        titleTextStyle:
            TextStyle(color: Colors.white, fontSize: SDimension.xxl),
        centerTitle: true,
        backgroundColor: Get.theme.colorScheme.primary,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/animation.json',repeat: true),
          Obx(() => Column(
            mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StatDisplay(
                      label: 'Latitude :',
                      value: controller.latitude.toStringAsFixed(6)),
                  SSpacing.lgH,
                  StatDisplay(
                      label: 'Longitude :',
                      value: controller.longitude.toStringAsFixed(6)),
                  SSpacing.lgH,
                  StatDisplay(
                      label: 'Time :', value: controller.currentTime.value),
                ],
              )),
          SSpacing.lgH,
          ElevatedButton(
              onPressed: () =>
                  controller.listenToLocationUpdates(distanceFilter: 10),
              child: const Text(
                'Get Live Location Updates',
              )),
          SSpacing.lgH,
          ElevatedButton(
              onPressed: controller.openInMaps,
              child: const Text(
                'Open In Maps',
              )),
        ],
      )),
    );
  }
}
