
import 'package:flutter/material.dart';
import 'package:intership_test_studyoio/features/data/list_video_trending.dart';

class VideoListView extends StatelessWidget {
  final List<Video> videos;

  VideoListView({required this.videos});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: videos.length,
      itemBuilder: (context, index) {
        final video = videos[index];
        return ListTile(
          title: Text(video.title),
          subtitle: Text(video.description),
          onTap: () {
            // Aksi ketika video dipilih
          },
        );
      },
    );
  }
}
