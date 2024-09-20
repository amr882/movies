import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class DownloadCard extends StatelessWidget {
  final Uint8List uint8list;
  final String? videoName;
  final void Function()? openVideo;
  final void Function()? deleteVideo;
  const DownloadCard(
      {super.key,
      required this.uint8list,
      required this.videoName,
      required this.openVideo,
      required this.deleteVideo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
      child: Container(
        height: 15.h,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Color(0xff272828), borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.5.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.memory(uint8list,height: 10.h,width: 100,fit: BoxFit.cover,)),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    videoName!.length <= 10
                        ? videoName!
                        : "${videoName!.substring(0, 10)}...",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: GoogleFonts.rubik(color: Colors.white),
                  ),
                  MaterialButton(
                    onPressed: openVideo,
                    child: Container(
                      width: 25.w,
                      height: 3.5.h,
                      decoration: BoxDecoration(
                          color: Color(0xffff2f2f),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text(
                          'Watch Now',
                          style: GoogleFonts.rubik(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              IconButton(
                  onPressed: deleteVideo,
                  icon: Icon(
                    Icons.delete_rounded,
                    color: Color(0xffff2f2f),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
