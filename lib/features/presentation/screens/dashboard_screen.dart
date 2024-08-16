import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intership_test_studyoio/features/presentation/styles/color_style.dart';
import 'package:intership_test_studyoio/features/presentation/widgets/button_search_dashboard.dart';
import 'package:intership_test_studyoio/features/presentation/widgets/card_view_trending.dart';
import 'package:video_player/video_player.dart';
import 'video_detail_screen.dart'; // Import halaman detail video

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle.backgroundApp,
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
              color: ColorStyle.backgroundDahsboard,
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 3.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5.w),
                    child: CardViewTrending(
                      text: 'Trending',
                      icon: Icons.trending_up,
                    ),
                  ),
                  Container(
                    height: 200.h,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('video-apps').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        }

                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Center(child: Text('No Videos Found'));
                        }

                        List<DocumentSnapshot> docs = snapshot.data!.docs;

                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: docs.length,
                          itemBuilder: (context, index) {
                            var data = docs[index].data() as Map<String, dynamic>;
                            var videoUrl = data['url video'];
                            var documentId = (index + 1).toString();

                            // Apply left padding only to the first item
                            EdgeInsetsGeometry padding = index == 0
                                ? EdgeInsets.only(left: 16.w, right: 10.w)
                                : EdgeInsets.only(right: 10.w);

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VideoDetailScreen(documentId: documentId),
                                  ),
                                );
                              },
                              child: Container(
                                width: 150.w,
                                color: Colors.black,
                                margin: padding,
                                child: AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: videoUrl != null
                                      ? VideoPlayerWidget(videoUrl: videoUrl)
                                      : Center(child: Text('No Video', style: TextStyle(color: Colors.white))),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
             Container(
              color: ColorStyle.backgroundDahsboard,
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 3.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5.w),
                    child: CardViewTrending(
                      text: 'New Video',
                      icon: Icons.fireplace_rounded,
                    ),
                  ),
                  Container(
                    height: 200.h,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('video-apps').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        }

                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Center(child: Text('No Videos Found'));
                        }

                        List<DocumentSnapshot> docs = snapshot.data!.docs;

                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: docs.length,
                          itemBuilder: (context, index) {
                            var data = docs[index].data() as Map<String, dynamic>;
                            var videoUrl = data['url video'];
                            var documentId = (index + 1).toString();

                            // Apply left padding only to the first item
                            EdgeInsetsGeometry padding = index == 0
                                ? EdgeInsets.only(left: 16.w, right: 10.w)
                                : EdgeInsets.only(right: 10.w);

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VideoDetailScreen(documentId: documentId),
                                  ),
                                );
                              },
                              child: Container(
                                width: 150.w,
                                color: Colors.black,
                                margin: padding,
                                child: AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: videoUrl != null
                                      ? VideoPlayerWidget(videoUrl: videoUrl)
                                      : Center(child: Text('No Video', style: TextStyle(color: Colors.white))),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.setVolume(0.0); // Memainkan video tanpa suara
        _controller.play(); // Memulai video
        _controller.setLooping(true); // Mengulangi video terus menerus
      });
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? VideoPlayer(_controller)
        : const Center(child: CircularProgressIndicator());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
