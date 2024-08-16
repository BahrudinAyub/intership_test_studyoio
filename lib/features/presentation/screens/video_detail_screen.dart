import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoDetailScreen extends StatefulWidget {
  final String documentId;

  const VideoDetailScreen({Key? key, required this.documentId})
      : super(key: key);

  @override
  _VideoDetailScreenState createState() => _VideoDetailScreenState();
}

class _VideoDetailScreenState extends State<VideoDetailScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  int _currentIndex = 0;
  List<String> _documentIds = [];
  DocumentSnapshot? _currentDocument;

  @override
  void initState() {
    super.initState();
    _loadDocumentIds();
  }

  Future<void> _loadDocumentIds() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('video-apps').get();
    setState(() {
      _documentIds = snapshot.docs.map((doc) => doc.id).toList();
      _currentIndex = _documentIds.indexOf(widget.documentId);
      _loadCurrentDocument();
    });
  }

  void _loadCurrentDocument() {
    FirebaseFirestore.instance
        .collection('video-apps')
        .doc(_documentIds[_currentIndex])
        .get()
        .then((docSnapshot) {
      setState(() {
        _currentDocument = docSnapshot;
      });

      final data = docSnapshot.data() as Map<String, dynamic>;
      final videoUrl = data['url video'];

      if (videoUrl != null && videoUrl.isNotEmpty) {
        _initializeVideoPlayer(videoUrl);
      }
    }).catchError((error) {
      print('Error fetching document: $error');
    });
  }

  void _initializeVideoPlayer(String videoUrl) {
    _videoPlayerController = VideoPlayerController.network(videoUrl);
    _videoPlayerController.initialize().then((_) {
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        looping: false,
      );

      setState(() {});
    }).catchError((error) {
      print('Error initializing video player: $error');
    });
  }

  void _changeVideo(bool next) {
    setState(() {
      if (next) {
        if (_currentIndex < _documentIds.length - 1) {
          _currentIndex++;
        }
      } else {
        if (_currentIndex > 0) {
          _currentIndex--;
        }
      }
      _loadCurrentDocument();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentDocument == null
          ? const Center(child: CircularProgressIndicator())
          : GestureDetector(
              onVerticalDragEnd: (details) {
                if (details.primaryVelocity! > 0) {
                  // Swipe down
                  _changeVideo(false);
                } else if (details.primaryVelocity! < 0) {
                  // Swipe up
                  _changeVideo(true);
                }
              },
              child: Stack(
                children: [
                  if (_chewieController != null &&
                      _chewieController!.videoPlayerController.value.isInitialized)
                    Chewie(
                      controller: _chewieController!,
                    )
                  else
                    const Center(child: CircularProgressIndicator()),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.black.withOpacity(0.6),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Position: $_currentIndex',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _currentDocument!['judul'] ?? 'No Title',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _currentDocument!['deskripsi'] ?? 'No Description',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
}
