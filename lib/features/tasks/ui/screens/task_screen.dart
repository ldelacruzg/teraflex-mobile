import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pod_player/pod_player.dart';
import 'package:teraflex_mobile/features/tasks/domain/entities/multimedia.dart';
import 'package:teraflex_mobile/features/tasks/ui/blocs/multimedia_list/multimedia_list_cubit.dart';
import 'package:teraflex_mobile/utils/status_util.dart';

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

    return const CustomVideoPlayer();
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
                      'Subido por: ${video.uploadedBy}',
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

    return ExpansionTile(
      tilePadding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      title: Text(
        video!.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        video!.description,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      children: [
        Text(
          video!.description,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// Player
class CustomVideoPlayer extends StatefulWidget {
  const CustomVideoPlayer({Key? key}) : super(key: key);

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late final PodPlayerController controller;

  @override
  void initState() {
    final state = context.read<MultimediaListCubit>().state;
    final video = state.videos[state.currentVideoIndex];

    _initialiseVideoPlayer(
      playVideoFrom: _getPlayVideoFrom(
        videoUrl: video.url,
        type: video.type,
      ),
    );
    super.initState();
  }

  PlayVideoFrom _getPlayVideoFrom(
      {required String videoUrl, required MultimediaType type}) {
    return type == MultimediaType.mp4
        ? PlayVideoFrom.network(videoUrl)
        : PlayVideoFrom.youtube(videoUrl);
  }

  void _initialiseVideoPlayer({required PlayVideoFrom playVideoFrom}) {
    controller = PodPlayerController(
      playVideoFrom: playVideoFrom,
    )..initialise();
  }

  void _changeVideo({required PlayVideoFrom playVideoFrom}) {
    controller.changeVideo(
      playVideoFrom: playVideoFrom,
    );
  }

  void _onChange({required int index}) async {
    context.read<MultimediaListCubit>().onChangeCurrentVideo(index: index);

    final state = context.read<MultimediaListCubit>().state;
    final video = state.videos[index];
    _changeVideo(
      playVideoFrom: _getPlayVideoFrom(
        videoUrl: video.url,
        type: video.type,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<MultimediaListCubit>().state;

    return Scaffold(
      appBar: AppBar(title: const Text('Multimedia')),
      body: Column(
        children: [
          PodVideoPlayer(controller: controller),
          VideoDescription(video: state.videos[state.currentVideoIndex]),
          VideoPlaylist(
            videos: state.videos,
            currentVideoIndex: state.currentVideoIndex,
            onChange: _onChange,
          ),
        ],
      ),
    );
  }
}
