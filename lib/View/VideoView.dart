import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../ViewModel/VideoViewModel.dart';

class VideoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final videoViewModel = Provider.of<VideoViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('YouTube Videos')),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purpleAccent, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          itemCount: videoViewModel.videos.length,
          itemBuilder: (context, index) {
            final video = videoViewModel.videos[index];
            return Card(
              color: Colors.white.withOpacity(0.9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                title: Text(
                  video.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                trailing: const Icon(Icons.play_circle_fill, color: Colors.deepPurple, size: 30),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoPlayerScreen(videoId: video.videoId),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}


class VideoPlayerScreen extends StatefulWidget {
  final String videoId;

  VideoPlayerScreen({required this.videoId});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;
  List<Map<String, String>> suggestedVideos = []; // Suggestions list

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        controlsVisibleAtStart: true,
      ),
    );

    suggestedVideos = [
      {'title': 'Suggested Video 1', 'videoId': 'JZukfxvc7Mc'},
      {'title': 'Suggested Video 2', 'videoId': 'DfeyZBXuLxg'},
      {'title': 'Suggested Video 3', 'videoId': 'o_wbmiCux4M'},
    ];
  }

  void _showSuggestions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange, Colors.pinkAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          itemCount: suggestedVideos.length,
          itemBuilder: (context, index) {
            final video = suggestedVideos[index];
            return ListTile(
              title: Text(
                video['title']!,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
              ),
              leading: const Icon(Icons.video_library, color: Colors.white),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        VideoPlayerScreen(videoId: video['videoId']!),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Playing Video'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.red,
                onEnded: (metaData) {
                  _showSuggestions(context);
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              child: const Text(
                'Enjoy watching!',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
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
    _controller.dispose();
    super.dispose();
  }
}

