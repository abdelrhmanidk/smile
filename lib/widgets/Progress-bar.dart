import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgressBar extends StatelessWidget {
  final String title;
  final double innerHeight;
  final Color outerColor;
  final Color innerColor;

  const ProgressBar({
    super.key,
    required this.innerHeight,
    this.outerColor = const Color(0xffEFEBEE),
    this.innerColor = Colors.purple,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * .4,
          width: MediaQuery.of(context).size.width * 0.268,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: outerColor,
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: innerHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: innerColor,
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        Text(
          title,
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          '6/10',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
