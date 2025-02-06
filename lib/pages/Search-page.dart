import 'package:flutter/material.dart';
import 'package:smile/widgets/game-contaier.dart';

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
      "lottieAsset": "images/shapes.json",
    },
    {
      "title": "Colors",
      "color": Color(0xffA597F8),
      "lottieAsset": "images/colors.json",
    },
    {
      "title": "Matching",
      "color": Color(0xffFF8F8F),
      "lottieAsset": "images/match.json",
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
