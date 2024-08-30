// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/src/feature/auth/login/email_verification.dart';
import 'package:movie_app/src/feature/auth/login/sign_in.dart';
import 'package:movie_app/src/widgets/back_button.dart';
import 'package:movie_app/src/widgets/button.dart';
import 'package:movie_app/src/widgets/text_form.dart';
import 'package:sizer/sizer.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  //keys
  GlobalKey<FormState> emailFormState = GlobalKey();
  GlobalKey<FormState> passwordFormState = GlobalKey();
  GlobalKey<FormState> confirmPasswordFormState = GlobalKey();

  //bool
  bool showPassword = true;
  bool showConfirmPassword = true;
  bool rememberMe = false;
  showHidePassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  showHideConfirmPassword() {
    setState(() {
      showConfirmPassword = !showConfirmPassword;
    });
  }

  // create User With Email andPassword

  Future createUserWithEmailAndPassword() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .add({
            'user_id': credential.user!.uid,
            'first_login': true,
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => EmailVerification()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
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
                left: -5.h,
                child: Image.asset(
                  'assets/Image (2).png',
                  height: 120.h,
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
                          'Create your account',
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

                      SizedBox(
                        height: 2.h,
                      ),
                      // confirm password
                      TextForm(
                        formState: confirmPasswordFormState,
                        obscureText: showConfirmPassword,
                        controller: confirmPasswordController,
                        textInputType: TextInputType.name,
                        hintText: 'Confirm Password',
                        prefixIcon: SvgPicture.asset(
                          'assets/lock.svg',
                          height: 2.h,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: showHideConfirmPassword,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            height: 2.h,
                            width: 2.h,
                            child: SvgPicture.asset(
                              showConfirmPassword
                                  ? 'assets/eyeHidePassword.svg'
                                  : 'assets/EyeShowPassword.svg',
                              height: 2.h,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Confirm password cannot be empty.';
                          } else if (value != passwordController.text) {
                            return 'Passwords do not match.';
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
                      Button(
                        width: double.infinity,
                        onTap: () {
                          if (emailFormState.currentState!.validate() &&
                              passwordFormState.currentState!.validate() &&
                              confirmPasswordFormState.currentState!
                                  .validate()) {
                            print('done');
                            createUserWithEmailAndPassword();
                          } else {
                            print('valid');
                          }
                        },
                        title: 'Create Account',
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Have an account?",
                            style: GoogleFonts.rubik(color: Colors.white),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => const SignIn()));
                            },
                            child: Text(
                              'Sign In',
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
