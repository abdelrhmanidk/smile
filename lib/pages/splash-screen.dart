import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile/Routes/app-routes.dart';
import 'package:smile/pages/Constants.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColorSecondary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 130,
          ),
          // Display SVG image
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SvgPicture.asset(
              'images/splash.svg', // Your SVG asset path
              height: 300, // Adjust height as needed
            ),
          ),
          SizedBox(height: 30), // Space between image and button
          // Get Started button
          Spacer(),



          Stack(
            children: [
              Positioned(
                top: 20,
                child: 
                SvgPicture.asset(
              'images/rocket.svg', // Your SVG asset path
              height: 300, // Adjust height as needed
            ),
              
              ),
            
              

              Container(
                height: MediaQuery.of(context).size.height *
                    0.4, // 40% of the screen height
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    SizedBox(height: 30,),
                    Text(
                  "Education\nWithout Limits",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),  // Space between the two texts
                // Subtitle Text: Description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Discover a world of knowledge and take the first step towards mastering new skills, at your own pace.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),),
                ),
              
                Spacer(),
                    InkWell(
                      onTap: () {
                        Get.toNamed(
                            AppRoutes.loginScreen); // Navigates to the login screen
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(40)),
                        width: 200,
                        height: 70,
                        child: Center(
                          child: Text(
                            'Get Started',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .03,)
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
