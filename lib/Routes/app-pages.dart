import 'package:get/get.dart';
import 'package:smile/pages/Auth.dart';
import 'package:smile/pages/Home-page.dart';
import 'app-routes.dart';



class AppPages {
  static final routes = [
  
    GetPage(name: AppRoutes.homeScreen, page: () => HomePage()),
  
    GetPage(name: AppRoutes.loginScreen, page: () => AuthScreen()),
   
  ];
}