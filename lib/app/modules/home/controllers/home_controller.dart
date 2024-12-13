import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  var locationMessage = 'Waiting for location'.obs;
  late double latitude;
  late double longitude;
   StreamSubscription<Position>? positionStream;
   
  void listenToLocationUpdates({int distanceFilter = 10}) {
    // Configure location settings
    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high, // High accuracy for precise updates
      distanceFilter: distanceFilter, // Minimum distance in meters to trigger an update
    );

    // Subscribe to position updates
    positionStream = Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      locationMessage.value =
          'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
    }, onError: (e) {
      locationMessage.value = 'Error: $e';
    });
  }


  void stopListeningToLocationUpdates() {
    positionStream?.cancel();
    locationMessage.value = 'Stopped listening to location updates.';
  }

  Future<void> openInMaps() async {
    final String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    final String appleMapsUrl = 'https://maps.apple.com/?q=$latitude,$longitude';

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else if (await canLaunch(appleMapsUrl)) {
      await launch(appleMapsUrl);
    } else {
      Get.snackbar('Error', 'Could not open the map application.');
    }
  }
}




  // Future<void> getCurrentLocation() async {
  //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     locationMessage.value = 'Location services are disabled. Please enable them';
  //     await Geolocator.openLocationSettings();
  //     return;
  //   }

    // LocationPermission permission = await Geolocator.checkPermission();
    // if (permission == LocationPermission.denied) {
    //   permission = await Geolocator.requestPermission();
    //   if (permission == LocationPermission.denied) {
    //     locationMessage.value = 'Location permissions are denied.';
    //     return;
    //   }
    // }

  //   if (permission == LocationPermission.deniedForever) {
  //     locationMessage.value =
  //         'Location permissions are permanently denied. Cannot access location.';
  //     return;
  //   }

  //   final position = await Geolocator.getCurrentPosition();
  //   locationMessage.value =
  //       'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
  // }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
     positionStream?.cancel(); // Clean up the stream when the controller is disposed
    super.onClose();
  }

  void increment() => count.value++;
}
