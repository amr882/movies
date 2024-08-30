import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class Rating extends StatelessWidget {
  final int year;
  final String rating;
  const Rating({super.key, required this.year, required this.rating});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.h),
        child: Row(
          children: [
            Icon(
              Icons.star_half_outlined,
              color: Color(0xffff2f2f),
            ),
            SizedBox(
              width: 1.h,
            ),
            Text(
              rating,
              style: GoogleFonts.rubik(
                  color: Color(
                    0xffff2f2f,
                  ),
                  fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: EdgeInsets.symmetric(),
              child: Icon(
                Icons.chevron_right_outlined,
                color: Color(0xffff2f2f),
              ),
            ),
            Text(
              "$year",
              style: GoogleFonts.rubik(
                  color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
