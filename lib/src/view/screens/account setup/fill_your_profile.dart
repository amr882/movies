import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/src/feature/auth/widgets/user_id.dart';
import 'package:movie_app/src/view/screens/account%20setup/choose_your_interest.dart';
import 'package:movie_app/src/widgets/button.dart';
import 'package:movie_app/src/widgets/drop_down_menu.dart';
import 'package:movie_app/src/widgets/text_form.dart';

import 'package:sizer/sizer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:phone_text_field/phone_text_field.dart';

class FillYourProfile extends StatefulWidget {
  const FillYourProfile({super.key});

  @override
  State<FillYourProfile> createState() => _FillYourProfileState();
}

class _FillYourProfileState extends State<FillYourProfile> {
//controllers

  TextEditingController firstNameController = TextEditingController();
  TextEditingController nickNameController = TextEditingController();
// keys
  GlobalKey<FormState> firstNameFormState = GlobalKey();
  GlobalKey<FormState> nickNameFormState = GlobalKey();

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

/* 
1- get user name 
2- get user nickname 
*/
  Future getUserInfo() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('user_id', isEqualTo: userId)
        .get();

    if (querySnapshot.size == 1) {
      final docRef = querySnapshot.docs.first.reference;
      await docRef.set({
        'user_name': firstNameController.text,
        'user_nickName': nickNameController.text
      }, SetOptions(merge: true));
    } else {
      print(
          'Error User document not found++++++++++++++++++++++++++++++++++++++++++++++');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10.h,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: EdgeInsets.only(left: 5.h),
          child: Text(
            'Fill Your Profile',
            style: GoogleFonts.rubik(
                color: Colors.white,
                fontSize: 2.h,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      backgroundColor: Color(0xff16161c),
      body: Padding(
        padding: EdgeInsets.only(left: 4.h, right: 4.h, top: 3.h),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              // add profile Photo
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
                          : Container(
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
                              ))),

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
              SizedBox(
                height: 4.5.h,
              ),
              // first name form
              TextForm(
                formState: firstNameFormState,
                obscureText: false,
                controller: firstNameController,
                textInputType: TextInputType.text,
                hintText: 'Full Name',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'not valid.';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 2.h,
              ),
              // Nick Name
              TextForm(
                formState: nickNameFormState,
                obscureText: false,
                controller: nickNameController,
                textInputType: TextInputType.text,
                hintText: 'Nick Name',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'not valid.';
                  }
                  return null;
                },
              ),

              SizedBox(
                height: 2.h,
              ),
              //phone number
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.2.h),
                child: PhoneTextField(
                  textStyle: GoogleFonts.rubik(color: Colors.white),
                  locale: const Locale('en'),
                  decoration: InputDecoration(
                    fillColor: Color(0xff272828),
                    filled: true,
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      child: Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                    ),
                    hintText: "Phone number",
                    hintStyle: TextStyle(
                        color: Color(0xff797979),
                        fontWeight: FontWeight.w400,
                        fontSize: 1.5.h),
                  ),
                  searchFieldInputDecoration: const InputDecoration(
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(),
                    ),
                    suffixIcon: Icon(Icons.search),
                    hintText: "Search country",
                  ),
                  initialCountryCode: "AE",
                  onChanged: (phone) {
                    debugPrint(phone.completeNumber);
                  },
                ),
              ),

              SizedBox(
                height: 2.h,
              ),
              // gender select

              GenderSelect(),
              SizedBox(
                height: 20.h,
              ),
              //validate button

              Button(
                  width: double.infinity,
                  onTap: () {
                    if (firstNameFormState.currentState!.validate() &&
                        nickNameFormState.currentState!.validate()) {
                      getUserInfo();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChooseYourInterest()));
                      print('done');
                    } else {
                      print('valid');
                    }
                  },
                  title: 'CONTINUE')
            ],
          ),
        ),
      ),
    );
  }
}
