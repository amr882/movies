import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/src/feature/model/series/series_details_model.dart';
import 'package:movie_app/src/view/screens/movies/screens/comments.dart';
import 'package:movie_app/src/view/screens/movies/widgets/costume_sliver_app_bar.dart';
import 'package:movie_app/src/view/screens/movies/widgets/custom_tab_bar.dart';
import 'package:movie_app/src/view/screens/movies/widgets/download_button.dart';
import 'package:movie_app/src/view/screens/movies/widgets/play_button.dart';
import 'package:movie_app/src/view/screens/movies/widgets/rating.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SeriesDetails extends StatefulWidget {
  final SeriesDetailsModel seriesDetailsModel;
  const SeriesDetails({super.key, required this.seriesDetailsModel});

  @override
  State<SeriesDetails> createState() => _SeriesDetailsState();
}

class _SeriesDetailsState extends State<SeriesDetails> {
  late YoutubePlayerController _youtubePlayerController;
  String? seriesThumbnail;
  bool isLoading = true;

  bool isSeriesLoding = true;

  void getVideo() {
    final videoId =
        YoutubePlayer.convertUrlToId(widget.seriesDetailsModel.trailer);
    final videoThumbnail = YoutubePlayer.getThumbnail(videoId: videoId!);
    _youtubePlayerController = YoutubePlayerController(
        initialVideoId: videoId, flags: YoutubePlayerFlags(autoPlay: false));
    setState(() {
      seriesThumbnail = videoThumbnail;

      print(seriesThumbnail);
      isLoading = false;
      print(widget.seriesDetailsModel.trailer);
    });
  }

  Future shareMovieTrailer() async {
    Share.share(
        'check out this movie trailer ${widget.seriesDetailsModel.trailer}',
        subject: 'movie trailer');
    print('done');
  }

  @override
  void initState() {
    getVideo();
    print(widget.seriesDetailsModel.year);
    super.initState();
  }

  int currentIndex = 0;
  List<StatefulWidget> pages = [
    
    // MoreMoviesLikeThis(),
    Comments(), Comments()
    
    ];


  @override
  Widget build(BuildContext context) {
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
                    background: seriesThumbnail!,
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
                      widget.seriesDetailsModel.title.length <= 20
                          ? widget.seriesDetailsModel.title
                          : "${widget.seriesDetailsModel.title.substring(0, 20)}...",
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
              rating: widget.seriesDetailsModel.rating.toString(),
              year: widget.seriesDetailsModel.year.toString(),
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
                      onTap: () {},
                    )
                  ],
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
                  widget.seriesDetailsModel.description,
                  style: GoogleFonts.rubik(
                      color: Colors.white, fontWeight: FontWeight.w500),
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
            )
          ],
        ));
  }
}
