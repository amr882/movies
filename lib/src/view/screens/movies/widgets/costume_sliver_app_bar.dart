import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class CostumeSliverAppBar extends StatelessWidget {
  final String? background;
  const CostumeSliverAppBar({super.key, required this.background});

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return SliverAppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          )),
      backgroundColor: Colors.transparent,
      expandedHeight: isPortrait ? 34.h : 40.h,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          alignment: Alignment(0, 0),
          children: [
            Image.network(
              errorBuilder: (BuildContext context, Object error,
                  StackTrace? stackTrace) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.error,
                        color: Colors.white,
                      ),
                      Text(
                        'error to get movie photo!',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                );
              },
              background!,
              fit: BoxFit.fill,
              height: 50.h,
            ),
            SvgPicture.asset(
              isPortrait ? 'assets/overlay (5).svg' : 'assets/Overlay (3).svg',
              fit: BoxFit.fill,
              height: 50.h,
            )
          ],
        ),
      ),
    );
  }
}