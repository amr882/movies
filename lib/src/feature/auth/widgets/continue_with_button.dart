import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class ContinueWith extends StatefulWidget {
  final String? continueWithImage;
  final void Function()? onTap;
  final String? methodName;
  final double? imageHeight;
  const ContinueWith(
      {super.key,
      required this.onTap,
      required this.continueWithImage,
      required this.methodName,
      required this.imageHeight});

  @override
  State<ContinueWith> createState() => _ContinueWithState();
}

class _ContinueWithState extends State<ContinueWith> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0.7.h),
          child: Container(
            width: 80.w,
            height: 7.3.h,
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadiusDirectional.circular(12),
                border:
                    Border.all(color: const Color.fromARGB(255, 88, 88, 88))),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    '${widget.continueWithImage}',
                    height: widget.imageHeight!.h,
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Text(
                    'Continue with ${widget.methodName}',
                    style: GoogleFonts.rubik(
                      color: Colors.white,
                      fontSize: 2.h,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
