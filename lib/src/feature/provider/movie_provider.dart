// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:movie_app/src/feature/model/movies/top_movie_model.dart';
// import 'package:http/http.dart' as http;

// class MovieProvider extends ChangeNotifier {
//   List<TopMovieModel>? _topMovies;

//   bool _isLoading = false;

//   List<TopMovieModel>? get topMovies => _topMovies;
//   bool get isLoading => _isLoading;

//   static String topMovieUrl = 'https://imdb-top-100-movies.p.rapidapi.com/';

//   static Map<String, String> headers = {
//     'X-Rapidapi-Key': '8fc5722c13msh58c9b09cdb75d6cp1983d9jsnf52ec7682fb4',
//     'X-Rapidapi-Host': 'imdb-top-100-movies.p.rapidapi.com'
//   };

//   Future<void> fetchTopMovies() async {
//     _isLoading = true;
//     notifyListeners();

//     if (_topMovies != null) {
//       _isLoading = false;
//       notifyListeners();
//       return;
//     }
//     try {
//       final response = await http.get(Uri.parse(topMovieUrl), headers: headers);
//       if (response.statusCode == 200) {
//         final jsonData = jsonDecode(response.body) as List;
//         _topMovies =
//             jsonData.map((data) => TopMovieModel.fromJson(data)).toList();
//         notifyListeners();
//       } else {
//         throw Exception(
//             'Failed to load top movies (Status Code: ${response.statusCode})');
//       }
//     } catch (e) {
//       rethrow;
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }
