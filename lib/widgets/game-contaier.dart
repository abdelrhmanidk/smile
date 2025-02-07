// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart'; // Import the Lottie package

// class GameContainer extends StatelessWidget {
//   final String title;
//   final Color color;
//   final String? lottieAsset; // Path to the Lottie JSON file or network URL

//   GameContainer({required this.title, required this.color, this.lottieAsset});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(right: 20,left: 20, bottom: 16),
//       padding: EdgeInsets.all(16),
//       height: 170,
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 30,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//           Spacer(),
//           if (lottieAsset != null)
//             Lottie.asset(
//               lottieAsset!, // Path to the Lottie JSON file
//               width: 150, // Adjust the size as needed
//               height: 200,
//               fit: BoxFit.cover,
//             ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart'; // Import the Lottie package

class GameContainer extends StatelessWidget {
  final String title;
  final Color color;
  final String? lottieAsset; // Path to the Lottie JSON file
  final String route; // GetX Route

  GameContainer({
    required this.title,
    required this.color,
    this.lottieAsset,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(route), // Navigate using GetX
      child: Container(
        margin: EdgeInsets.only(right: 20, left: 20, bottom: 16),
        padding: EdgeInsets.all(16),
        height: 170,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Spacer(),
            if (lottieAsset != null)
              Lottie.asset(
                lottieAsset!, // Path to the Lottie JSON file
                width: 150, // Adjust the size as needed
                height: 200,
                fit: BoxFit.cover,
              ),
          ],
        ),
      ),
    );
  }
}
