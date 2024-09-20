// ignore_for_file: non_constant_identifier_name

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/src/feature/model/movies/top_movie_model.dart';
import 'package:movie_app/src/feature/model/series/top_series_model.dart';
import 'package:movie_app/src/feature/service/api/movie_api.dart';
import 'package:movie_app/src/feature/service/api/series_api.dart';
import 'package:movie_app/src/view/screens/movies/screens/movie_details.dart';
import 'package:movie_app/src/view/screens/movies/screens/series_details.dart';
import 'package:movie_app/src/view/screens/movies/screens/show_all_series.dart';
import 'package:movie_app/src/view/screens/movies/screens/show_all_movies.dart';
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
  bool isLoading = true;

  //fetchTopMovies
  Future<void> fetchTopMoviesSeries() async {
    final List<TopMovieModel> topMoviesList = await MovieApi.fetchTopMovies();
    final List<TopSeriesModel> topSeriesList = await SeriesApi.fetchTopSeries();

    setState(() {
      topMovies = topMoviesList;
    });
    print(topMovies);

    setState(() {
      topSeries = topSeriesList;
    });
    print(topSeries);
  }

  // get movie details
  Future<void> fetchMovieDetails(BuildContext context, String movieId) async {
    final movieDetails = await MovieApi.fetchMovieDetails(movieId);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MovieDetails(movieDetailsModel: movieDetails)));
  }

  // get movie details
  Future<void> fetchSeriesDetails(BuildContext context, String seriesId) async {
    final seriesDetails = await SeriesApi.fetchSeriesDetails(seriesId);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SeriesDetails(
              seriesDetailsModel: seriesDetails,
            )));
  }

  @override
  void initState() {
    topMovies.isEmpty || topSeries.isEmpty
        ? fetchTopMoviesSeries()
        : print('every thing is good here!');
    print(100.h);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<TopMovieModel> shuffledMovies = List.from(topMovies)..shuffle();
    List<TopSeriesModel> shuffledSeries = List.from(topSeries)..shuffle();
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
        backgroundColor: Color(0xff16161c),
        body: topMovies.isEmpty || topSeries.isEmpty
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
                              'Movies',
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
                            children: List.generate(10, (index) {
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

                      //series

                      // show all series
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Series',
                              style: GoogleFonts.rubik(
                                  color: Color(0xffff2f2f),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 1.5.h),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ShowAllSeries()));
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

                      // SingleChildScrollView(
                      //   physics: BouncingScrollPhysics(),
                      //   scrollDirection: Axis.horizontal,
                      //   child: Row(
                      //       children: List.generate(10, (index) {
                      //     final serie = shuffledSeries[index];

                      //     return SeriesCard(
                      //       big_image: serie.big_image,
                      //       title: serie.title,
                      //       height: 25.h,
                      //       onTap: () {
                      //         fetchSeriesDetails(context, serie.id);
                      //       },
                      //     );
                      //   })),
                      // ),
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












