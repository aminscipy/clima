import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
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
          onPressed: () {
            setState(() {
              getLocation();
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const LocationScreen();
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
