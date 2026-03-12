import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile/Routes/app-routes.dart';
import 'package:smile/pages/Constants.dart';
import 'package:smile/widgets/Progress-bar.dart';

class ProfilePage extends StatelessWidget {
  final List<Map<String, dynamic>> scores = [
    {"title": "Shapes", "score": "5/10"},
    {"title": "Colors", "score": "6/10"},
    {"title": "Matching", "score": "3/10"},
    
  ];

  final List<Map<String, dynamic>> lastLessons = [
    {"title": "Shapes", "duration": "15min", "icon":"assets/shapes.png", "color":kshapes},
    {"title": "Colors", "duration": "20min", "icon":"assets/colors.png", "color":kColors},
  ];

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColorSecondary,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
              
                SizedBox(height: 20),

                // Score Section
                Row(
                  children: [
                    ProgressBar(
                      innerHeight: 200,
                      innerColor: kshapes,
                      title: 'Shapes',
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ProgressBar(
                      innerHeight: 200,
                      innerColor: kColors,
                      title: 'Colors',
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ProgressBar(
                      innerHeight: 200,
                      innerColor: kMatching,
                      title: 'Matching',
                    ),
                  ],
                ),

                SizedBox(height: 10),
                
                SizedBox(height: 20),

              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Last Lessons",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: lastLessons.map((lesson) {
                        return Container(
                          height: 70,
                          decoration: BoxDecoration(
                              color: Color(0xffF9F9F9),
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(40)),
                          margin: EdgeInsets.only(bottom: 10),
                          child: Center(
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: lesson["color"],
                                      borderRadius: BorderRadius.circular(50)),
                                      child: Center(child: Image.asset(lesson["icon"]),),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  lesson["title"],
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  height: 50,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: lesson["color"],
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.timer, color: Color(0xff666666),),
                                        SizedBox(width: 5,),
                                        Text(
                                          lesson["duration"],
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xff666666),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
