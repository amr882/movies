// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MovieCard extends StatefulWidget {
  final String big_image;
  final String title;
  final double height;
  final Function() onTap;
  const MovieCard(
      {super.key,
      required this.big_image,
      required this.title,
      required this.height,
      required this.onTap});

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
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
              child: Image.network(
                widget.big_image,
                height: widget.height,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return SizedBox(
                        height: widget.height,
                        child: Center(child: CircularProgressIndicator(color: Colors.orange,)));
                  }
                },
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
