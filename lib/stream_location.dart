import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class StreamLocation extends StatefulWidget {
  const StreamLocation({super.key});

  @override
  StreamLocationState createState() => StreamLocationState();
}

class StreamLocationState extends State<StreamLocation> {
  Location location = Location();
  Map<String, double>? currentLocation;
  StreamSubscription<Map<String, double>>? locationSubscription;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    locationSubscription?.cancel();
    super.dispose();
  }

  void startListening() {
    locationSubscription = location.onLocationChanged.listen((value) {
      setState(() {
        currentLocation = value as Map<String, double>?;
      });
    }) as StreamSubscription<Map<String, double>>?;
  }

  void stopListening() {
    locationSubscription?.cancel();
    setState(() {
      currentLocation = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: startListening,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 40),
                  elevation: 5,
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Icon(Icons.play_arrow),
              ),
              const SizedBox(width: 40),
              ElevatedButton(
                onPressed: stopListening,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 40),
                  elevation: 5,
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Icon(Icons.stop),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (currentLocation == null)
            const CircularProgressIndicator()
          else
            Text(
              "Location: ${currentLocation!["latitude"]} ${currentLocation!["longitude"]}",
              style: const TextStyle(fontSize: 18),
            ),
        ],
      ),
    );
  }
}
