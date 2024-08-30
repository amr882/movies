import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BackIconButton extends StatefulWidget {
  const BackIconButton({super.key});

  @override
  State<BackIconButton> createState() => _BackIconButtonState();
}

class _BackIconButtonState extends State<BackIconButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child:  Padding(
        padding: EdgeInsets.symmetric(
          vertical: 15.w,
          horizontal: 4.h
    
        ),
          child:  Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 3.h,
          ),
        ));
  }
}


// IconButton(
//       onPressed: () {
//         // Navigator.of(context).pop();
//       },
//       icon: const Icon(Icons.arrow_back_rounded,color: Color.fromARGB(255, 255, 255, 255),),
//     );
