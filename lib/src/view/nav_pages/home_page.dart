// ignore_for_file: non_constant_identifier_name

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/src/feature/model/movies/top_movie_model.dart';
import 'package:movie_app/src/feature/service/api/movie_api.dart';
import 'package:movie_app/src/view/screens/movies/screens/movie_details.dart';
import 'package:movie_app/src/view/screens/movies/widgets/show_all_movies.dart';
import 'package:movie_app/src/view/screens/movies/widgets/movie_card.dart';
import 'package:movie_app/src/view/screens/movies/widgets/poster_card.dart';
import 'package:sizer/sizer.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoding = true;

  List<TopMovieModel> topMovies = [];
  Future<void> fetchTopMovies() async {
    final List<TopMovieModel> topMoviesList = await MovieApi.fetchTopMovies();
    setState(() {
      topMovies = topMoviesList;
      isLoding = false;
    });
  }

  @override
  void initState() {
    fetchTopMovies();
    print(100.h);
    super.initState();
  }

  // get movie details
  Future<void> fetchMovieDetails(BuildContext context, String movieId) async {
    final movieDetails = await MovieApi.fetchMovieDetails(movieId);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MovieDetails(movieDetailsModel: movieDetails)));
  }

  @override
  Widget build(BuildContext context) {
    List<TopMovieModel> shuffledMovies = List.from(topMovies)..shuffle();
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
        backgroundColor: Color(0xff16161c),
        body: isLoding
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              )
            : RefreshIndicator(
                onRefresh: () async {
                  setState(() {});
                },
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 4.h,
                      ),

                      // posters
                      isPortrait
                          ? CarouselSlider.builder(
                              itemCount: 10,
                              options: CarouselOptions(
                                  scrollPhysics: BouncingScrollPhysics(),
                                  height: 40.h,
                                  viewportFraction: 0.55,
                                  enlargeCenterPage: true,
                                  autoPlayInterval: Duration(seconds: 3),
                                  autoPlayAnimationDuration:
                                      Duration(seconds: 1),
                                  autoPlay: true),
                              itemBuilder: (context, i, realIndex) {
                                final movie = topMovies[i];
                                return Poster(
                                  title: movie.title,
                                  big_image: movie.big_image,
                                  rating: movie.rating,
                                  year: movie.year,
                                  onTap: () {
                                    fetchMovieDetails(context, movie.id);
                                  },
                                );
                              })
                          : Container(
                              width: 100,
                              height: 100,
                              color: Colors.white,
                            ),
                      SizedBox(
                        height: 2.h,
                      ),

                      // show all movies
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Latest Shows',
                              style: GoogleFonts.rubik(
                                  color: Color(0xffff2f2f),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 1.5.h),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ShowAllMovies()));
                              },
                              child: Text(
                                'Show all',
                                style: GoogleFonts.rubik(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 1.5.h),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),

                      // movies

                      SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children:
                                List.generate(shuffledMovies.length, (index) {
                          final movie = shuffledMovies[index];

                          return MovieCard(
                            big_image: movie.big_image,
                            title: movie.title,
                            height: 25.h,
                            onTap: () {
                              fetchMovieDetails(context, movie.id);
                            },
                          );
                        })),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                    ],
                  ),
                ),
              ));
  }
}

// GridView.builder(
//   physics: BouncingScrollPhysics(),
//   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//       crossAxisCount: 3, childAspectRatio: 0.6),
//   itemBuilder: (context, i) => MovieCard(
//       big_image: topMovies[i].big_image,
//       title: topMovies[i].title)),
