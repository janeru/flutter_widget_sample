import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

part 'upload_video_event.dart';
part 'upload_video_state.dart';

class UploadVideoBloc extends Bloc<UploadVideoEvent, UploadVideoState> {
  UploadVideoBloc() : super(null);
  @override
  UploadVideoState get initialState => UploadVideoInitial();

  @override
  Stream<UploadVideoState> mapEventToState(
    UploadVideoEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is SelectSubmitEvent) {
      // This funcion will helps you to pick a Video File
//      _pickVideo(ImageSource source, {BuildContext context}) async {
////    File video = await ImagePicker.pickVideo(source: ImageSource.gallery);
//
//        final PickedFile video = await _picker.getVideo(source: source, maxDuration: const Duration(seconds: 10));
//        if (source == null) {
//          yield SelectVideoCanceledState();
//        }
//      }
      yield* _uploadVideo(event);
    }
  }

  Stream<UploadVideoState> _uploadVideo(SelectSubmitEvent event) async* {
    final ImagePicker _picker = ImagePicker();
    VideoPlayerController _videoPlayerController;
    PickedFile _video;
    try {
      yield SelectVideoPendingState();

      final PickedFile video = await _picker.getVideo(source: event.source, maxDuration: const Duration(seconds: 10));

      if (video == null) {
        yield SelectVideoCanceledState();
        return;
      }

//      _videoPlayerController = VideoPlayerController.file(File(video.path))
//        ..initialize().then((_) {
//          _videoPlayerController.play();
//        });

      _videoPlayerController = VideoPlayerController.file(File(video.path))..initialize();
      await _videoPlayerController.play();

      yield SelectVideoSuccessState(
          videoPlayerControllerInitialized: true, videoPlayerController: _videoPlayerController);

//        ..initialize().then((_) {
//          _videoPlayerController.play();
//        });

    } on Exception catch (e) {
      yield SelectVideoErrorState(errorMessage: e.toString());
    }
  }
}
