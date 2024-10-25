import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_app/src/feature/auth/login/lets_you_in.dart';
import 'package:movie_app/src/feature/auth/widgets/user_id.dart';
import 'package:movie_app/src/view/screens/movies/widgets/profile_component.dart';
import 'package:movie_app/src/view/screens/profile/edit_profile.dart';
import 'package:movie_app/src/view/screens/profile/get_premium.dart';
import 'package:movie_app/src/view/screens/profile/help_center.dart';
import 'package:movie_app/src/view/screens/profile/privacy_policy.dart';
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
      return ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.network(
          FirebaseAuth.instance.currentUser!.photoURL.toString(),
          fit: BoxFit.cover,
          width: 15.h,
          height: 15.h,
        ),
      );
    } else {
      return Container(
          height: 13.5.h,
          width: 13.5.h,
          decoration: BoxDecoration(
              color: Color(0xff272828),
              borderRadius: BorderRadius.circular(100)),
          child: Center(
              child: Icon(
            Icons.person,
            color: Color(0xff474747),
            size: 8.h,
          )));
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
      FirebaseAuth.instance.currentUser!.updatePhotoURL(imageUrl);
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
                      height: 15.h,
                      width: 15.h,
                      child: Stack(
                        children: [
                          _image != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.file(
                                    _image!,
                                    fit: BoxFit.cover,
                                    width: 15.h,
                                    height: 15.h,
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
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Text(
                FirebaseAuth.instance.currentUser?.displayName.toString() ==
                        null
                    ? 'user'
                    : FirebaseAuth.instance.currentUser!.displayName.toString(),
                style: GoogleFonts.rubik(
                    fontSize: 2.5.h,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                FirebaseAuth.instance.currentUser!.email.toString(),
                style: GoogleFonts.rubik(
                    fontSize: 1.5.h,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 4.h,
              ),
              Container(
                width: 90.w,
                height: 10.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.transparent,
                    border: Border.all(color: Colors.red)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => GetPremium()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset('assets/Frame 2610512.png'),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Get Premium!',
                              style: GoogleFonts.rubik(
                                  fontSize: 1.7.h,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Generated faux Swedish for the masses!',
                              style: GoogleFonts.rubik(
                                  fontSize: 1.2.h,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              ProfileComponent(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => EditProfile()));
                  },
                  componentIcon: Icons.person,
                  componentText: 'Edit Profile'),
              ProfileComponent(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HelpCenter()));
                  },
                  componentIcon: Icons.help,
                  componentText: 'Help Center'),
              ProfileComponent(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PrivacyPolicy()));
                  },
                  componentIcon: Icons.privacy_tip,
                  componentText: 'Privacy Policy'),
              ProfileComponent(
                  onTap: () async {
                    GoogleSignIn googleSignIn = GoogleSignIn();
                    googleSignIn.disconnect();
                    await FirebaseAuth.instance.signOut();

                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const LetsYouIn()));
                  },
                  componentIcon: Icons.logout_rounded,
                  componentText: 'Logout')
            ],
          ),
        ],
      ),
    );
  }
}
