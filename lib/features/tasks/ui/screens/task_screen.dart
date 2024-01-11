import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TaskScreen extends StatelessWidget {
  static const String name = 'task_screen';
  final String taskId;

  const TaskScreen({
    super.key,
    required this.taskId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multimedia'),
      ),
      body: const Column(
        children: [
          CustomVideoPlayer(),
          VideoDescription(),
          VideoPlaylist(),
        ],
      ),
    );
  }
}

class VideoPlaylist extends StatelessWidget {
  const VideoPlaylist({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: const [
          VideoPlaylistItem(),
          VideoPlaylistItem(),
        ],
      ),
    );
  }
}

class VideoPlaylistItem extends StatelessWidget {
  final bool playing;
  final void Function()? onTap;

  const VideoPlaylistItem({
    super.key,
    this.playing = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: onTap,
            child: CircleAvatar(
              child: Icon(
                playing ? Icons.pause : Icons.play_arrow,
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Equilibrio sobre una pierna',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('Creado por: Ana Contreras'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class VideoDescription extends StatelessWidget {
  const VideoDescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Equilibrio sobre una pierna',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8),
          Text(
              'Estiramientos y movilizaciones para las cervicales - Mejora tu dolor de cuello y hombros')
        ],
      ),
    );
  }
}

// Players
class CustomVideoPlayer extends StatefulWidget {
  final String? url;
  const CustomVideoPlayer({
    super.key,
    this.url,
  });

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late final VideoPlayerController _vpController;
  late final ChewieController _chewieController;

  @override
  void initState() {
    _vpController = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      ),
    );

    _vpController.initialize().then((value) => setState(() {}));

    _chewieController = ChewieController(
      videoPlayerController: _vpController,
      autoPlay: true,
      looping: true,
    );

    super.initState();
  }

  @override
  void dispose() {
    _vpController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }
}

class CustomYouTubeVideoPlayer extends StatelessWidget {
  const CustomYouTubeVideoPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
