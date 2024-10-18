import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_app/src/feature/auth/widgets/user_id.dart';
import 'package:path/path.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  getProfileImage() {
    if (firebaseAuth.currentUser?.photoURL != null) {
      return Image.network(
        FirebaseAuth.instance.currentUser?.photoURL as String,
        height: 18.h,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        'images/20c00f0f135c950096a54b7b465e45cc.jpg',
        width: 25.w,
        height: 12.h,
        fit: BoxFit.cover,
      );
    }
  }

  File? _image;
  Future pickImage() async {
    final imageValue =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageValue != null) {
      _image = File(imageValue.path);

      print('+++++++++++++++++++++++ $_image');
    } else {
      return;
    }

    var imagePath = basename(imageValue.path);
    var refStorage = FirebaseStorage.instanceFor(
      bucket: 'gs://movie-app-35f28.appspot.com',
    ).ref(imagePath);

    await refStorage.putFile(_image!);
    var imageUrl = await refStorage.getDownloadURL();
    print(imageUrl);
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('user_id', isEqualTo: userId)
          .get();

      if (querySnapshot.size == 1) {
        final docRef = querySnapshot.docs.first.reference;
        await docRef.set({
          'user_photo': imageUrl,
        }, SetOptions(merge: true));
      } else {
        print('Error User document not found');
      }
    } catch (e) {
      print('Error updating user document: $e');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(22, 22, 28, 1),
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.rubik(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Stack(
                children: [
                  GestureDetector(
                    onTap: pickImage,
                    child: SizedBox(
                      height: 12.h,
                      width: 12.h,
                      child: Stack(
                        children: [
                          _image != null
                              ? ClipOval(
                                  child: Image.file(
                                    _image!,
                                    fit: BoxFit.cover,
                                    width: 12.h,
                                    height: 12.h,
                                  ),
                                )
                              : getProfileImage(),

                          // edit button
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              width: 4.h,
                              height: 4.h,
                              decoration: BoxDecoration(
                                  color: Color(0xffff2f2f),
                                  borderRadius: BorderRadius.circular(100)),
                              child: Center(
                                  child: SvgPicture.asset(
                                'assets/Subtract (1).svg',
                                height: 2.1.h,
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
