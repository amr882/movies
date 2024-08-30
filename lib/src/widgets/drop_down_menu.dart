import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class GenderSelect extends StatelessWidget {
  const GenderSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      hintText: 'Gender',
      inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: Color(0xff939393)),
          fillColor: Color(0xff272828),
          filled: true,
          border: OutlineInputBorder(
              borderSide: BorderSide(style: BorderStyle.none),
              borderRadius: BorderRadius.circular(10))),
      textStyle: TextStyle(
          color: Color(0xff939393),
          fontWeight: FontWeight.w400,
          fontSize: 1.5.h),
      dropdownMenuEntries: const [
        DropdownMenuEntry(
            value: 'male',
            label: 'male',
            labelWidget:
                Text('male', style: TextStyle(color: Color(0xff939393)))),
        DropdownMenuEntry(
            value: 'female',
            label: 'female',
            labelWidget:
                Text('female', style: TextStyle(color: Color(0xff939393)))),
      ],
      width: 37.5.h,
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(
          Color(0xff272828),
        ),
      ),
      trailingIcon: Icon(
        Icons.arrow_drop_down_rounded,
        color: Colors.white,
      ),
    );
  }
}
