// ignore_for_file: non_constant_identifier_names

class MovieDetailsModel {
  String title;
  String rating;
  String id;
  int year;
  String big_image;
  String description;
  String trailer;
  List<dynamic> genre;
  List<dynamic> director;
  List<dynamic> writers;
  String imdbid;
  String imdb_link;
  MovieDetailsModel(
      {required this.big_image,
      required this.id,
      required this.rating,
      required this.title,
      required this.year,
      required this.description,
      required this.director,
      required this.genre,
      required this.imdb_link,
      required this.imdbid,
      required this.trailer,
      required this.writers});

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
        big_image: json['big_image'],
        id: json['id'],
        rating: json['rating'],
        title: json['title'],
        year: json['year'],
        description: json['description'],
        director: json['director'],
        genre: json['genre'],
        imdb_link: json['imdb_link'],
        imdbid: json['imdbid'],
        trailer: json['trailer'],
        writers: json['writers']);
  }
}


// rank:32
// title:"Oppenheimer"
// thumbnail:"https://m.media-amazon.com/images/M/MV5BMDBmYTZjNjUtN2M1MS00MTQ2LTk2ODgtNzc2M2QyZGE5NTVjXkEyXkFqcGdeQXVyNzAwMjU2MTY@._V1_UY67_CR0,0,45,67_AL_.jpg"
// rating:"8.6"
// id:"top32"
// year:2023
// image:"https://m.media-amazon.com/images/M/MV5BMDBmYTZjNjUtN2M1MS00MTQ2LTk2ODgtNzc2M2QyZGE5NTVjXkEyXkFqcGdeQXVyNzAwMjU2MTY@._V1_QL75_UX380_CR0,0,380,562_.jpg"
// big_image:"https://m.media-amazon.com/images/M/MV5BMDBmYTZjNjUtN2M1MS00MTQ2LTk2ODgtNzc2M2QyZGE5NTVjXkEyXkFqcGdeQXVyNzAwMjU2MTY@._V1_QL75_UX380_CR0,0,380,562_.jpg"
// description:"The story of American scientist, J. Robert Oppenheimer, and his role in the development of the atomic bomb."
// trailer:"https://www.youtube.com/watch?v=uYPbbksJxIg"
// trailer_embed_link:"https://www.youtube.com/embed/uYPbbksJxIg"
// trailer_youtube_id:"uYPbbksJxIg"
// genre:
// 0:"Biography"
// 1:"Drama"
// 2:"History"
// director:
// 0:"Christopher Nolan"
// writers:
// 0:"Christopher Nolan"
// 1:"Kai Bird"
// 2:"Martin Sherwin"
// imdbid:"tt15398776"
// imdb_link:"https://www.imdb.com/title/tt15398776"