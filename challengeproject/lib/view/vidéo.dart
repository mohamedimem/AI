import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayerVideoAndPopPage extends StatefulWidget {
  final String videoPath;
  const PlayerVideoAndPopPage({super.key, required this.videoPath});

  @override
  _PlayerVideoAndPopPageState createState() => _PlayerVideoAndPopPageState();
}

class _PlayerVideoAndPopPageState extends State<PlayerVideoAndPopPage> {
  late VideoPlayerController _controller;
  //bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(
                  _controller,
                ),
              )
            : const CircularProgressIndicator(),

        //Container(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
