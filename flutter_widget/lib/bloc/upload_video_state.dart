part of 'upload_video_bloc.dart';

abstract class UploadVideoState extends Equatable {
  const UploadVideoState();

  List<Object> get props => [];
}

class UploadVideoInitial extends UploadVideoState {}

class SelectVideoCanceledState extends UploadVideoState {}

class SelectVideoPendingState extends UploadVideoState {}

class SelectVideoSuccessState extends UploadVideoState {
  const SelectVideoSuccessState({this.videoPlayerController});

  final VideoPlayerController videoPlayerController;

  SelectVideoSuccessState copyWith(
      {VideoPlayerController videoPlayerController}) {
    return SelectVideoSuccessState(
        videoPlayerController: videoPlayerController ?? this.videoPlayerController,
       );
  }

  @override
  List<Object> get props => <Object>[videoPlayerController];
}

class SelectVideoErrorState extends UploadVideoState {
  const SelectVideoErrorState({this.errorMessage});
  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
