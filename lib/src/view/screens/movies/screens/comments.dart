import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Comments extends StatefulWidget {
  const Comments({super.key});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Comments',
      style: GoogleFonts.rubik(color: Colors.red, fontWeight: FontWeight.bold),
    );
  }
}
