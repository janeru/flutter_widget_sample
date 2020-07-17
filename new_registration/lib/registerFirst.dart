import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_registration/bloc/upload_video_bloc.dart';
import 'package:new_registration/widgets/stepProgressView.dart';
import 'package:video_player/video_player.dart';

class RegisterFirst extends StatefulWidget {
  RegisterFirst({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RegisterFirstState createState() => _RegisterFirstState();
}

class _RegisterFirstState extends State<RegisterFirst> {
  final _stepsText = ["About you", "Some more..", "Your credit card details"];

  final _stepCircleRadius = 10.0;

  final _stepProgressViewHeight = 150.0;

  Color _activeColor = Colors.lightBlue;

  Color _inactiveColor = Colors.grey;

  TextStyle _headerStyle = TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold);

  TextStyle _stepStyle = TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold);

  Size _safeAreaSize;

  int _curPage = 1;
  PageController _pageController;

  @override
//  void initState() {
//    super.initState();
//    _pageController = PageController(initialPage: 1);
//    _pageController.addListener(() {
//      print('_pageController:${_pageController.page}');
//      setState(() {
//        _curPage = _pageController.page.toInt();
//      });
//    });
//  }

//  @override
//  void dispose() {
//    _pageController.dispose();
//    super.dispose();
//  }

  Widget _getStepProgress() {
    print(_curPage);
    return StepProgressView(
      _stepsText,
      _curPage,
      _stepProgressViewHeight,
      _safeAreaSize.width,
      _stepCircleRadius,
      _activeColor,
      _inactiveColor,
      _headerStyle,
      _stepStyle,
      decoration: BoxDecoration(color: Colors.white),
      padding: EdgeInsets.only(
        top: 48.0,
        left: 24.0,
        right: 24.0,
      ),
    );
  }

  @override
//Build method of Main Page
  Widget build(BuildContext context) {
    var mediaQD = MediaQuery.of(context);
    _safeAreaSize = mediaQD.size;
    return Scaffold(
        body: Column(
      children: <Widget>[
        Container(height: 150.0, child: _getStepProgress()),
        Expanded(
          child: PageView(
//            controller: _pageController,
            onPageChanged: (i) {
              print('changed page:$i');
              setState(() {
                _curPage = i + 1;
              });
            },
            children: <Widget>[
              BlocProvider<UploadVideoBloc>(
                create: (BuildContext context) => UploadVideoBloc(),
                child: Page1(),
              ),
              Page2(),
              Page3()
            ],
          ),
        )
      ],
    ));
  }
}

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  File _image;
  File _cameraImage;

  File _cameraVideo;
  final ImagePicker _picker = ImagePicker();

  PickedFile _video;
  PickedFile _imageFile;

  VideoPlayerController _cameraVideoPlayerController;
// This funcion will helps you to pick a Video File
//  _pickVideo(ImageSource source, {BuildContext context}) async {
////    File video = await ImagePicker.pickVideo(source: ImageSource.gallery);
//
//    final PickedFile video = await _picker.getVideo(source: source, maxDuration: const Duration(seconds: 10));
//
//    _video = video;
//    _videoPlayerController = VideoPlayerController.file(File(_video.path))
//      ..initialize().then((_) {
//        setState(() {});
//        _videoPlayerController.play();
//      });
//  }

  UploadVideoBloc _uploadVideoBloc;

  void _initBloc() {
    _uploadVideoBloc ??= BlocProvider.of<UploadVideoBloc>(context);
  }

  Widget build(BuildContext context) {
    _initBloc();
    return BlocBuilder<UploadVideoBloc, UploadVideoState>(
        bloc: _uploadVideoBloc,
        builder: (BuildContext context, UploadVideoState videoState) {
          if (videoState is SelectVideoSuccessState) {
            if (videoState.videoPlayerController.value.initialized) {
              return Column(
                children: <Widget>[
                  Container(
                    color: Colors.yellow,
                  ),
                  Container(
                      child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.432,
                        height: 124,
                        child: VideoPlayer(videoState.videoPlayerController),
                      )

                      /*
                  if (_video != null)
                    _videoPlayerController.value.initialized
                        ?
//                    ? AspectRatio(
//                        aspectRatio: _videoPlayerController.value.aspectRatio,
//                        child: VideoPlayer(_videoPlayerController),
//                      )
                        Container(
                            width: MediaQuery.of(context).size.width * 0.432,
                            height: 124,
                            child: VideoPlayer(_videoPlayerController),
                          )
                        : Container(),
                  Text(
                    "Click on Pick Video to select video",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  RaisedButton(
                    onPressed: () {
//                  _pickVideo(ImageSource.gallery, context: context);
//                      _uploadVideoBloc.add(SelectSubmitEvent(source: ImageSource.gallery));

                      _uploadVideoBloc.add(SelectSubmitEvent(source: ImageSource.gallery));
                    },
                    child: Text("Pick Video From Gallery"),
                  ),
                  */
                    ],
                  )),
                ],
              );
            }
            return Container();
          }
          return Column(
            children: <Widget>[
              Text(
                "Click on Pick Video to select video",
                style: TextStyle(fontSize: 18.0),
              ),
              RaisedButton(
                onPressed: () {
//                  _pickVideo(ImageSource.gallery, context: context);
//                      _uploadVideoBloc.add(SelectSubmitEvent(source: ImageSource.gallery));

                  _uploadVideoBloc.add(SelectSubmitEvent(source: ImageSource.gallery));
                },
                child: Text("Pick Video From Gallery"),
              ),
            ],
          );
        });
  }
}

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
    );
  }
}

class Page3 extends StatefulWidget {
  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple,
    );
  }
}
