import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:movie_app/src/feature/auth/login/lets_you_in.dart';
import 'package:movie_app/src/feature/auth/login/sign_in.dart';
import 'package:movie_app/src/view/screens/account%20setup/fill_your_profile.dart';
import 'package:movie_app/src/view/nav_pages/home_page.dart';
import 'package:movie_app/src/view/screens/intro_page.dart';
import 'package:movie_app/src/widgets/bottom_navigation_bar.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: "AIzaSyDZ-gE-RogLxwBD4WySmM8J3RvAQsr8rWM",
            appId: "1:1060975072488:android:415511ab6820a98c0b255d",
            messagingSenderId: "1060975072488",
            projectId: "movies-cb85d",
          ),
        )
      : await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    initialization();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });

    super.initState();
  }

  void initialization() async {
    print('pauisng..');
    Future.delayed(Duration(seconds: 3));
    print('unpauisng..');
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: FirebaseAuth.instance.currentUser == null
              ? IntroPage()
              : CustomBottomNavigationBar(),
          routes: {
            'homepage': (context) => HomePage(),
            'letsYouIn': (context) => LetsYouIn(),
            'SignIn': (context) => SignIn(),
            'FillYourProfile': (context) => FillYourProfile()
          });
    });
  }
}
