import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          style: TextButton.styleFrom(backgroundColor: Colors.blueGrey),
          onPressed: () async {
            var getData = Networking();
            var data = await getData.getResponce();
            setState(() {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LocationScreen(locationWeather: data);
              }));
              // from location.dart
            });
          },
          child: const Text(
            'location',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
