import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:recycling_people/camera/camera_screen.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();
  final camera = cameras.first; // We use first camera.

  runApp(
    MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CameraScreen(camera: camera),
    ),
  );
}
