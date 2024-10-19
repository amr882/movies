import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class ProfileComponent extends StatelessWidget {
  final IconData componentIcon;
  final String componentText;
  final void Function()? onTap;

  const ProfileComponent(
      {super.key,
      required this.componentIcon,
      required this.componentText,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90.w,
        height: 7.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.7.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    componentIcon,
                    color: Colors.white,
                    size: 3.5.h,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    componentText,
                    style: GoogleFonts.rubik(
                        fontSize: 1.7.h,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}








// GestureDetector(
//       onTap: () {
//         Navigator.of(context)
//             .push(MaterialPageRoute(builder: (context) => componentPage));
//       },
//       child: Container(
//         color: Colors.red,
//         width: 90.w,
//         height: 7.h,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Row(
//               children: [
//                 Icon(
//                   componentIcon,
//                   color: Colors.white,
//                   size: 4.h,
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Text(
//                   componentText,
//                   style: GoogleFonts.rubik(
//                       fontSize: 1.2.h,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//             Icon(
//               Icons.arrow_forward_ios_rounded,
//               color: Colors.white,
//             )
//           ],
//         ),
//       ),
//     );