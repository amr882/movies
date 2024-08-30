import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class TextForm extends StatefulWidget {
  final Key formState;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType textInputType;
  final String hintText;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  const TextForm(
      {super.key,
      required this.formState,
      required this.obscureText,
      required this.controller,
      required this.textInputType,
      required this.hintText,
      this.validator,
       this.prefixIcon,
      this.suffixIcon});

  @override
  State<TextForm> createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formState,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: TextFormField(
          style: GoogleFonts.rubik(color: Colors.white),
          cursorColor: Colors.white,
          obscureText: widget.obscureText,
          controller: widget.controller,
          keyboardType: widget.textInputType,
          decoration: InputDecoration(
            suffixIcon: widget.suffixIcon,
            prefixIcon: Container(
              padding: EdgeInsets.all(1.5.h),
              height: 2.h,
              width: 2.h,
              child: widget.prefixIcon
            ),
            filled: true,
            fillColor: Color(0xff272828),
            hintStyle: TextStyle(
                color: Color(0xff797979), fontWeight: FontWeight.w400,fontSize: 1.8.h),
            border: OutlineInputBorder(),

            // focused
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.transparent)),

            // unfocused
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.transparent)),
            hintText: widget.hintText,
          ),
          validator: widget.validator,
        ),
      ),
    );
  }
}
