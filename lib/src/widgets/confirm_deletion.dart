import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class ConfirmDeletion extends StatelessWidget {
  final void Function()? confirm;
  const ConfirmDeletion({super.key, required this.confirm});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: confirm,
      child: Container(
        width: 30.w,
        height: 7.h,
        decoration: BoxDecoration(
            color: const Color(0xffff2f2f),
            borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Text(
            'Confirm',
            style: GoogleFonts.rubik(
                color: Colors.white,
                fontSize: 1.8.h,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
