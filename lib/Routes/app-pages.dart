import 'package:get/get.dart';
import 'package:smile/pages/Auth.dart';
import 'package:smile/pages/Home-page.dart';
import 'package:smile/pages/Search-page.dart';
import 'package:smile/pages/chat-page.dart';
import 'package:smile/pages/profile-page.dart';
import 'package:smile/screens/animal_grid_screen.dart';
import 'package:smile/screens/animal_puzzle_screen.dart';
import 'package:smile/screens/color_list_screen.dart';
import 'package:smile/screens/emotion_learning_screen.dart';
import 'package:smile/screens/game_screen.dart';
import 'package:smile/screens/puzzle_screen.dart';
import 'package:smile/screens/shape_list_screen.dart';
import 'app-routes.dart';



class AppPages {
  static final routes = [
  
    GetPage(name: AppRoutes.homeScreen, page: () => HomePage()),
    GetPage(name: AppRoutes.searchScreen, page: () => SearchPage()),
    GetPage(name: AppRoutes.loginScreen, page: () => AuthScreen()),
    GetPage(name: AppRoutes.profileScreen, page: () => ProfilePage()),
    GetPage(name: AppRoutes.chatScreen, page: () => ChatPage()),
     GetPage(name: AppRoutes.shapeListScreen, page: () => ShapeListScreen()),
    GetPage(name: AppRoutes.colorListScreen, page: () => ColorListScreen()),
    GetPage(name: AppRoutes.puzzleScreen, page: () => PuzzleScreen()),
    GetPage(name: AppRoutes.emotionLearningScreen, page: () => EmotionLearningScreen()),
    GetPage(name: AppRoutes.gameScreen, page: () => GameScreen()),
    GetPage(name: AppRoutes.animalGridScreen, page: () => AnimalGridScreen()),
    GetPage(name: AppRoutes.animalPuzzleScreen, page: () => AnimalPuzzleScreen()),


   
  ];
}