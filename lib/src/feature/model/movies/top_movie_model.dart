// ignore_for_file: non_constant_identifier_names

class TopMovieModel {
  String title;
  String id;
  int year;
  String big_image;
  String rating;

  TopMovieModel(
      {required this.title,
      required this.id,
      required this.big_image,
      required this.rating,
      required this.year});

  factory TopMovieModel.fromJson(Map<String, dynamic> json) {
    return TopMovieModel(
        title: json['title'],
        id: json['id'],
        big_image: json['big_image'],
        rating: json['rating'],
        year: json['year']);
  }
}
