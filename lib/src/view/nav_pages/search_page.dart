import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/src/feature/model/movies/top_movie_model.dart';
import 'package:movie_app/src/feature/model/series/top_series_model.dart';
import 'package:movie_app/src/feature/service/api/movie_api.dart';
import 'package:movie_app/src/feature/service/api/series_api.dart';
import 'package:movie_app/src/view/screens/movies/screens/movie_details.dart';
import 'package:movie_app/src/view/screens/movies/screens/series_details.dart';
import 'package:movie_app/src/view/screens/movies/widgets/movie_card.dart';
import 'package:movie_app/src/view/screens/movies/widgets/series_card.dart';
import 'package:sizer/sizer.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

List<String> list = <String>['movies', 'series'];

class _SearchPageState extends State<SearchPage> {
  String dropdownValue = list.first;
  List<TopMovieModel> filteredMovies = [];
  List<TopSeriesModel> filteredSeries = [];
  List<TopMovieModel> searchMovies = topMovies;
  List<TopSeriesModel> searchSeries = topSeries;
  void onSearch(String search) {
    setState(() {
      dropdownValue == 'movies'
          ? filteredMovies = searchMovies
              .where((element) => element.title.toLowerCase().contains(search))
              .toList()
          : filteredSeries = searchSeries
              .where((element) => element.title.toLowerCase().contains(search))
              .toList();
    });
  }

  // get movie details
  Future<void> fetchSeriesDetails(BuildContext context, String serieId) async {
    final movieDetails = await SeriesApi.fetchSeriesDetails(serieId);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SeriesDetails(seriesDetailsModel: movieDetails)));
  }

  Future<void> fetchMovieDetails(BuildContext context, String movieId) async {
    final movieDetails = await MovieApi.fetchMovieDetails(movieId);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MovieDetails(movieDetailsModel: movieDetails)));
  }

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      backgroundColor: Color(0xff16161c),
      body: Column(
        children: [
          SizedBox(
            height: 2.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: TextField(
              style: GoogleFonts.rubik(color: Colors.white),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Search",
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
                filled: true,
                fillColor: Color(0xff272828),
                suffixIcon: Icon(
                  Icons.search_rounded,
                  color: Colors.white,
                ),
                enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.transparent)),
              ),
              onSubmitted: (val) => onSearch(val),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DropdownButton<String>(
                  underline: SizedBox(),
                  value: dropdownValue,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Color(0xffff2f2f),
                  ),
                  elevation: 16,
                  style: const TextStyle(color: Color(0xffff2f2f)),
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: isPortrait ? 2 : 4,
              childAspectRatio: 0.66,
              children: List.generate(
                dropdownValue == 'movies'
                    ? filteredMovies.length
                    : filteredSeries.length,
                (int index) {
                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: Duration(milliseconds: 200),
                    columnCount: isPortrait ? 2 : 4,
                    child: ScaleAnimation(
                      child: FadeInAnimation(
                          child: dropdownValue == 'movies'
                              ? MovieCard(
                                  onTap: () {
                                    fetchMovieDetails(
                                        context, filteredMovies[index].id);
                                  },
                                  height: 32.h,
                                  big_image: filteredMovies[index].big_image,
                                  title: filteredMovies[index].title)
                              : SeriesCard(
                                  onTap: () {
                                    fetchSeriesDetails(
                                        context, filteredSeries[index].id);
                                  },
                                  height: 32.h,
                                  big_image: filteredSeries[index].big_image,
                                  title: filteredSeries[index].title)),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
