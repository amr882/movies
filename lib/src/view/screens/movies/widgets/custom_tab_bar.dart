import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class CustomTabBar extends StatelessWidget {
  final Function()? onTap;
  final String? text;
  final Color? color;

  const CustomTabBar({super.key, this.onTap, this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: 45.w,
        height: 5.h,
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: BorderDirectional(bottom: BorderSide(color: color!))),
        child: Center(
          child: Text(
            text!,
            style: GoogleFonts.rubik(color: color, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
