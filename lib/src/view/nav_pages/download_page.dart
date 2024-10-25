import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/src/widgets/delete_buttom_sheet.dart';
import 'package:movie_app/src/widgets/download_card.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path/path.dart' as p;

class DownloadPage extends StatefulWidget {
  const DownloadPage({super.key});

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  bool isLoading = true;
  List<Map<dynamic, dynamic>> data = [];
  // List<Uint8List> thumbnail = [];

  Future<void> checkDirectoryForNewFiles() async {
    Directory directory;
    directory = (await getExternalStorageDirectory())!;

    String? externalStoragePath =
        '${(await getExternalStorageDirectory())!.path}/Movie app Downloads/';

    final path = Directory(externalStoragePath);
    if (!await path.exists()) {
      await path.create();
    }

    String newPath = '${directory.path}/Movie app Downloads/';
    directory = Directory(newPath);
    List<FileSystemEntity> files = directory.listSync();

    for (FileSystemEntity file in files) {
      final uint8list = await VideoThumbnail.thumbnailData(
        video: file.path,
        imageFormat: ImageFormat.PNG,
        timeMs: 4000,
        quality: 100,
      );
      String fileName = p.basename(file.path);

      print(file.path);
      data.add({
        'path': file.path,
        'thumbnail': uint8list,
        'name': fileName,
      });
      if (RegExp(r'\btakeout\b').hasMatch(file.uri.toString())) {
        print('error');
      }
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> openFile(String filePath) async {
    OpenFile.open(filePath);
  }

  void deleteFile(String filePath) async {
    File file = File(filePath);
    if (await file.exists()) {
      await file.delete();
      print('File deleted successfully.');
      setState(() {
        data.removeWhere((item) => item['path'] == filePath);
      });
    } else {
      print('File not found.');
    }
  }

  @override
  void initState() {
    checkDirectoryForNewFiles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(22, 22, 28, 1),
        appBar: AppBar(
          title: Text(
            'Downloads',
            style: GoogleFonts.rubik(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: data.isEmpty
            ? Center(
                child: Text(
                  'no downloads',
                  style: TextStyle(color: Colors.white),
                ),
              )
            : isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return DownloadCard(
                        uint8list: data[index]['thumbnail'],
                        videoName: data[index]['name'],
                        openVideo: () {
                          openFile(data[index]['path']);
                        },
                        deleteVideo: () {
                          showModalBottomSheet(
                              backgroundColor: Color(0xff272828),
                              context: context,
                              builder: (context) => DeleteButtomSheet(
                                    delete: () {
                                      deleteFile(data[index]['path']);
                                      Navigator.of(context).pop();
                                    },
                                    cancel: () {
                                      Navigator.of(context).pop();
                                    },
                                  ));
                        },
                      );
                    }));
  }
}
