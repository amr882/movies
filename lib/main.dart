import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:movie_app/src/feature/auth/login/lets_you_in.dart';
import 'package:movie_app/src/feature/auth/login/sign_in.dart';
import 'package:movie_app/src/feature/model/movies/top_movie_model.dart';
import 'package:movie_app/src/feature/model/series/top_series_model.dart';
import 'package:movie_app/src/feature/service/api/movie_api.dart';
import 'package:movie_app/src/feature/service/api/series_api.dart';
import 'package:movie_app/src/view/screens/account%20setup/fill_your_profile.dart';
import 'package:movie_app/src/view/screens/intro_page.dart';
import 'package:movie_app/src/widgets/bottom_navigation_bar.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: "AIzaSyCVwqh6iT1w0IEkWKVWKQRyZbHfuZzDWNU",
            appId: "1:726701424849:android:69a358e34fe474501905f0",
            messagingSenderId: "726701424849",
            projectId: "movie-app-35f28",
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
  bool isLoading = true;
  Future<void> fetchTopMoviesSeries() async {
    final List<TopMovieModel> topMoviesList = await MovieApi.fetchTopMovies();
    final List<TopSeriesModel> topSeriesList = await SeriesApi.fetchTopSeries();

    setState(() {
      topMovies = topMoviesList;
      topSeries = topSeriesList;
      isLoading = false;
    });
    print(topMovies);
    print(topSeries);
  }

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
    fetchTopMoviesSeries();
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
          home: isLoading
              ? Scaffold(
                  backgroundColor: Color(0xff16161c),
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : FirebaseAuth.instance.currentUser == null
                  ? IntroPage()
                  : CustomBottomNavigationBar(),
          routes: {
            'letsYouIn': (context) => LetsYouIn(),
            'SignIn': (context) => SignIn(),
            'FillYourProfile': (context) => FillYourProfile(),
            'customBottomNavigationBar': (context) =>
                CustomBottomNavigationBar(),
          });
    });
  }
}

List<TopSeriesModel> topSeries = [];
List<TopMovieModel> topMovies = [];
  // cached_network_image: ^3.4.0