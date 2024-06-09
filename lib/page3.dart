import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ismim/page4.dart';
import 'package:ismim/homepage.dart';
import 'dart:async';

class PageThree extends StatefulWidget {
  const PageThree({super.key});

  @override
  _PageThreeState createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree>
    with SingleTickerProviderStateMixin {
  late AudioPlayer audioPlayer;
  bool isPlaying = false;
  late AnimationController _controller;
  late Animation<Offset> _awan3Animation;
  late Animation<Offset> _awan4Animation;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);
    _initAnimations();
    _initAudioPlayer();
    Timer(const Duration(milliseconds: 2500), playAudio);
  }

  void _initAudioPlayer() async {
    await audioPlayer.setAsset('assets/sound/page3.mp3');
  }

  void _initAnimations() {
    _awan3Animation = Tween<Offset>(
      begin: const Offset(-0.5, 0.0),
      end: const Offset(0.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _awan4Animation = Tween<Offset>(
      begin: const Offset(0.5, 0.0),
      end: const Offset(-0.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  void playAudio() async {
    await audioPlayer.play();
    setState(() {
      isPlaying = true;
    });
  }

  void stopAudio() async {
    await audioPlayer.stop();
    setState(() {
      isPlaying = false;
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Image.asset(
                  'assets/hlm_3.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: IconButton(
                  icon: Image.asset('assets/tombol/button_volume.png'),
                  onPressed: () {
                    if (isPlaying) {
                      stopAudio();
                    } else {
                      playAudio();
                    }
                  },
                  iconSize: width * 0.1,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  icon: Image.asset('assets/tombol/button_home.png'),
                  onPressed: () {
                    stopAudio();
                    Navigator.pushAndRemoveUntil(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const HomePage(),
                        transitionDuration: const Duration(seconds: 3),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                  iconSize: width * 0.1,
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: IconButton(
                  onPressed: () {
                    stopAudio();
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const PageFour(),
                        transitionDuration: const Duration(seconds: 3),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          var begin = const Offset(0.0, 1.0);
                          var end = Offset.zero;
                          var curve = Curves.ease;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));

                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      ),
                    ).then((value) {
                      if (ModalRoute.of(context)?.settings.name == '/') {
                        stopAudio();
                      }
                    });
                  },
                  icon: Image.asset('assets/tombol/button_next.png'),
                  iconSize: width * 0.1,
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Image.asset('assets/tombol/button_back.png'),
                  iconSize: width * 0.1,
                ),
              ),
              Positioned(
                top: -20,
                left: 200,
                child: Image.asset(
                  'assets/text/4.png',
                  width: 600,
                  height: 600,
                ),
              ),
              Positioned(
                top: 10,
                left: 650,
                child: ScaleTransition(
                  scale: Tween(begin: 0.8, end: 1.0).animate(_controller),
                  child: Image.asset(
                    'assets/animation/Buroq1.png',
                    width: 600,
                    height: 600,
                  ),
                ),
              ),
              Positioned(
                top: -60,
                left: 100,
                child: SlideTransition(
                  position: _awan3Animation,
                  child: Image.asset(
                    'assets/animation/awan5.png',
                    width: 300,
                    height: 300,
                  ),
                ),
              ),
              Positioned(
                top: -60,
                left: 1100,
                child: SlideTransition(
                  position: _awan4Animation,
                  child: Image.asset(
                    'assets/animation/awan4.png',
                    width: 250,
                    height: 250,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
