import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}





  
//   final Dio dio = Dio();
//   bool loading = false;
//   double progress = 0;

//   Future<bool> saveVideo(String url, String fileName) async {
//     Directory directory;
//     try {
//       if (Platform.isAndroid) {
//         if (await _requestPermission(Permission.storage)) {
//           directory = await getApplicationDocumentsDirectory();
//           String newPath = '${directory.path}/videos';
//           directory = Directory(newPath);
//           print(directory);
//         } else {
//           return false;
//         }
//       } else {
//         if (await _requestPermission(Permission.photos)) {
//           directory = await getTemporaryDirectory();
//         } else {
//           return false;
//         }
//       }
//       File saveFile = File("${directory.path}/$fileName");
//       if (!await directory.exists()) {
//         await directory.create(recursive: true);
//       }
//       if (await directory.exists()) {
//         await dio.download(url, saveFile.path,
//             onReceiveProgress: (value1, value2) {
//           setState(() {
//             progress = value1 / value2;
//           });
//         });
//         if (Platform.isIOS) {
//           await ImageGallerySaver.saveFile(saveFile.path,
//               isReturnPathOfIOS: true);
//         }
//         return true;
//       }
//       return false;
//     } catch (e) {
//       print(e);
//       return false;
//     }
//   }

//   Future<bool> _requestPermission(Permission permission) async {
//     if (await permission.isGranted) {
//       return true;
//     } else {
//       var result = await permission.request();
//       if (result == PermissionStatus.granted) {
//         return true;
//       }
//     }
//     return false;
//   }

//   downloadFile() async {
//     setState(() {
//       loading = true;
//       progress = 0;
//     });
//     bool downloaded = await saveVideo(
//         "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4",
//         "test1.mp4");
//     if (downloaded) {
//       print("File Downloaded");
//     } else {
//       print("Problem Downloading File");
//     }
//     setState(() {
//       loading = false;
//     });
//   }

// // show file path from phone

//   Future<void> checkDirectoryForNewFiles() async {
//     Directory directory;
//     directory = await getApplicationDocumentsDirectory();
//     String newPath = '${directory.path}/videos/';
//     directory = Directory(newPath);
//     List<FileSystemEntity> files = directory.listSync();
//     for (FileSystemEntity file in files) {
//       print(file.path);
//       if (RegExp(r'\btakeout\b').hasMatch(file.uri.toString())) {
//         print('error');
//       }
//     }
//   }







              //  'https://www.youtube.com/watch?v=jNQXAC9IVRw&ab_channel=jawed';