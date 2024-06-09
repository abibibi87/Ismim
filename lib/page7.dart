import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ismim/page8.dart';
import 'package:ismim/homepage.dart';

class PageSeven extends StatefulWidget {
  const PageSeven({super.key});

  @override
  _PageSevenState createState() => _PageSevenState();
}

class _PageSevenState extends State<PageSeven>
    with SingleTickerProviderStateMixin {
  late AudioPlayer audioPlayer;
  bool isPlaying = false;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    _controller = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..forward();

    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1.0, -1.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    Future.delayed(const Duration(milliseconds: 2500), () {
      playAudio();
    });
  }

  void playAudio() async {
    await audioPlayer.setAsset('assets/sound/page7.mp3');
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
    _controller.dispose();
    audioPlayer.dispose();
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
                  'assets/hlm_7.jpg',
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
                            const PageEight(),
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
                top: 80,
                left: 450,
                child: Image.asset(
                  'assets/text/6.png',
                  width: 500,
                  height: 500,
                ),
              ),
              Positioned(
                top: -80,
                left: 450,
                child: Image.asset(
                  'assets/text/5.png',
                  width: 500,
                  height: 500,
                ),
              ),
              Positioned(
                top: 80,
                left: 80,
                child: Image.asset(
                  'assets/animation/Adam.png',
                  width: 500,
                  height: 500,
                ),
              ),
              Positioned(
                top: -20,
                left: 900,
                child: SlideTransition(
                  position: _offsetAnimation,
                  child: Image.asset(
                    'assets/animation/buroq.png',
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
