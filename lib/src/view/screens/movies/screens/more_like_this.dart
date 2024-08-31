import 'package:flutter/material.dart';
import 'package:movie_app/src/feature/model/movies/top_movie_model.dart';
import 'package:movie_app/src/feature/service/api/movie_api.dart';
import 'package:movie_app/src/view/screens/movies/widgets/movie_card.dart';
import 'package:sizer/sizer.dart';

class MoreLikeThis extends StatefulWidget {
  const MoreLikeThis({super.key});

  @override
  State<MoreLikeThis> createState() => _MoreLikeThisState();
}

class _MoreLikeThisState extends State<MoreLikeThis> {
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
    print('done');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoding
        ? Center(
            child: Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              CircularProgressIndicator(color: Colors.orange,),
            ],
          ))
        : SizedBox(
            child: GridView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.6),
                children: List.generate(
                  topMovies.length,
                  (i) => MovieCard(
                      onTap: () {
                        print(topMovies[i].id);
                      },
                      height: 31.h,
                      big_image: topMovies[i].big_image,
                      title: topMovies[i].title),
                )),
          );
  }
}
