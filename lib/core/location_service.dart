import 'dart:developer';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

// Position? position;

class LocationService {
  static Position? position;

  static Future<bool> checkPermission() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.openAppSettings();
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      return false;
    }
    await getCurrentPosition();
    return true;
  }

  static Future<Position?> getCurrentPosition() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position pos) {
      position = pos;
    }).catchError((e) {
      log(e);
    });
    return position;
  }

  static Future<void> getCoordinatesFromAddress(String address,
      {Function(double lat, double long)? onSuccess,
      Function(String error)? onError}) async {
    try {
      final locations = await locationFromAddress(address);

      onSuccess?.call(locations.first.latitude, locations.first.longitude);
    } catch (e) {
      onError?.call(e.toString());
      // setState(() {
      //   _coordinates = 'Error: $e';
      // });
    }
  }
}
