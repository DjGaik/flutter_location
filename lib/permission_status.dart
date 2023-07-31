import 'package:flutter/material.dart';
import 'package:location/location.dart';

class Permission extends StatefulWidget {
  const Permission({super.key});

  @override
  PermissionStatusState createState() => PermissionStatusState();
}

class PermissionStatusState extends State<Permission> {
  final Location location = Location();

  PermissionStatus? _permissionGranted;

  Future<void> _checkPermissions() async {
    final permissionGrantedResult = await location.hasPermission();
    setState(() {
      _permissionGranted = permissionGrantedResult;
    });
  }

  Future<void> _requestPermission() async {
    if (_permissionGranted != PermissionStatus.granted) {
      final permissionRequestedResult = await location.requestPermission();
      setState(() {
        _permissionGranted = permissionRequestedResult;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Permission status: ${_permissionGranted ?? "unknown"}',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 45),
              child: ElevatedButton(
                onPressed: _checkPermissions,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 40),
                  elevation: 5,
                  backgroundColor: Colors.deepPurpleAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Check'),
              ),
            ),
            ElevatedButton(
              onPressed: _permissionGranted == PermissionStatus.granted
                  ? null
                  : _requestPermission,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(100, 40),
                elevation: 5,
                backgroundColor: Colors.lightBlueAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Request'),
            )
          ],
        ),
      ],
    );
  }
}
