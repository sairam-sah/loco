import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  // Observable variables for location and time
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var currentTime = ''.obs;
  var timestamp = ''.obs;

   StreamSubscription<Position>? positionStream;

  // Function to check and request location permissions
  Future<bool> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Permission Denied', 'Please grant location permission.');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
        'Permission Permanently Denied',
        'Location access is permanently denied. Please enable it from settings.',
      );
      return false;
    }
    return true;
  }

    // Listen to live location updates 
  void listenToLocationUpdates({int distanceFilter = 10}) async{
      bool hasPermission = await requestLocationPermission();
       if (!hasPermission) return;
    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high, // High accuracy for precise updates
      distanceFilter: distanceFilter, // Minimum distance in meters to trigger an update
    );

    //to Subscribe to position updates
    positionStream = Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
         latitude.value = position.latitude;
        longitude.value = position.longitude;
        currentTime.value = DateTime.now().toLocal().toString();
  
    }, onError: (e) {
      latitude.value = 0.0;
      longitude.value = 0.0;
      currentTime.value = 'Error: $e';
    });
  }

// to open in maps
  Future<void> openInMaps() async {
    final String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);

    } else {
      Get.snackbar('Error', 'Could not open the map application.');
    }
  }

// share the location
  Future<void> shareLocation() async {
    if (latitude.value != 0.0 && longitude.value != 0.0) {
      String message =
          'Here is my current location:\nhttps://www.google.com/maps/search/?api=1&query=${latitude.value},${longitude.value}';
      await Share.share(message);
    } else {
      Get.snackbar('Location Error', 'Unable to share location. Please ensure location updates are active.');
    }
  }

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


}
