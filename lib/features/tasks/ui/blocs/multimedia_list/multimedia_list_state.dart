part of 'multimedia_list_cubit.dart';

class MultimediaListState extends Equatable {
  final List<Multimedia> videos;
  final StatusUtil status;
  final String? statusMessage;
  final int currentVideoIndex;

  const MultimediaListState({
    this.videos = const [],
    this.status = StatusUtil.initial,
    this.statusMessage,
    this.currentVideoIndex = 0,
  });

  MultimediaListState copyWith({
    List<Multimedia>? videos,
    StatusUtil? status,
    String? statusMessage,
    int? currentVideoIndex,
  }) {
    return MultimediaListState(
      videos: videos ?? this.videos,
      status: status ?? this.status,
      statusMessage: statusMessage ?? this.statusMessage,
      currentVideoIndex: currentVideoIndex ?? this.currentVideoIndex,
    );
  }

  @override
  List<Object> get props => [videos, status, currentVideoIndex];
}
