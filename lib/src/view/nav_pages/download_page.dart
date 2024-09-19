import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class DownloadPage extends StatefulWidget {
  const DownloadPage({super.key});

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  Future<void> download(String url) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      var baseStorage = await getExternalStorageDirectory();

// to generate download link
      var youtube = YoutubeExplode();
      var streamManifest = await youtube.videos.streamsClient.getManifest(url);
      var videoFuture = youtube.videos.get(url);
      var video = await videoFuture;

      var videoStreams = streamManifest.video;

      var oStream = videoStreams.withHighestBitrate();
      print(oStream.url.toString()); // download link

      var downloadDir = Directory('${baseStorage!.path}/${video.title}.mp4');
      await downloadDir.create(recursive: true);
      // Check if the file already exists

      final filePath = '${baseStorage.path}/${video.title}.mp4';
      final file = File(filePath);
      if (await file.exists()) {
        print('File already exists.+++++++++++++++++++++++++++++++++++++++++++++++++++++');
        return;
      }
  
      await FlutterDownloader.enqueue(
        url: oStream.url.toString(),
        savedDir: baseStorage.path,
        showNotification: true,
        openFileFromNotification: true,
        fileName: video.title

      );
      print('${baseStorage.path}/${video.title}.mp4');
    }
  }

  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      DownloadTaskStatus status = data[1] as DownloadTaskStatus;
      if (status == DownloadTaskStatus.complete) {
        print('complete');
      }
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: () {
                download(
                    'https://www.youtube.com/watch?v=4xG2aJa6UyY&ab_channel=AdamEschborn');
              },
              color: Colors.blue,
              child: Text('download'),
            ),
          ],
        ),
      ),
    );
  }
}
