// ignore_for_file: non_constant_identifier_names

class TopSeriesModel {
  String title;
  String id;
  String year;
  String big_image;
  double rating;

  TopSeriesModel(
      {required this.title,
      required this.id,
      required this.big_image,
      required this.rating,
      required this.year});

  factory TopSeriesModel.fromJson(Map<String, dynamic> json) {
    return TopSeriesModel(
        title: json['title'],
        id: json['id'],
        big_image: json['big_image'],
        rating: json['rating'].toDouble(),
        year: json['year']);
  }
}

// rank:13
// title:"Game of Thrones"
// description:"Nine noble families fight for control over the lands of Westeros, while an ancient enemy returns after being dormant for a millennia."
// image:"https://m.media-amazon.com/images/M/MV5BN2IzYzBiOTQtNGZmMi00NDI5LTgxMzMtN2EzZjA1NjhlOGMxXkEyXkFqcGdeQXVyNjAwNDUxODI@._V1_QL75_UX380_CR0,1,380,562_.jpg"
// big_image:"https://m.media-amazon.com/images/M/MV5BN2IzYzBiOTQtNGZmMi00NDI5LTgxMzMtN2EzZjA1NjhlOGMxXkEyXkFqcGdeQXVyNjAwNDUxODI@"
// genre:
// thumbnail:"https://m.media-amazon.com/images/M/MV5BN2IzYzBiOTQtNGZmMi00NDI5LTgxMzMtN2EzZjA1NjhlOGMxXkEyXkFqcGdeQXVyNjAwNDUxODI@._V1_UY67_CR0,0,45,67_AL_.jpg"
// rating:9.2
// id:"top13"
// year:"2011-2019"
// imdbid:"tt0944947"
// imdb_link:"https://www.imdb.com/title/tt0944947"