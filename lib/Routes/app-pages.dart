import 'package:get/get.dart';
import 'package:smile/pages/Auth.dart';
import 'package:smile/pages/Home-page.dart';
import 'package:smile/pages/Search-page.dart';
import 'package:smile/pages/chat-page.dart';
import 'package:smile/pages/profile-page.dart';
import 'app-routes.dart';



class AppPages {
  static final routes = [
  
    GetPage(name: AppRoutes.homeScreen, page: () => HomePage()),
    GetPage(name: AppRoutes.searchScreen, page: () => SearchPage()),
    GetPage(name: AppRoutes.loginScreen, page: () => AuthScreen()),
    GetPage(name: AppRoutes.profileScreen, page: () => ProfilePage()),
    GetPage(name: AppRoutes.chatScreen, page: () => ChatPage()),


   
  ];
}