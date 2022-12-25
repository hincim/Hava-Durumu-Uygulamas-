import 'package:geolocator/geolocator.dart';

class LocationHelper {
  late double latitude;
  late double longitude;

  Future<void> getCurrentLocation() async {
    await Geolocator.requestPermission();

    var konum = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    latitude = konum.latitude;
    longitude = konum.longitude;
  }
}
