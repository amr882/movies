import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Comments extends StatelessWidget {
  const Comments({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Comments',
      style: GoogleFonts.rubik(color: Colors.red, fontWeight: FontWeight.bold),
    );
  }
}
