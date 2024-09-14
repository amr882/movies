import 'dart:convert';

import 'package:movie_app/src/feature/model/series/series_details_model.dart';
import 'package:movie_app/src/feature/model/series/top_series_model.dart';
import 'package:http/http.dart' as http;

class SeriesApi {
  static String topSeriesUrl =
      'https://imdb-top-100-movies.p.rapidapi.com/series/';
  static String seriesDetailsUrl =
      'https://imdb-top-100-movies.p.rapidapi.com/series/';
  static Map<String, String> headers = {
    'X-Rapidapi-Key': 'a590bed906mshb4311956e9cb01dp139b52jsnd3f3a28b1cd6',
    'X-Rapidapi-Host': 'imdb-top-100-movies.p.rapidapi.com'
  };

  static Future<List<TopSeriesModel>> fetchTopSeries() async {
    final response = await http.get(Uri.parse(topSeriesUrl), headers: headers);
    if (response.statusCode == 200) {
      try {
        final jsonData = jsonDecode(response.body) as List;
        final series =
            jsonData.map((data) => TopSeriesModel.fromJson(data)).toList();
        return series;
      } on FormatException catch (e) {
        throw Exception('Failed to parse JSON data: $e');
      }
    } else {
      throw Exception(
          'Failed to load series details (Status Code: ${response.statusCode})');
    }
  }

  static Future<SeriesDetailsModel> fetchSeriesDetails(String seriesId) async {
    final url = '$seriesDetailsUrl$seriesId';
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return SeriesDetailsModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load series details');
    }
  }
}
