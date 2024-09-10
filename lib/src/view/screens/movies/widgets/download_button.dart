import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
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

  // Future<String> getDownloadUrl(String videoId) async {
  //   var youtube = YoutubeExplode();
  //   var streamManifest =
  //       await youtube.videos.streamsClient.getManifest(videoId);
  //   var videoStreams = streamManifest.video;
  //   var oStream = videoStreams.withHighestBitrate();
  //   print(oStream.url.toString());
  //   return oStream.url.toString();
  // }



  
  final Dio dio = Dio();
  bool loading = false;
  double progress = 0;

  Future<bool> saveVideo(String url, String fileName) async {
    Directory directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = await getApplicationDocumentsDirectory();
          String newPath = '${directory.path}/videos';
          directory = Directory(newPath);
          print(directory);
        } else {
          return false;
        }
      } else {
        if (await _requestPermission(Permission.photos)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }
      File saveFile = File("${directory.path}/$fileName");
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        await dio.download(url, saveFile.path,
            onReceiveProgress: (value1, value2) {
          setState(() {
            progress = value1 / value2;
          });
        });
        if (Platform.isIOS) {
          await ImageGallerySaver.saveFile(saveFile.path,
              isReturnPathOfIOS: true);
        }
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  downloadFile() async {
    setState(() {
      loading = true;
      progress = 0;
    });
    bool downloaded = await saveVideo(
        "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4",
        "video.mp4");
    if (downloaded) {
      print("File Downloaded");
    } else {
      print("Problem Downloading File");
    }
    setState(() {
      loading = false;
    });
  }
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