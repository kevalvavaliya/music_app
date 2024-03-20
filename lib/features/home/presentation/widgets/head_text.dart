import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeadText extends StatelessWidget {
  const HeadText({super.key,required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Text(
        text,
        style: GoogleFonts.rubik(fontSize: 40, fontWeight: FontWeight.bold),
      ),
    );
  }
}
