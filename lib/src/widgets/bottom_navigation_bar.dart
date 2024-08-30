import 'package:flutter/material.dart';
import 'package:movie_app/src/feature/auth/widgets/handel_first_login.dart';
import 'package:movie_app/src/view/nav_pages/download_page.dart';
import 'package:movie_app/src/view/nav_pages/home_page.dart';
import 'package:movie_app/src/view/nav_pages/profile_page.dart';
import 'package:movie_app/src/view/nav_pages/search_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  var _currentIndex = 0;
  List<Widget> pages = [
    const HomePage(),
    const DownloadPage(),
    const SearchPage(),
    const ProfilePage()
  ];

  @override
  void initState() {
    handleFirstLogIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xff16161c),
          bottomNavigationBar: Container(
            color: Color(0xff272828),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: SalomonBottomBar(
                backgroundColor: Color(0xff272828),
                currentIndex: _currentIndex,
                onTap: (value) {
                  setState(() {
                    _currentIndex = value;
                  });
                },
                items: [
                  /// Home
                  SalomonBottomBarItem(
                    icon: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    title: Text("Home"),
                    selectedColor: Colors.red,
                  ),

                  /// Download
                  SalomonBottomBarItem(
                    icon: Icon(
                      Icons.file_download_outlined,
                      color: Colors.white,
                    ),
                    title: Text("Download"),
                    selectedColor: Colors.pink,
                  ),

                  /// Search
                  SalomonBottomBarItem(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    title: Text("Search"),
                    selectedColor: Colors.orange,
                  ),

                  /// Profile
                  SalomonBottomBarItem(
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    title: Text("Profile"),
                    selectedColor: Colors.teal,
                  ),
                ],
              ),
            ),
          ),
          body: pages[_currentIndex]),
    );
  }
}







//  GridView.builder(
//               physics: BouncingScrollPhysics(),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//                 childAspectRatio: 0.071.h,
//               ),
//               itemCount: topMovies.length,
//               itemBuilder: (context, snapshot) => Column(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(13),
                        
//                         child: Image.network(
//                           topMovies[snapshot].big_image,
//                           height: 22.5.h,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       Text(
//                         topMovies[snapshot].title.length <= 17
//                             ? topMovies[snapshot].title
//                             : "${topMovies[snapshot].title.substring(0, 17)}...",
//                         overflow: TextOverflow.ellipsis,
//                         maxLines: 1,
//                         style: TextStyle(color: Colors.white),
//                       )
//                     ],
//                   )),