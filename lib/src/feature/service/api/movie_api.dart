import 'dart:convert';

import 'package:movie_app/src/feature/model/movies/movie_details_model.dart';
import 'package:movie_app/src/feature/model/movies/top_movie_model.dart';
import 'package:http/http.dart' as http;

class MovieApi {
  static String topMovieUrl = 'https://imdb-top-100-movies.p.rapidapi.com/';
  static String movieDetailsUrl = 'https://imdb-top-100-movies.p.rapidapi.com/';
  static Map<String, String> headers = {
    'X-Rapidapi-Key': '8fc5722c13msh58c9b09cdb75d6cp1983d9jsnf52ec7682fb4',
    'X-Rapidapi-Host': 'imdb-top-100-movies.p.rapidapi.com'
  };

  static Future<List<TopMovieModel>> fetchTopMovies() async {
    final response = await http.get(Uri.parse(topMovieUrl), headers: headers);
    if (response.statusCode == 200) {
      try {
        final jsonData = jsonDecode(response.body) as List;
        final movies =
            jsonData.map((data) => TopMovieModel.fromJson(data)).toList();
        return movies;
      } on FormatException catch (e) {
        throw Exception('Failed to parse JSON data: $e');
      }
    } else {
      throw Exception(
          'Failed to load movie details (Status Code: ${response.statusCode})');
    }
  }

  static Future<MovieDetailsModel> fetchMovieDetails(String movieId) async {
    final url = '$movieDetailsUrl$movieId';
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return MovieDetailsModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load movie details');
    }
  }
}
