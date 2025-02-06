// import 'package:flutter/material.dart';

// class SearchBarWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16),
//       margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       height: 60,
//       decoration: BoxDecoration(
//         color: Colors.grey.shade200,
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: Row(
//         children: [
//           Icon(Icons.search, color: Colors.grey.shade600),
//           SizedBox(width: 10),
//           Text(
//             "Search",
//             style: TextStyle(
//               color: Colors.grey.shade600,
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';

// class SearchBarWidget extends StatelessWidget {
//   final VoidCallback? onTap;

//   const SearchBarWidget({Key? key, this.onTap}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       type: MaterialType.transparency,
//       child: InkWell(
//         onTap: onTap,
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//           height: 60,
//           decoration: BoxDecoration(
//             color: Colors.grey.shade200,
//             borderRadius: BorderRadius.circular(30),
//           ),
//           child: Row(
//             children: [
//               Icon(Icons.search, color: Colors.grey.shade600),
//               const SizedBox(width: 10),
//                Text(
//                 "Search",
//                 style: TextStyle(
//                   color: Colors.grey.shade600,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:smile/widgets/game-contaier.dart';

class SearchBarWidget extends StatefulWidget {
  final List<Map<String, dynamic>> items;

  const SearchBarWidget({super.key, required this.items});

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = List.from(widget.items);
    _searchController.addListener(_filterItems);
  }

  void _filterItems() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredItems = widget.items
          .where((item) => item["title"].toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
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
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              return GameContainer(
                title: filteredItems[index]["title"],
                color: filteredItems[index]["color"],
                lottieAsset: filteredItems[index]["lottieAsset"],
              );
            },
          ),
        ),
      ],
    );
  }
}

