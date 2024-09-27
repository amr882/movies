import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/src/feature/model/movies/top_movie_model.dart';
import 'package:sizer/sizer.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List filteredMovies = [];
  List<TopMovieModel> searchMovies= topMovies;
  void onSearch(String search) {
    setState(() {
      filteredMovies = searchMovies
          .where((element) => element.title.toLowerCase().contains(search))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff16161c),
      body: Column(
        children: [
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
              // onChanged: (value) => onSearch(value),
            ),
          ),
        ],
      ),
    );
  }
}
