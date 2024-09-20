import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/src/widgets/button.dart';
import 'package:movie_app/src/widgets/cancel_deletion.dart';
import 'package:sizer/sizer.dart';

class DeleteButtomSheet extends StatelessWidget {
  final void Function()? delete;
  final void Function()? cancel;
  const DeleteButtomSheet({super.key, this.delete, this.cancel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.h,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(0xff272828), borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h),
        child: Column(
          children: [
            Container(
              width: 17.w,
              height: 1.5.h,
              decoration: BoxDecoration(
                  color: Color(0xffff2f2f),
                  borderRadius: BorderRadius.circular(20)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: Text(
                'Delete',
                style: GoogleFonts.rubik(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 3.h),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Text(
                'Are you sure want to delete this Movie downloaded?',
                textAlign: TextAlign.center,
                maxLines: 3,
                style: GoogleFonts.rubik(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CancelDeletion(
                    cancel: cancel,
                  ),
                  Button(onTap: delete, title: 'Delete', width: 30.w)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
