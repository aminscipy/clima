import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

class Location {
  Future determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    var location = await Geolocator.getCurrentPosition();
    var lat = location.latitude;
    var lon = location.longitude;
    var url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=8f4ba99c571d41dc51523f9ca4b3a576';
    Uri uri = Uri.parse(url);
    Response responce = await get(uri);
    // ignore: avoid_print
    print(responce.body);
  }
}

getLocation() {
  return Location().determinePosition();
}
