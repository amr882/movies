import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_app/src/feature/auth/widgets/continue_with_button.dart';
import 'package:movie_app/src/feature/auth/login/sign_in.dart';
import 'package:movie_app/src/feature/auth/register/sign_up.dart';
import 'package:movie_app/src/widgets/back_button.dart';
import 'package:movie_app/src/widgets/button.dart';
import 'package:sizer/sizer.dart';
import 'package:twitter_login/twitter_login.dart';

class LetsYouIn extends StatefulWidget {
  const LetsYouIn({super.key});

  @override
  State<LetsYouIn> createState() => _LetsYouInState();
}

class _LetsYouInState extends State<LetsYouIn> {
  //Google Auth Fun

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.of(context).pushNamedAndRemoveUntil(
      'customBottomNavigationBar',
      (route) => false,
    );
  }

//twitter auth

  Future signInWithTwitter() async {
    final authResult = await TwitterLogin(
      apiKey: 'Ul9meURrWHd1OG11LWFNT2oxU286MTpjaQ',
      apiSecretKey: 'RaJR4_MAnI9mk4JhdrOZslp2cINK4nmzkRYTzoKkcoaNMFOL4U',
      redirectURI: 'https://movies-cb85d.firebaseapp.com/__/auth/handler',
    ).loginV2();
    switch (authResult.status) {
      case TwitterLoginStatus.loggedIn:
        // success
        print('====== Login success ======');
        Navigator.of(context).pushNamedAndRemoveUntil(
          'customBottomNavigationBar',
          (route) => false,
        );
        break;
      case TwitterLoginStatus.cancelledByUser:
        // cancel
        print('====== Login cancel ======');
        break;
      case TwitterLoginStatus.error:
      case null:
        // error
        print('====== Login error ======');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff16161c),
      body: Stack(
        children: [
          Positioned(
            top: -4.5.h,
            left: -8.2.h,
            child: Image.asset(
              'assets/Image (1).png',
              height: 100.h,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: -21.h,
            child: SvgPicture.asset(
              'assets/Overlay (1).svg',
              height: 120.h,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Let's you in",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.rubik(
                      color: Colors.white,
                      fontSize: 3.5.h,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 3.h,
                ),
                ContinueWith(
                  onTap: () {
                    signInWithTwitter();
                  },
                  continueWithImage: 'assets/twitter.svg',
                  methodName: 'Twitter',
                  imageHeight: 3.5,
                ),
                ContinueWith(
                  onTap: () {
                    signInWithGoogle();
                  },
                  continueWithImage: 'assets/google.svg',
                  methodName: 'Google',
                  imageHeight: 4,
                ),
                ContinueWith(
                  onTap: () {},
                  continueWithImage: 'assets/apple.svg',
                  methodName: 'Apple ID',
                  imageHeight: 3.9,
                ),

                // or create account

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          color: Color(0xff3f4040),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Text(
                          'or',
                          style: GoogleFonts.rubik(
                              color: Colors.white, fontSize: 2.h),
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          color: Color(0xff3f4040),
                        ),
                      ),
                    ],
                  ),
                ),
                Button(
                    width: double.infinity,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SignIn()));
                    },
                    title: 'SIGN IN WITH PASSWORD'),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don’t have an account?",
                      style: GoogleFonts.rubik(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
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
                  height: 2.h,
                ),
              ],
            ),
          ),
          const BackIconButton(),
        ],
      ),
    );
  }
}
