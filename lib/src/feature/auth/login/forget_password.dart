import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/src/widgets/text_form.dart';
import 'package:sizer/sizer.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> emailFormState = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff16161c),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              height: 20,
            ),
            MaterialButton(
              textColor: Colors.white,
              onPressed: () async {
                try {
                  if (emailFormState.currentState!.validate()) {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: emailController.text);
                    //TO:DO
                    Navigator.of(context).pop();
                  }
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    print('No user found. Please create an account.');
                  } else if (e.code == 'invalid-email') {
                    print('Invalid email address.');
                  } else {
                    print(e.message);
                  }
                }
              },
              child: Text('reset password'),
            )
          ],
        ),
      ),
    );
  }
}
