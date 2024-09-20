import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class CancelDeletion extends StatelessWidget {
  final void Function()? cancel;
  const CancelDeletion({super.key, this.cancel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: cancel,
      child: Container(
        width: 30.w,
        height: 7.h,
        decoration: BoxDecoration(
            color: const Color(0xffffedf0),
            borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Text(
            'Cancel',
            style: GoogleFonts.rubik(
                color: Colors.black,
                fontSize: 1.8.h,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
