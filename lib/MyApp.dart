import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile/Routes/app-pages.dart';
import 'package:smile/pages/Constants.dart';
import 'package:smile/pages/Home-page.dart';
import 'package:smile/pages/Main-page.dart';
import 'package:smile/pages/splash-screen.dart';

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;

  @override
  void initState() {
    super.initState();
    // Listen to auth state changes and update the user state
    FirebaseAuth.instance.authStateChanges().listen((User? currentUser) {
      setState(() {
        user = currentUser;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppPages.routes,
      theme: ThemeData(scaffoldBackgroundColor: kBackgroundColorPrimary),
      // Dynamically decide the home screen
      home: user != null ? MainScreen() : SplashScreen(),
    );
  }
}
