import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:smile/MyApp.dart';

void main() async {
  
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase asynchronously
  await Firebase.initializeApp();
   SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Transparent status bar
      statusBarIconBrightness: Brightness.dark, // For dark icons
      statusBarBrightness: Brightness.light, // For iOS
    ),
  );
  debugPaintSizeEnabled = false;

  // Run the app after Firebase is initialized
  runApp(MyApp());
}
