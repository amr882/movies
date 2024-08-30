import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class Button extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final double width;
  const Button({super.key, required this.onTap, required this.title, required this.width});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.h),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: width,
            height: 7.h,
            decoration: BoxDecoration(
                color: const Color(0xffff2f2f),
                borderRadius: BorderRadius.circular(12)),
            child: Center(
              child: Text(
                title,
                style: GoogleFonts.rubik(
                    color: Colors.white,
                    fontSize: 1.8.h,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ));
  }
}
