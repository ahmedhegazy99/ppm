import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  final String ?videoSource;

  const VideoWidget(this.videoSource);

  @override
  VideoWidgetState createState() => VideoWidgetState();
}

class VideoWidgetState extends State<VideoWidget> {
  VideoPlayerController ? _controller;
  bool _isPlaying = false;

  Widget ? videoStatusAnimation;

  @override
  void initState() {
    super.initState();

    videoStatusAnimation = Container();

    _controller = VideoPlayerController.network('${widget.videoSource}')
      ..addListener(() {
        final bool isPlaying = _controller!.value.isPlaying;
        if (isPlaying != _isPlaying) {
          setState(() {
            _isPlaying = isPlaying;
          });
        }
      })
      ..initialize().then((_) {
        Timer(Duration(milliseconds: 0), () {
          if (!mounted) return;

          setState(() {});
          _controller!.play();
        });
      });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: _controller!.value.isInitialized ? videoPlayer() : Container(),
      ),
    );
  }

  Widget videoPlayer() => Stack(
    children: <Widget>[
      video(),
      Align(
        alignment: Alignment.bottomCenter,
        child: VideoProgressIndicator(
          _controller!,
          allowScrubbing: true,
          padding: EdgeInsets.all(16.0),
        ),
      ),
      Center(child: videoStatusAnimation),
    ],
  );

  Widget video() => GestureDetector(
    child: VideoPlayer(_controller!),
    onTap: () {
      if (!_controller!.value.isInitialized) {
        return;
      }
      if (_controller!.value.isPlaying) {
        videoStatusAnimation =
            FadeAnimation(child: const Icon(Icons.pause, size: 100.0, color: Colors.white,));
        _controller!.pause();
      } else {
        videoStatusAnimation =
            FadeAnimation(child: const Icon(Icons.play_arrow, size: 100.0, color: Colors.white,));
        _controller!.play();
      }
    },
  );
}

class FadeAnimation extends StatefulWidget {
  const FadeAnimation(
      {this.child, this.duration = const Duration(milliseconds: 1000)});

  final Widget ? child;
  final Duration duration;

  @override
  _FadeAnimationState createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController ? animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: widget.duration, vsync: this);
    animationController!.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    animationController!.forward(from: 0.0);
  }

  @override
  void deactivate() {
    animationController!.stop();
    super.deactivate();
  }

  @override
  void didUpdateWidget(FadeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.child != widget.child) {
      animationController!.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => animationController!.isAnimating
      ? Opacity(
    opacity: 1.0 - animationController!.value,
    child: widget.child,
  )
      : Container();
}