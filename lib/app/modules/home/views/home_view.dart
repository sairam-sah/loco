import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loco/app/core/values/s_dimension.dart';
import 'package:loco/app/core/values/s_spacing.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Where am I ?'),
        titleTextStyle: TextStyle(color:Colors.white,fontSize: SDimension.xxl),
        centerTitle: true,
        backgroundColor: Get.theme.colorScheme.primary,
      ),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Obx(() => Text(
              controller.locationMessage.value,
              textAlign: TextAlign.center,)),
            SSpacing.lgH,
            ElevatedButton(
              onPressed: () => controller.listenToLocationUpdates(distanceFilter: 100),
             child: const Text('Get Live Location Updates',
             ) ),
             SSpacing.lgH,
             ElevatedButton(
              onPressed:controller.stopListeningToLocationUpdates,
             child: const Text('Stop Updates',
             ) ),
          ],
        )
      ),
    );
  }
}
