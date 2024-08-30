// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/src/feature/auth/login/forget_password.dart';
import 'package:movie_app/src/feature/auth/register/sign_up.dart';
import 'package:movie_app/src/widgets/back_button.dart';
import 'package:movie_app/src/widgets/button.dart';
import 'package:movie_app/src/widgets/text_form.dart';

import 'package:sizer/sizer.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //keys
  GlobalKey<FormState> emailFormState = GlobalKey();
  GlobalKey<FormState> passwordFormState = GlobalKey();

  //bool
  bool showPassword = true;
  bool rememberMe = false;

  showHidePassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

//checkFirstLogIn
  List<QueryDocumentSnapshot> data = [];
  bool checkFirstLogIn = false;

  Future getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('user_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    data.addAll(querySnapshot.docs);

    int currentUserIndex = -1;
    for (int i = 0; i < data.length; i++) {
      if (data[i]['user_id'] == FirebaseAuth.instance.currentUser!.uid) {
        currentUserIndex = i;
        break;
      }
    }

    if (currentUserIndex != -1) {
      QueryDocumentSnapshot currentUserDoc = data[currentUserIndex];

      checkFirstLogIn = currentUserDoc['first_login'] as bool;
      print('+++++++++++++++++++++++++++++$checkFirstLogIn');
    } else {
      print('Current user document not found in the list');
    }
  }

// sign In With Email And Password
  Future signInWithEmailAndPassword() async {
    try {
      // User credentials
      final credentialSignIn =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      getData();
      setState(() {});
      // Navigate to homepage
      Navigator.of(context).pushNamedAndRemoveUntil(
        checkFirstLogIn ? 'FillYourProfile' : 'homepage',
        (route) => false,
      );
      print(
          '$checkFirstLogIn +++++++++++++++++++++++++++++++++++++++++++++----------++++++++++++++++');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          backgroundColor: const Color(0xff16161c),
          body: Stack(
            children: [
              Positioned(
                left: 0,
                child: Image.asset(
                  'assets/Sign Up.png',
                  height: 100.h,
                  fit: BoxFit.cover,
                ),
              ),
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: SizedBox(
                  height: 100.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 35.h,
                        child: Text(
                          'Login to your account',
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          style: GoogleFonts.rubik(
                              color: Colors.white,
                              fontSize: 4.h,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 2.4.h,
                      ),
                      //email
                      TextForm(
                        formState: emailFormState,
                        obscureText: false,
                        controller: emailController,
                        textInputType: TextInputType.emailAddress,
                        hintText: 'Enter your email here',
                        prefixIcon: SvgPicture.asset(
                          'assets/Subtract.svg',
                          height: 2.h,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'not valid.';
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return 'enter valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      //password
                      TextForm(
                        formState: passwordFormState,
                        obscureText: showPassword,
                        controller: passwordController,
                        textInputType: TextInputType.name,
                        hintText: 'Enter Password',
                        prefixIcon: SvgPicture.asset(
                          'assets/lock.svg',
                          height: 2.h,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: showHidePassword,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            height: 2.h,
                            width: 2.h,
                            child: SvgPicture.asset(
                              showPassword
                                  ? 'assets/eyeHidePassword.svg'
                                  : 'assets/EyeShowPassword.svg',
                              height: 2.h,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'not valid.';
                          }
                          return null;
                        },
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Row(
                          children: [
                            Checkbox(
                              side: BorderSide(color: Colors.white),
                              activeColor: const Color(0xffff2f2f),
                              value: rememberMe,
                              onChanged: (val) {
                                setState(() {
                                  rememberMe = val!;
                                });
                              },
                            ),
                            Text(
                              'Remember me',
                              style: GoogleFonts.rubik(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Button(
                        width: double.infinity,
                        onTap: () {
                          if (emailFormState.currentState!.validate() &&
                              passwordFormState.currentState!.validate()) {
                            print('done');

                            signInWithEmailAndPassword();
                          } else {
                            print('valid');
                          }
                        },
                        title: 'LOGIN',
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ForgetPassword()));
                        },
                        child: Text(
                          'Forget the password',
                          style: GoogleFonts.rubik(
                              color: const Color(0xffff2f2f),
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don’t have an account?",
                            style: GoogleFonts.rubik(color: Colors.white),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => const SignUp()));
                            },
                            child: Text(
                              'Sign Up',
                              style: GoogleFonts.rubik(
                                  color: const Color(0xffff2f2f),
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      )
                    ],
                  ),
                ),
              ),
              const BackIconButton(),
            ],
          )),
    );
  }
}
