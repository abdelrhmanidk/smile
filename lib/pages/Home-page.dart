// import 'package:flutter/material.dart';
// import 'package:smile/widgets/game-contaier.dart';
// import 'package:smile/widgets/search-bar.dart';

// List<Map<String, dynamic>> games = [
//   {
//     "title": "Shapes",
//     "color":Color(0xffFFF7E5),
//     "lottieAsset":"images/shapes.json",
//   },
//   {
//     "title": "Colors",
//     "color": Color(0xffA597F8),
//     "lottieAsset":"images/colors.json",
//   },
//   {
//     "title": "Matching",
//     "color":Color(0xffFF8F8F),
//     "lottieAsset": "images/match.json",
//   },
// ];

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             height: 50,
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 30,
//                       backgroundColor: Colors.grey.shade300,
//                       child: Icon(Icons.person, color: Colors.grey.shade600),
//                     ),
//                     SizedBox(width: 10),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Hello Spidey",
//                             style: TextStyle(
//                                 fontSize: 18, fontWeight: FontWeight.bold),
//                           ),
//                           SizedBox(height: 4),
//                           Row(
//                             children: [
//                               Icon(Icons.menu_book, size: 16),
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
//                     Container(
//                       height: 62,
//                       width: 62,
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.black),
//                         borderRadius: BorderRadius.circular(50),
//                       ),
//                       child: Center(
//                         child: Icon(Icons.menu, size: 28),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
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
//           // Search Bar
//           SearchBarWidget(),
//           // Game Containers
//           Expanded(
//             child: ListView.builder(
//               itemCount: games.length,
//               itemBuilder: (context, index) {
//                 return GameContainer(
//                     title: games[index]["title"],
//                     color: games[index]["color"],
//                     lottieAsset: games[index]["lottieAsset"]);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile/Routes/app-routes.dart';
import 'package:smile/pages/Constants.dart';
import 'package:smile/pages/Search-page.dart';
import 'package:smile/widgets/game-contaier.dart';
import 'package:smile/widgets/search-bar.dart';

List<Map<String, dynamic>> games = [
  {
    "title": "Shapes",
    "color": kshapes,
    "lottieAsset": "images/shapes.json",
  },
  {
    "title": "Colors",
    "color": kColors,
    "lottieAsset": "images/colors.json",
  },
  {
    "title": "Matching",
    "color": kMatching,
    "lottieAsset": "images/match.json",
  },
];

class HomePage extends StatelessWidget {
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
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.profileScreen);

                      },
                      
                      child: CircleAvatar(
                        
                        radius: 30,
                        backgroundColor: Colors.grey.shade300,
                        child: Icon(Icons.person, color: Colors.grey.shade600),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Hello Spidey",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.menu_book, size: 16),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  height: 8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade300,
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      width: 60,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.purple,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        print("Navigating to search screen");
                        Get.toNamed(AppRoutes.searchScreen);
                      }, // Navigates to the login screenƒ
                      child: Container(
                        height: 62,
                        width: 62,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Icon(Icons.menu, size: 28),
                        ),
                      ),
                    ),
                  ],
                ),
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

          SizedBox(
            height: 10,
          ),
          // Search Bar

          Expanded(child: SearchBarWidget(items: games)),

          // Game Containers
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: games.length,
          //     itemBuilder: (context, index) {
          //       return GameContainer(
          //         title: games[index]["title"],
          //         color: games[index]["color"],
          //         lottieAsset: games[index]["lottieAsset"],
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
