import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intership_test_studyoio/features/data/list_video_trending.dart';
import 'package:intership_test_studyoio/features/presentation/styles/color_style.dart';
import 'package:intership_test_studyoio/features/presentation/widgets/button_search_dashboard.dart';
import 'package:intership_test_studyoio/features/presentation/widgets/card_view_trending.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: ColorStyle.appBarDasboard,
        leading: SizedBox.shrink(),
        title: SizedBox.shrink(),
        actions: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomSearchButton(
                onPressed: () {
                  print('Search button pressed');
                },
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 5.h),
            Container(
              color: Colors.red,
              alignment: Alignment.centerLeft,
              margin:
                  const EdgeInsets.symmetric(horizontal: 0.0, vertical: 3.0),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align items to the start (left)
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: 5.w), // Add padding to the left
                    child: CardViewTrending(
                      text: 'Trending',
                      icon: Icons.trending_up,
                    ),
                  ),
                  Container(
                    height: 200.h,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: videoList.map((video) {
                          return Container(
                            width: 150.w,
                            color: Colors.black,
                            margin: EdgeInsets.only(right: 10.w),
                            child: Center(
                              child: Text(
                                video,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              height: 200.h,
              color: Colors.green,
              child: Center(child: Text('Widget 2')),
            ),
          ],
        ),
      ),
    );
  }
}
