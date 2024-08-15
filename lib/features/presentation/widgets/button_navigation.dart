import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intership_test_studyoio/features/presentation/screens/dashboard_screen.dart';
import 'package:intership_test_studyoio/features/presentation/screens/game_screen.dart';
import 'package:intership_test_studyoio/features/presentation/screens/profile_screen.dart';
import 'package:intership_test_studyoio/features/presentation/screens/quick_help_screen.dart';
import 'package:intership_test_studyoio/features/presentation/screens/tutoring_screen.dart';
import 'package:intership_test_studyoio/features/presentation/styles/color_style.dart';
import 'package:intership_test_studyoio/features/presentation/styles/text_style.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 2; // Set default to DashboardScreen

  final List<Widget> _children = [
    TutoringScreen(),
    QuickHelpScreen(),
    const DashboardScreen(),
    GameScreen(),
    ProfileScreen()
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil
    ScreenUtil.init(context, designSize: Size(375, 812), minTextAdapt: true);

    return Scaffold(
      body: _children[_currentIndex],
      // Set the background color outside of the BottomNavigationBar to blue
      backgroundColor: ColorStyle.backgroundApp,
      bottomNavigationBar: Padding(
        padding:
            EdgeInsets.only(bottom: 5.0.h), // Reduce padding to make it smaller
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
              10.0.r), // Adjusted to make the border smaller
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0.w), // Reduced margin
            decoration: BoxDecoration(
              color: Colors
                  .transparent, // Maintain transparent background inside the BottomNavigationBar
              borderRadius:
                  BorderRadius.circular(23.r), // Reduced border radius
              border: Border.all(
                color: Colors.black, // Border color
                width: 3.w, // Border width
              ),
            ),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(20.0.r), // Adjusted inner border radius
              child: BottomNavigationBar(
                backgroundColor:
                    Colors.transparent, // Maintain transparent background
                onTap: onTabTapped,
                currentIndex: _currentIndex,
                type: BottomNavigationBarType.fixed,
                selectedItemColor:
                    Colors.white, // Ensures the selected icon is white
                unselectedItemColor:
                    Colors.white, // Ensures the unselected icons are white
                items: [
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/icons/book.svg',
                      color: Colors.white,
                      width: 25.0.sp,
                      height: 25.0.sp,
                    ),
                    label: 'TUTORING',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/icons/thunder.svg',
                        color: Colors.white,
                        width: 25.0.sp,
                        height: 25.0.sp), // Smaller icon
                    label: 'QUICK HELP',
                  ),
                  BottomNavigationBarItem(
                    icon: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 75.0.w, // Smaller width
                          height: 50.0.h, // Smaller height
                          padding: EdgeInsets.all(2.0.w), // Adjusted padding
                          decoration: BoxDecoration(
                            color: _currentIndex == 2
                                ? ColorStyle.bottomNavigationVideo
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(
                                15.0.r), // Smaller border radius
                            border: Border.all(
                              color: Colors
                                  .black, // Border color for the video icon
                              width: 2.0.w, // Border width
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/triangle.svg',
                                color: Colors.white,
                                width: 15.0.sp,
                                height: 15.0.sp,
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(
                                'VIDEO',
                                style: SatoshiStyle.SatoshiStyleBold.copyWith(
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.025, // Smaller font size
                                  color: Colors.white, // Custom color if needed
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    label: '', // Label is empty because we use custom widget
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/icons/game.svg',
                      color: Colors.white,
                      width: 25.0.sp,
                      height: 25.0.sp,
                    ), // Smaller icon
                    label: 'GAME',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/icons/user.svg',
                      color: Colors.white,
                      width: 25.0.sp,
                      height: 25.0.sp,
                    ), // Smaller icon
                    label: 'PROFILE',
                  ),
                ],
                selectedLabelStyle: SatoshiStyle.SatoshiStyleBold.copyWith(
                    fontSize: 8.0.sp,
                    color: Colors.white // Smaller size for selected label
                    ),
                unselectedLabelStyle: SatoshiStyle.SatoshiStyleBold.copyWith(
                    fontSize: 8.0.sp,
                    color: Colors.white // Smaller size for unselected label
                    ),
                showSelectedLabels: true,
                showUnselectedLabels: true,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
