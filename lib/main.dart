import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'View/VideoView.dart';
import 'ViewModel/VideoViewModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VideoViewModel(),
      child: MaterialApp(
        home: VideoListScreen(),
      ),
    );
  }
}
