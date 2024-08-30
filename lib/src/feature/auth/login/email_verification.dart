import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/src/widgets/button.dart';
import 'package:sizer/sizer.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  Future sendEmailVerification() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? currentUser = auth.currentUser;
    try {
      await currentUser!.sendEmailVerification();
      print('Verification email sent');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found. Please create an account.');
      } else if (e.code == 'invalid-email') {
        print('Invalid email address.');
      } else {
        print(e.message);
      }
    }
  }

  @override
  void initState() {
    sendEmailVerification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff16161c),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 35.h,
              child: Text(
                "We have sent you email verification",
                textAlign: TextAlign.center,
                maxLines: 3,
                style: GoogleFonts.rubik(
                    color: Colors.white,
                    fontSize: 4.h,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Button(
              width: double.infinity,
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  'SignIn',
                  (route) => false,
                );
              },
              title: 'Go LogIn',
            )
          ],
        ),
      ),
    );
  }
}
