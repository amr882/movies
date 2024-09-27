import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class DownloadButton extends StatefulWidget {
  final String? url;
  const DownloadButton({
    super.key,
    required this.url,
  });

  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  Future<void> download(String url) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      String? externalStoragePath =
          '${(await getExternalStorageDirectory())!.path}/Movie app Downloads/';
// to generate download link
      var youtube = YoutubeExplode();
      var streamManifest = await youtube.videos.streamsClient.getManifest(url);
      var videoFuture = youtube.videos.get(url);
      var video = await videoFuture;

      var videoStreams = streamManifest.muxed;

      var oStream = videoStreams.withHighestBitrate();
      print(oStream.url.toString()); // download link

      final directory = Directory(externalStoragePath);
      if (!await directory.exists()) {
        await directory.create();
      }

      FlutterDownloader.enqueue(
        url: oStream.url.toString(),
        savedDir: externalStoragePath,
        showNotification: true,
        openFileFromNotification: true,
        fileName: '${video.title}.mp4',
      );
    }
  }

  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = DownloadTaskStatus.values[data[1]];
      int progress = data[2];
      if (status == DownloadTaskStatus.complete) {
        print('complete');
      }
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
    super.initState();
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        download(widget.url.toString());
      },
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
