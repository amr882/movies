import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayButton extends StatelessWidget {
  final YoutubePlayer youtubePlayer;
  const PlayButton({
    super.key,
    required this.youtubePlayer,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: (context),
            builder: (context) => Center(
                  child: Material(child: youtubePlayer),
                ));
      },
      child: Container(
        width: 40.w,
        height: 7.h,
        decoration: BoxDecoration(
            color: const Color(0xffff2f2f),
            borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.play_circle_fill_rounded,
                color: Colors.white,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'play',
                style: GoogleFonts.rubik(
                    color: Colors.white,
                    fontSize: 1.8.h,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
