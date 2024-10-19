import 'package:flutter/material.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/src/feature/model/movies/top_movie_model.dart';
import 'package:movie_app/src/feature/service/api/movie_api.dart';
import 'package:movie_app/src/view/screens/movies/screens/movie_details.dart';
import 'package:movie_app/src/view/screens/movies/widgets/movie_card.dart';
import 'package:sizer/sizer.dart';

class MoreMoviesLikeThis extends StatefulWidget {
  const MoreMoviesLikeThis({super.key});

  @override
  State<MoreMoviesLikeThis> createState() => _MoreMoviesLikeThisState();
}

class _MoreMoviesLikeThisState extends State<MoreMoviesLikeThis> {
  Future<void> fetchTopMovies() async {
    final List<TopMovieModel> topMoviesList = await MovieApi.fetchTopMovies();
    setState(() {
      topMovies = topMoviesList;
    });
  }

  Future<void> fetchMovieDetails(BuildContext context, String movieId) async {
    final movieDetails = await MovieApi.fetchMovieDetails(movieId);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MovieDetails(movieDetailsModel: movieDetails)));
  }

  @override
  void initState() {
    topMovies.isEmpty ? fetchTopMovies : print(topMovies);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return topMovies.isEmpty
        ? Center(
            child: Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              CircularProgressIndicator(
                color: Colors.orange,
              ),
            ],
          ))
        : SizedBox(
            child: GridView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.6),
                children: List.generate(
                  10,
                  (i) => MovieCard(
                      onTap: () {
                        fetchMovieDetails(context, topMovies[i].id);
                      },
                      height: 31.h,
                      big_image: topMovies[i].big_image,
                      title: topMovies[i].title),
                )),
          );
  }
}
