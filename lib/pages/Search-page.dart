// import 'package:flutter/material.dart';
// import 'package:smile/widgets/game-contaier.dart';

// class SearchPage extends StatefulWidget {
//   const SearchPage({super.key});

//   @override
//   _SearchPageState createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//   TextEditingController _searchController = TextEditingController();
//   List<Map<String, dynamic>> games = [
//     {
//       "title": "Shapes",
//       "color": Color(0xffFFF7E5),
//       "lottieAsset": "assets/shapes.json",
//     },
//     {
//       "title": "Colors",
//       "color": Color(0xffA597F8),
//       "lottieAsset": "assets/colors.json",
//     },
//     {
//       "title": "Matching",
//       "color": Color(0xffFF8F8F),
//       "lottieAsset": "assets/match.json",
//     },
//   ];

//   List<Map<String, dynamic>> filteredGames = [];

//   @override
//   void initState() {
//     super.initState();
//     filteredGames = List.from(games);
//     _searchController.addListener(_filterGames);
//   }

//   void _filterGames() {
//     String query = _searchController.text.toLowerCase();
//     setState(() {
//       filteredGames = games
//           .where((game) => game["title"].toLowerCase().contains(query))
//           .toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           SizedBox(height: 50),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             child: Container(
//               height: 60,
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade200,
//                 borderRadius: BorderRadius.circular(30),
//               ),
//               child: Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     child: Icon(Icons.search, color: Colors.grey.shade600),
//                   ),
//                   Expanded(
//                     child: TextField(
//                       controller: _searchController,
//                       decoration: InputDecoration(
//                         hintText: "Search",
//                         border: InputBorder.none,
//                         hintStyle: TextStyle(
//                           color: Colors.grey.shade600,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: filteredGames.length,
//               itemBuilder: (context, index) {
//                 return GameContainer(
//                   title: filteredGames[index]["title"],
//                   color: filteredGames[index]["color"],
//                   lottieAsset: filteredGames[index]["lottieAsset"],
//                 );
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
import 'package:smile/widgets/game-contaier.dart';
import 'package:smile/Routes/app-routes.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  
  List<Map<String, dynamic>> games = [
    {
      "title": "Shapes",
      "color": Color(0xffFFF7E5),
      "lottieAsset": "assets/shapes.json",
      "route": AppRoutes.shapeListScreen,
    },
    {
      "title": "Colors",
      "color": Color(0xffA597F8),
      "lottieAsset": "assets/colors.json",
      "route": AppRoutes.colorListScreen,
    },
    {
      "title": "Matching",
      "color": Color(0xffFF8F8F),
      "lottieAsset": "assets/match.json",
      "route": AppRoutes.puzzleScreen,
    },
    {
      "title": "Emotions",
      "color": Color(0xffFFC857),
      "lottieAsset": "assets/emotions.json",
      "route": AppRoutes.emotionLearningScreen,
    },
    {
      "title": "Emotion Game",
      "color": Color(0xff4ECDC4),
      "lottieAsset": "assets/emotion_game.json",
      "route": AppRoutes.gameScreen,
    },
    {
      "title": "Animals",
      "color": Color(0xffFF6B6B),
      "lottieAsset": "assets/animals.json",
      "route": AppRoutes.animalGridScreen,
    },
    {
      "title": "Animal Puzzle",
      "color": Color(0xff1A535C),
      "lottieAsset": "assets/animal_puzzle.json",
      "route": AppRoutes.animalPuzzleScreen,
    },
  ];

  List<Map<String, dynamic>> filteredGames = [];

  @override
  void initState() {
    super.initState();
    filteredGames = List.from(games);
    _searchController.addListener(_filterGames);
  }

  void _filterGames() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredGames = games
          .where((game) => game["title"].toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Icon(Icons.search, color: Colors.grey.shade600),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: "Search",
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredGames.length,
              itemBuilder: (context, index) {
                return GameContainer(
                  title: filteredGames[index]["title"],
                  color: filteredGames[index]["color"],
                  lottieAsset: filteredGames[index]["lottieAsset"],
                  route: filteredGames[index]["route"], // Pass route
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
