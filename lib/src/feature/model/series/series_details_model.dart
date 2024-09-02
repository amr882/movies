// ignore_for_file: non_constant_identifier_names

class SeriesDetailsModel {
  String title;
  double rating;
  String id;
  String year;
  String big_image;
  String description;
  String trailer;
  String imdbid;
  String imdb_link;
  SeriesDetailsModel(
      {required this.big_image,
      required this.id,
      required this.rating,
      required this.title,
      required this.year,
      required this.description,


      required this.imdb_link,
      required this.imdbid,
      required this.trailer,
  });

  factory SeriesDetailsModel.fromJson(Map<String, dynamic> json) {
    return SeriesDetailsModel(
        big_image: json['big_image'],
        id: json['id'],
        rating: json['rating'].toDouble(),
        title: json['title'],
        year: json['year'],
        description: json['description'],
        imdb_link: json['imdb_link'],
        imdbid: json['imdbid'],
        trailer: json['trailer'],
);
  }
}
