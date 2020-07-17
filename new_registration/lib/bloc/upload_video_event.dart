part of 'upload_video_bloc.dart';

abstract class UploadVideoEvent extends Equatable {
  const UploadVideoEvent();

  @override
  List<Object> get props => <Object>[];
}

class SelectSubmitEvent extends UploadVideoEvent {
  const SelectSubmitEvent({@required this.source});

  final ImageSource source;

  @override
  List<Object> get props => <Object>[source];
}
