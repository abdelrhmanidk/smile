

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
// import 'package:smile/Routes/app-routes.dart';
// import 'package:smile/pages/Constants.dart';
// import 'package:smile/widgets/game-contaier.dart';
// import 'package:smile/widgets/search-bar.dart';

// List<Map<String, dynamic>> games = [
//   {
//     "title": "Shapes",
//     "color": kshapes,
//     "lottieAsset": "assets/shapes.json",
//   },
//   {
//     "title": "Colors",
//     "color": kColors,
//     "lottieAsset": "assets/colors.json",
//   },
//   {
//     "title": "Matching",
//     "color": kMatching,
//     "lottieAsset": "assets/match.json",
//   },
// ];

// class HomePage extends StatefulWidget {
//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   var _currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 50),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             "Hello Spidey",
//                             style: TextStyle(
//                                 fontSize: 24, fontWeight: FontWeight.bold),
//                           ),
//                           const SizedBox(height: 4),
//                           Row(
//                             children: [
//                               const Icon(Icons.menu_book, size: 16),
//                               Expanded(
//                                 child: Container(
//                                   margin: EdgeInsets.symmetric(horizontal: 10),
//                                   height: 8,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     color: Colors.grey.shade300,
//                                   ),
//                                   child: Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Container(
//                                       width: 60,
//                                       height: 8,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         color: Colors.purple,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 Container(
//                   height: 170,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Color(0xffF47979),
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   child: Center(
//                     child: Icon(
//                       Icons.play_arrow,
//                       color: Color(0xff666666),
//                       size: 70,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           SizedBox(
//             height: 10,
//           ),
//           // Search Bar
//           Expanded(child: SearchBarWidget(items: games)),
//         ],
//       ),
     
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile/Routes/app-routes.dart';
import 'package:smile/pages/Constants.dart';
import 'package:smile/widgets/search-bar.dart';

List<Map<String, dynamic>> games = [
  {
    "title": "Shapes",
    "color": kshapes,
    "lottieAsset": "assets/shapes.json",
    "route": AppRoutes.shapeListScreen,
  },
  {
    "title": "Colors",
    "color": kColors,
    "lottieAsset": "assets/colors.json",
    "route": AppRoutes.colorListScreen,
  },
  {
    "title": "Matching",
    "color": kMatching,
    "lottieAsset": "assets/match.json",
    "route": AppRoutes.puzzleScreen,
  },
  {
    "title": "Emotions",
    "color": kshapes,
    "lottieAsset": "assets/emotions.json",
    "route": AppRoutes.emotionLearningScreen,
  },
  {
    "title": "Emotion Game",
    "color": kColors,
    "lottieAsset": "assets/emotion_game.json",
    "route": AppRoutes.gameScreen,
  },
  {
    "title": "Animals",
    "color": kMatching,
    "lottieAsset": "assets/animals.json",
    "route": AppRoutes.animalGridScreen,
  },
  {
    "title": "Animal Puzzle",
    "color": kshapes,
    "lottieAsset": "assets/animal_puzzle.json",
    "route": AppRoutes.animalPuzzleScreen,
  },
];

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  height: 170,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xffF47979),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Color(0xff666666),
                      size: 70,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(child: SearchBarWidget(items: games)),
        ],
      ),
    );
  }
}
