// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class Poster extends StatelessWidget {
  final String big_image;
  final String title;
  final int year;
  final String rating;
  final Function() onTap;
  const Poster(
      {super.key,
      required this.big_image,
      required this.title,
      required this.year,
      required this.rating,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 80.w,
          height: 43.628.h,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              alignment: Alignment(0, 0),
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    fit: BoxFit.fill,
                    big_image,
                    width: 80.w,
                    height: 43.628.h,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Container(
                          color: Colors.white,
                          width: 80.w,
                          height: 43.628.h,
                        );
                      }
                    },
                  ),
                ),
                SvgPicture.asset(
                  fit: BoxFit.fill,
                  'assets/PosterOverlay.svg',
                  width: 80.w,
                  height: 46.628.h,
                ),
                Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      'assets/Vector.svg',
                      height: 5.h,
                    )),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.h, left: 2.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(
                            title.length <= 14
                                ? title
                                : "${title.substring(0, 14)}...",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 2.h),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.white,
                            size: 1.5.h,
                          ),
                          Text(
                            ' $rating | $year',
                            style:
                                TextStyle(color: Colors.white, fontSize: 1.5.h),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
