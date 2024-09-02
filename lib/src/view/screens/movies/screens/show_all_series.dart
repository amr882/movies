import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/src/feature/model/series/top_series_model.dart';
import 'package:movie_app/src/feature/service/api/series_api.dart';
import 'package:movie_app/src/view/screens/movies/screens/series_details.dart';
import 'package:movie_app/src/view/screens/movies/widgets/series_card.dart';
import 'package:sizer/sizer.dart';

class ShowAllSeries extends StatefulWidget {
  const ShowAllSeries({super.key});

  @override
  State<ShowAllSeries> createState() => _ShowAllSeriesState();
}

class _ShowAllSeriesState extends State<ShowAllSeries> {
  Future<void> fetchAllTopSeries() async {
    final List<TopSeriesModel> topSeriesList = await SeriesApi.fetchTopSeries();
    setState(() {
      topSeries = topSeriesList;
    });
  }

  // get movie details
  Future<void> fetchSeriesDetails(BuildContext context, String serieId) async {
    final movieDetails = await SeriesApi.fetchSeriesDetails(serieId);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SeriesDetails(seriesDetailsModel: movieDetails)));
  }

  @override
  void initState() {
    topMovies.isEmpty ? fetchAllTopSeries() : print('every thing good');
    print(100.h);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<TopSeriesModel> shuffledMovies = List.from(topSeries)..shuffle();
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'All Movies',
          style: GoogleFonts.rubik(color: Colors.white, fontSize: 2.h),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Color(0xff16161c),
      body: topMovies.isEmpty
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            )
          : RefreshIndicator(
              color: Colors.orange,
              backgroundColor: Colors.transparent,
              onRefresh: () async {
                setState(() {});
              },
              child: AnimationLimiter(
                child: GridView.count(
                  crossAxisCount: isPortrait ? 2 : 4,
                  childAspectRatio: 0.66,
                  children: List.generate(
                    topMovies.length,
                    (int index) {
                      final serie = shuffledMovies[index];
                      return AnimationConfiguration.staggeredGrid(
                        position: index,
                        duration: Duration(milliseconds: 200),
                        columnCount: isPortrait ? 2 : 4,
                        child: ScaleAnimation(
                          child: FadeInAnimation(
                              child: SeriesCard(
                                  onTap: () {
                                    fetchSeriesDetails(context, serie.id);
                                  },
                                  height: 32.h,
                                  big_image: serie.big_image,
                                  title: serie.title)),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
    );
  }
}
