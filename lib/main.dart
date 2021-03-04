import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app.dart';

void main() async{
   // Needed to prevent exception with screen rotation
  WidgetsFlutterBinding.ensureInitialized();
   // Handle screen rotation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp
  ]);
  // Hide bottom navigation and top status bar 
  SystemChrome.setEnabledSystemUIOverlays([]);
  // Needed for firebase storage
  await Firebase.initializeApp();
  runApp(App());
}
