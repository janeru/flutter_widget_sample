part of 'upload_video_bloc.dart';

abstract class UploadVideoState extends Equatable {
  const UploadVideoState();

  List<Object> get props => [];
}

class UploadVideoInitial extends UploadVideoState {}

class SelectVideoCanceledState extends UploadVideoState {}

class SelectVideoPendingState extends UploadVideoState {}

class SelectVideoSuccessState extends UploadVideoState {
  const SelectVideoSuccessState({this.videoPlayerController, this.videoPlayerControllerInitialized});

  final bool videoPlayerControllerInitialized;
  final VideoPlayerController videoPlayerController;

  SelectVideoSuccessState copyWith(
      {VideoPlayerController videoPlayerController, bool videoPlayerControllerInitialized}) {
    return SelectVideoSuccessState(
        videoPlayerController: videoPlayerController ?? this.videoPlayerController,
        videoPlayerControllerInitialized: videoPlayerControllerInitialized);
  }

  @override
  List<Object> get props => <Object>[videoPlayerControllerInitialized, videoPlayerController];
}

class SelectVideoErrorState extends UploadVideoState {
  const SelectVideoErrorState({this.errorMessage});
  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
