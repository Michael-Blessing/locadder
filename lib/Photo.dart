import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'screens/camera_screen.dart';

class takePhoto extends StatelessWidget {
  List<CameraDescription> cameras = [];

  @override
  Widget build(BuildContext context) {
    try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: CameraScreen(),
    );
  } on CameraException catch (e) {
    print('Error in fetching the cameras: $e');
  } 
  }
}