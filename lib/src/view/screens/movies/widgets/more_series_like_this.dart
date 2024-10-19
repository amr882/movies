import 'package:flutter/material.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/src/feature/model/series/top_series_model.dart';
import 'package:movie_app/src/feature/service/api/series_api.dart';
import 'package:movie_app/src/view/screens/movies/screens/series_details.dart';
import 'package:movie_app/src/view/screens/movies/widgets/series_card.dart';
import 'package:sizer/sizer.dart';

class MoreSeriesLikeThis extends StatefulWidget {
  const MoreSeriesLikeThis({super.key});

  @override
  State<MoreSeriesLikeThis> createState() => _MoreSeriesLikeThisState();
}

class _MoreSeriesLikeThisState extends State<MoreSeriesLikeThis> {
  Future<void> fetchTopSeries() async {
    final List<TopSeriesModel> topSeriesList = await SeriesApi.fetchTopSeries();
    setState(() {
      topSeries = topSeriesList;
    });
  }

  Future<void> fetchSeriesDetails(BuildContext context, String serieId) async {
    final seriesDetails = await SeriesApi.fetchSeriesDetails(serieId);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            SeriesDetails(seriesDetailsModel: seriesDetails)));
  }

  @override
  void initState() {
    topSeries.isEmpty ? fetchTopSeries() : print(topSeries);

    print('done');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return topSeries.isEmpty
        ? Center(
            child: Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              CircularProgressIndicator(
                color: Colors.orange,
              ),
            ],
          ))
        : SizedBox(
            child: GridView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.6),
                children: List.generate(
                  10,
                  (i) => SeriesCard(
                      onTap: () {
                        fetchSeriesDetails(context, topSeries[i].id);
                      },
                      height: 31.h,
                      big_image: topSeries[i].big_image,
                      title: topSeries[i].title),
                )),
          );
  }
}
