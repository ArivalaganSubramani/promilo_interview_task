import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../Model/VideoModel.dart';


class VideoViewModel with ChangeNotifier {
  final List<VideoModel> _videos = [
    VideoModel(videoId: '3bEkaRUVOeU', title: 'Sample Video 1'), // Replace with actual video IDs
    VideoModel(videoId: 'HR0DQetcF9s', title: 'Sample Video 2'),
  ];

  List<VideoModel> get videos => _videos;

  void addVideo(VideoModel video) {
    _videos.add(video);
    notifyListeners();
  }
}