import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class DownloadButton extends StatefulWidget {
  final void Function()? onTap;
  final String? url;

  const DownloadButton({
    super.key,
    this.onTap,
    this.url,
  });

  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {

  //     .get('https://www.youtube.com/watch?v=jNQXAC9IVRw&ab_channel=jawed');

  // Future<String> getDownloadUrl(String url) async {
  //   var youtube = YoutubeExplode();
  //   var streamManifest =
  //       await youtube.videos.streamsClient.getManifest(url);
  //   var videoStreams = streamManifest.video;
  //   var oStream = videoStreams.withHighestBitrate();
  //   print(oStream.url.toString());
  //   return oStream.url.toString();
  // }




  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
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


// Scaffold(
//       body: Center(
//           child: loading
//               ? Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: LinearProgressIndicator(
//                     minHeight: 10,
//                     value: progress,
//                   ),
//                 )
//               : MaterialButton(
//                   onPressed: downloadFile,
//                   color: Colors.blue,
//                   child: Text('download'),
//                 )),
//     );