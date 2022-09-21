import 'package:clima/services/location.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Networking {
  Future getResponce() async {
    var currentLocation = await Location().determinePosition();
    var lat = currentLocation[0];
    var lon = currentLocation[1];
    var url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=8f4ba99c571d41dc51523f9ca4b3a576&units=metric';
    Uri uri = Uri.parse(url);
    Response responce = await get(uri);
    // ignore: avoid_print
    var decodedData = jsonDecode(responce.body);
    return decodedData;
  }
}
