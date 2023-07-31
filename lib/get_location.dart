import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

class GetLocation extends StatefulWidget {
  const GetLocation({super.key});

  @override
  GetLocationState createState() => GetLocationState();
}

class GetLocationState extends State<GetLocation> {
  final Location location = Location();

  bool _loading = false;

  LocationData? _location;
  String? _error;

  Future<void> _getLocation() async {
    setState(() {
      _error = null;
      _loading = true;
    });
    try {
      final locationResult = await location.getLocation();
      setState(() {
        _location = locationResult;
        _loading = false;
      });
    } on PlatformException catch (err) {
      setState(() {
        _error = err.code;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'Current Location: ${_error ?? '${_location ?? "unknown"}'}',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: _getLocation,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(240, 40),
            elevation: 5,
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: _loading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : const Text('Get'),
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}
