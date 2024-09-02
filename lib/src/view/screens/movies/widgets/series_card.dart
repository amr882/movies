// ignore_for_file: non_constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SeriesCard extends StatefulWidget {
  final String? big_image;
  final String title;
  final double height;
  final Function() onTap;
  const SeriesCard(
      {super.key,
      required this.big_image,
      required this.title,
      required this.height,
      required this.onTap});

  @override
  State<SeriesCard> createState() => _SeriesCardState();
}

class _SeriesCardState extends State<SeriesCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: SizedBox(
        width: 20.h,
        height: 33.h,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: CachedNetworkImage(
                imageUrl: widget.big_image!,
                height: widget.height,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    SizedBox(
                        height: widget.height,
                        child: Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress),
                        )),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.h),
                  child: Text(
                    widget.title.length <= 15
                        ? widget.title
                        : "${widget.title.substring(0, 15)}...",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 1.5.h),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


              // Image.network(
              //   errorBuilder: (BuildContext context, Object error,
              //       StackTrace? stackTrace) {
              //     return Center(
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: const [
              //           Icon(
              //             Icons.error,
              //             color: Colors.white,
              //           ),
              //           Text(
              //             'error to get movie photo!',
              //             style: TextStyle(color: Colors.white),
              //           )
              //         ],
              //       ),
              //     );
              //   },
              // widget.big_image!,
              // height: widget.height,
              // fit: BoxFit.cover,
              //   loadingBuilder: (context, child, loadingProgress) {
              //     if (loadingProgress == null) {
              //       return child;
              //     } else {
              //       return SizedBox(
              //           height: widget.height,
              //           child: Center(
              //               child: CircularProgressIndicator(
              //             color: Colors.orange,
              //           )));
              //     }
              //   },
              // ),