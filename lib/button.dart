import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  final color;
  final textColor;
  final String text;
  final buttonTapped;

  const MyButton(
      {super.key,
      required this.color,
      required this.textColor,
      required this.text,
      this.buttonTapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(7.5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Container(
            color: color,
            child: Center(
                child: Text(
              text,
              style: GoogleFonts.montserrat(
                  fontSize: 30, color: textColor, fontWeight: FontWeight.w500),
            )),
          ),
        ),
      ),
    );
  }
}
