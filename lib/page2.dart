import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ismim/page3.dart';
import 'package:ismim/homepage.dart';
import 'dart:async';

class PageTwo extends StatefulWidget {
  const PageTwo({super.key});

  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> with TickerProviderStateMixin {
  late AudioPlayer audioPlayer;
  bool isPlaying = false;
  late AnimationController _buroqController;
  late Animation<Offset> _buroqAnimation;
  late AnimationController _awan1Controller;
  late Animation<Offset> _awan1Animation;
  late AnimationController _awan5Controller;
  late Animation<Offset> _awan5Animation;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    _initAnimations();
    _initAudioPlayer();
    Timer(const Duration(milliseconds: 2500), playAudio);
  }

  Future<void> _initAudioPlayer() async {
    await audioPlayer.setAsset('assets/sound/page2.mp3');
  }

  void _initAnimations() {
    _buroqController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..forward();

    _buroqAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1.0, -1.0),
    ).animate(CurvedAnimation(
      parent: _buroqController,
      curve: Curves.easeInOut,
    ));

    _awan1Controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat(reverse: true);

    _awan1Animation = Tween<Offset>(
      begin: const Offset(-0.5, 0.0),
      end: const Offset(0.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _awan1Controller,
      curve: Curves.easeInOut,
    ));

    _awan5Controller = AnimationController(
      duration: const Duration(seconds: 12),
      vsync: this,
    )..repeat(reverse: true);

    _awan5Animation = Tween<Offset>(
      begin: const Offset(0.5, 0.0),
      end: const Offset(-0.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _awan5Controller,
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
    _buroqController.dispose();
    _awan1Controller.dispose();
    _awan5Controller.dispose();
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
                  'assets/hlm_2.jpg',
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
                            const PageThree(),
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
                left: 600,
                child: Image.asset(
                  'assets/text/3.png',
                  width: 600,
                  height: 600,
                ),
              ),
              Positioned(
                top: 30,
                left: 200,
                child: SlideTransition(
                  position: _buroqAnimation,
                  child: Image.asset(
                    'assets/animation/buroq.png',
                    width: 400,
                    height: 400,
                  ),
                ),
              ),
              Positioned(
                top: -75,
                left: 100,
                child: SlideTransition(
                  position: _awan1Animation,
                  child: Image.asset(
                    'assets/animation/awan1.png',
                    width: 400,
                    height: 400,
                  ),
                ),
              ),
              Positioned(
                top: -60,
                left: 1100,
                child: SlideTransition(
                  position: _awan5Animation,
                  child: Image.asset(
                    'assets/animation/awan5.png',
                    width: 400,
                    height: 400,
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
