import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:teraflex_mobile/features/tasks/domain/entities/multimedia.dart';
import 'package:teraflex_mobile/features/tasks/ui/blocs/multimedia_list/multimedia_list_cubit.dart';
import 'package:teraflex_mobile/utils/status_util.dart';
import 'package:video_player/video_player.dart';

class TaskScreen extends StatefulWidget {
  static const String name = 'task_screen';
  final String taskId;

  const TaskScreen({
    super.key,
    required this.taskId,
  });

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<MultimediaListCubit>()
        .getVideos(assignmentId: int.parse(widget.taskId));
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<MultimediaListCubit>().state;

    if (state.status == StatusUtil.loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (state.status == StatusUtil.error) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(state.statusMessage ?? 'Error desconocido'),
            ),
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('Regresar'),
            ),
          ],
        ),
      );
    }

    if (state.status == StatusUtil.empty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Multimedia')),
        body: Center(
          child: Text(
              state.statusMessage ?? 'No hay videos asignados a esta tarea'),
        ),
      );
    }

    return const _TaskView();
  }
}

class _TaskView extends StatelessWidget {
  const _TaskView();

  Multimedia? getVideo(BuildContext context) {
    final state = context.watch<MultimediaListCubit>().state;
    if (state.currentVideoIndex < 0) {
      return null;
    }

    return state.videos[state.currentVideoIndex];
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<MultimediaListCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Multimedia'),
      ),
      body: Column(
        children: [
          //const CustomVideoPlayer(),
          VideoDescription(video: getVideo(context)),
          VideoPlaylist(
            videos: state.videos,
            currentVideoIndex: state.currentVideoIndex,
            onChange: context.read<MultimediaListCubit>().onChangeCurrentVideo,
          ),
        ],
      ),
    );
  }
}

class VideoPlaylist extends StatelessWidget {
  final List<Multimedia> videos;
  final int currentVideoIndex;
  final void Function({required int index})? onChange;

  const VideoPlaylist({
    super.key,
    required this.videos,
    this.currentVideoIndex = 0,
    this.onChange,
  });

  bool getPlaying(int index) {
    if (currentVideoIndex < 0) {
      return false;
    }

    return index == currentVideoIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final video = videos[index];
          return VideoPlaylistItem(
            playing: getPlaying(index),
            onTap: () {
              onChange?.call(index: index);
            },
            video: video,
          );
        },
      ),
    );
  }
}

class VideoPlaylistItem extends StatelessWidget {
  final Multimedia video;
  final bool playing;
  final void Function()? onTap;

  const VideoPlaylistItem({
    super.key,
    required this.video,
    this.playing = false,
    this.onTap,
  });

  IconData get icon {
    if (!video.status) {
      return Icons.visibility_off_rounded;
    }

    return playing ? Icons.pause : Icons.play_arrow;
  }

  void showMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
            'El video no está disponible, contacte con su terapeuta'),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorSchema = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: video.status ? onTap : () => showMessage(context),
      child: Container(
        color: playing ? colorSchema.secondary : Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Row(
            children: [
              CircleAvatar(
                child: Icon(icon),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: playing ? Colors.white : Colors.black,
                      ),
                    ),
                    Text(
                      'Creado por: ${video.uploadedBy}',
                      style: TextStyle(
                        color: playing ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VideoDescription extends StatelessWidget {
  final Multimedia? video;

  const VideoDescription({
    super.key,
    this.video,
  });

  @override
  Widget build(BuildContext context) {
    if (video == null) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Text(
          'Los videos no están disponibles. Contacte con su terapeuta para que los habilite.',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            video!.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(video!.description)
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
