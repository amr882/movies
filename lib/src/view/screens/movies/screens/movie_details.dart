// ignore_for_file: unused_field
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/src/feature/model/movies/movie_details_model.dart';
import 'package:movie_app/src/feature/model/movies/top_movie_model.dart';
import 'package:movie_app/src/feature/service/api/movie_api.dart';
import 'package:movie_app/src/view/screens/movies/screens/comments.dart';
import 'package:movie_app/src/view/screens/movies/widgets/costume_sliver_app_bar.dart';
import 'package:movie_app/src/view/screens/movies/widgets/custom_tab_bar.dart';
import 'package:movie_app/src/view/screens/movies/widgets/download_button.dart';
import 'package:movie_app/src/view/screens/movies/widgets/play_button.dart';
import 'package:movie_app/src/view/screens/movies/widgets/rating.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetails extends StatefulWidget {
  final MovieDetailsModel movieDetailsModel;
  const MovieDetails({super.key, required this.movieDetailsModel});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  late YoutubePlayerController _youtubePlayerController;
  String? movieThumbnail;
  bool isLoading = true;

  bool isMoviesLoding = true;

  Future<void> getVideo() async {
    final videoId =
        YoutubePlayer.convertUrlToId(widget.movieDetailsModel.trailer);
    final videoThumbnail = YoutubePlayer.getThumbnail(videoId: videoId!);
    _youtubePlayerController = YoutubePlayerController(
        initialVideoId: videoId, flags: YoutubePlayerFlags(autoPlay: false));
    setState(() {
      movieThumbnail = videoThumbnail;

      print(movieThumbnail);
      isLoading = false;
    });
  }

  List<TopMovieModel> topMovies = [];
  Future<void> fetchTopMovies() async {
    final List<TopMovieModel> topMoviesList = await MovieApi.fetchTopMovies();
    setState(() {
      topMovies = topMoviesList;
      isMoviesLoding = false;
    });
  }

  Future shareMovieTrailer() async {
    Share.share(
        'check out this movie trailer ${widget.movieDetailsModel.trailer}',
        subject: 'movie trailer');
    print('done');
  }

  @override
  void initState() {
    getVideo();
    print(widget.movieDetailsModel.year);
    super.initState();
  }

  int currentIndex = 0;
  List<StatefulWidget> pages = [
    // MoreMoviesLikeThis(),
    Comments(), Comments()
  ];

  @override
  Widget build(BuildContext context) {
    String gener = widget.movieDetailsModel.genre
        .toString()
        .replaceAll(RegExp(r'\[|\]'), '');
    String director = widget.movieDetailsModel.director
        .toString()
        .replaceAll(RegExp(r'\[|\]'), '');

    String writers = widget.movieDetailsModel.writers
        .toString()
        .replaceAll(RegExp(r'\[|\]'), '');

    return Scaffold(
        backgroundColor: Color(0xff16161c),
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            isLoading
                ? SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : CostumeSliverAppBar(
                    background: movieThumbnail!,
                  ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.w,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.movieDetailsModel.title.length <= 20
                          ? widget.movieDetailsModel.title
                          : "${widget.movieDetailsModel.title.substring(0, 20)}...",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: GoogleFonts.rubik(
                          fontSize: 2.h,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        // add to draft
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.bookmark_add_sharp,
                              color: Colors.white,
                              size: 3.5.h,
                            )),
                        // share
                        IconButton(
                            onPressed: () {
                              shareMovieTrailer();
                            },
                            icon: Icon(
                              Icons.share,
                              color: Colors.white,
                              size: 3.5.h,
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
            Rating(
              rating: widget.movieDetailsModel.rating,
              year: widget.movieDetailsModel.year.toString(),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // play button
                    PlayButton(
                      youtubePlayer: YoutubePlayer(
                        controller: _youtubePlayerController,
                        showVideoProgressIndicator: true,
                        progressIndicatorColor: Colors.amber,
                        progressColors: const ProgressBarColors(
                          playedColor: Colors.amber,
                          handleColor: Colors.amberAccent,
                        ),
                        onReady: () {
                          _youtubePlayerController.play();
                        },
                        onEnded: (val) {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    // download button
                    DownloadButton(
                      url: widget.movieDetailsModel.trailer,
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.w,
                ),
                child: Text(
                  'Genre: $gener',
                  style: GoogleFonts.rubik(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 1.6.h),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 2.h,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.w,
                ),
                child: Text(
                  widget.movieDetailsModel.description,
                  style: GoogleFonts.rubik(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 2.h,
                  horizontal: 5.w,
                ),
                child: Text(
                  'director: $director',
                  style: GoogleFonts.rubik(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 1.6.h),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.w,
                ),
                child: Text(
                  'Writers: $writers',
                  style: GoogleFonts.rubik(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 1.6.h),
                ),
              ),
            ),
            SliverToBoxAdapter(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //more like this
                CustomTabBar(
                    onTap: () {
                      setState(() {
                        currentIndex = 0;
                        print(currentIndex);
                      });
                    },
                    text: 'More like This',
                    color: currentIndex == 0
                        ? Color(0xffff2f2f)
                        : Color(0xff797979)),
                // comments
                CustomTabBar(
                    onTap: () {
                      setState(() {
                        currentIndex = 1;
                        print(currentIndex);
                      });
                    },
                    text: 'Comments',
                    color: currentIndex == 1
                        ? Color(0xffff2f2f)
                        : Color(0xff797979)),
              ],
            )),
            SliverToBoxAdapter(
              child: pages[currentIndex],
            ),
          ],
        ));
  }
}
