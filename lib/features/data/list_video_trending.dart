import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intership_test_studyoio/features/data/video_list_view.dart';

class Video {
  final String documentId;
  final String title;
  final String description;
  final String videoUrl;

  Video({
    required this.documentId,
    required this.title,
    required this.description,
    required this.videoUrl,
  });
}


class VideoListProvider extends StatelessWidget {
  final CollectionReference videosCollection = FirebaseFirestore.instance.collection('video-apps');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: videosCollection.snapshots(),
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

        List<Video> videos = snapshot.data!.docs.asMap().entries.map((entry) {
          int index = entry.key;
          DocumentSnapshot doc = entry.value;

          return Video(
            documentId: (index + 1).toString(), // Document ID mulai dari angka 1
            title: doc['judul'], // Pastikan field sesuai dengan yang di Firestore
            description: doc['deskripsi'],
            videoUrl: doc['url video'],
          );
        }).toList();

        return VideoListView(videos: videos);
      },
    );
  }
}
