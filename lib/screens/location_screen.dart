import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/services/networking.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, this.locationWeather});

  // ignore: prefer_typing_uninitialized_variables
  final locationWeather;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  // ignore: prefer_typing_uninitialized_variables
  var temp;
  // ignore: prefer_typing_uninitialized_variables
  var weatherIcon;
  // ignore: prefer_typing_uninitialized_variables
  var message;
  // ignore: prefer_typing_uninitialized_variables
  var cityName;

  @override
  void initState() {
    super.initState();
    updateUi(widget.locationWeather);
  }

  void updateUi(data) {
    setState(() {
      if (data == null) {
        temp = 0;
        weatherIcon = 'error';
        message = 'Unable to load';
        cityName = '';
        return;
      }
      double temperature = data['main']['temp'];
      temp = temperature.round();
      var condition = data['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      cityName = data['name'];
      message = weather.getMessage(temp);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var getData = Networking();
                      var data = await getData.getResponce();
                      updateUi(data);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const CityScreen();
                      }));
                      if (typedName != null) {
                        var getData = Networking();
                        var data = await getData.getCityWeather(typedName);
                        updateUi(data);
                      }
                      ;
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    Text(
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  '$message in $cityName',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
