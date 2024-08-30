import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/src/feature/model/movies/top_movie_model.dart';
import 'package:movie_app/src/feature/service/api/movie_api.dart';
import 'package:movie_app/src/view/screens/movies/screens/movie_details.dart';
import 'package:movie_app/src/view/screens/movies/widgets/movie_card.dart';
import 'package:sizer/sizer.dart';

class ShowAllMovies extends StatefulWidget {
  const ShowAllMovies({super.key});

  @override
  State<ShowAllMovies> createState() => _ShowAllMoviesState();
}

class _ShowAllMoviesState extends State<ShowAllMovies> {
  bool isLoding = true;
  List<TopMovieModel> topMovies = [];

  Future<void> fetchAllTopMovies() async {
    final List<TopMovieModel> topMoviesList =
        await MovieApi.fetchTopMovies();
    setState(() {
      topMovies = topMoviesList;
      isLoding = false;
    });
  }

  // get movie details
  Future<void> fetchMovieDetails(BuildContext context, String movieId) async {
    final movieDetails = await MovieApi.fetchMovieDetails(movieId);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MovieDetails(movieDetailsModel: movieDetails)));
  }

  @override
  void initState() {
    fetchAllTopMovies();
    print(100.h);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<TopMovieModel> shuffledMovies = List.from(topMovies)..shuffle();
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'All Movies',
          style: GoogleFonts.rubik(color: Colors.white, fontSize: 2.h),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Color(0xff16161c),
      body: isLoding
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            )
          : RefreshIndicator(
              color: Colors.orange,
              backgroundColor: Colors.transparent,
              onRefresh: () async {
                setState(() {});
              },
              child: AnimationLimiter(
                child: GridView.count(
                  crossAxisCount: isPortrait ? 2 : 4,
                  childAspectRatio: 0.66,
                  children: List.generate(
                    topMovies.length,
                    (int index) {
                      final movie = shuffledMovies[index];
                      return AnimationConfiguration.staggeredGrid(
                        position: index,
                        duration: Duration(milliseconds: 200),
                        columnCount: isPortrait ? 2 : 4,
                        child: ScaleAnimation(
                          child: FadeInAnimation(
                              child: MovieCard(
                                  onTap: () {
                                    fetchMovieDetails(context, movie.id);
                                  },
                                  height: 32.h,
                                  big_image: movie.big_image,
                                  title: movie.title)),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
    );
  }
}


// GridView.builder(
//                   itemCount: topMovies.length,
//                   physics: BouncingScrollPhysics(),
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: isPortrait ? 2 : 4,
//                       childAspectRatio: 0.66),
//                   itemBuilder: (context, i) {
//                     final movie = shuffledMovies[i];
//                     return MovieCard(
//                         onTap: () {
//                           fetchMovieDetails(context, movie.id);
//                         },
//                         height: 32.h,
//                         big_image: movie.big_image,
//                         title: movie.title);
//                   }),