import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/src/widgets/button.dart';
import 'package:sizer/sizer.dart';

class ChooseYourInterest extends StatefulWidget {
  const ChooseYourInterest({super.key});

  @override
  State<ChooseYourInterest> createState() => _ChooseYourInterestState();
}

class _ChooseYourInterestState extends State<ChooseYourInterest> {
  List<Map> interests = [
    {"name": "Action", "isSelected": false},
    {"name": "Horror", "isSelected": false},
    {"name": "Adventure", "isSelected": false},
    {"name": "Drama", "isSelected": false},
    {"name": "War", "isSelected": false},
    {"name": "Crime", "isSelected": false},
    {"name": "Romance", "isSelected": false},
    {"name": "History", "isSelected": false},
    {"name": "Music", "isSelected": false},
    {"name": "Comedy", "isSelected": false},
    {"name": "Television", "isSelected": false},
    {"name": "Thriller", "isSelected": false},
    {"name": "Animation", "isSelected": false},
    {"name": "Anime", "isSelected": false},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10.h,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_sharp,
          ),
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          'Choose Your Interest',
          style: GoogleFonts.rubik(
              color: Colors.white, fontSize: 2.h, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Color(0xff16161c),
      body: Padding(
          padding: EdgeInsets.only(left: 4.h, right: 4.h, top: 3.h),
          child: Column(
            children: [
              Text(
                "Choose your interests here and get the best movierecommendations. Don't worry you can always change it later.",
                style: GoogleFonts.rubik(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 4.h,
              ),
              SizedBox(
                height: 50.h,
                child: Wrap(
                    children: List.generate(interests.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        interests[index]['isSelected'] =
                            !interests[index]['isSelected'];
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 1.5, left: 5),
                      child: Chip(
                        shape: StadiumBorder(
                            side: BorderSide(color: Color(0xffff2f2f))),
                        color: WidgetStatePropertyAll(
                          interests[index]['isSelected']
                              ? Color(0xffff2f2f)
                              : Color(0xff16161c),
                        ),
                        padding: EdgeInsets.all(6),
                        label: Text(
                          interests[index]['name'],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                })),
              ),
              SizedBox(
                height: 8.h,
              ),
              Button(
                  width: double.infinity,
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      'homepage',
                      (route) => false,
                    );
                  },
                  title: 'Continue')
            ],
          )),
    );
  }
}
