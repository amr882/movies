import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class DownloadButton extends StatelessWidget {
  final void Function()? onTap;

  const DownloadButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40.w,
        height: 7.h,
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xffff2f2f)),
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.download,
                color: Colors.white,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Download',
                style: GoogleFonts.rubik(
                    color: Colors.white,
                    fontSize: 1.8.h,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
