import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ismim/page10.dart';
import 'package:ismim/homepage.dart';

class PageEleven extends StatefulWidget {
  const PageEleven({super.key});

  @override
  _PageElevenState createState() => _PageElevenState();
}

class _PageElevenState extends State<PageEleven>
    with SingleTickerProviderStateMixin {
  AudioPlayer? audioPlayer;
  bool isPlaying = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    Future.delayed(const Duration(milliseconds: 2500), () {
      playAudio();
    });

    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);
  }

  void playAudio() async {
    try {
      await audioPlayer!.setAsset('assets/sound/page11.mp3');
      audioPlayer!.play();
      setState(() {
        isPlaying = true;
      });
    } catch (e) {}
  }

  void stopAudio() async {
    await audioPlayer!.stop();
    setState(() {
      isPlaying = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    audioPlayer?.dispose();
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
                  'assets/hlm_11.jpg',
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
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const PageTen(),
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
                top: 120,
                left: -50,
                child: ScaleTransition(
                  scale: Tween(begin: 0.9, end: 1.0).animate(_controller),
                  child: Image.asset(
                    'assets/animation/Adam.png',
                    width: 500,
                    height: 500,
                  ),
                ),
              ),
              Positioned(
                top: 50,
                left: 180,
                child: ScaleTransition(
                  scale: Tween(begin: 0.8, end: 1.2).animate(_controller),
                  child: Image.asset(
                    'assets/animation/cahaya.png',
                    width: 900,
                    height: 900,
                  ),
                ),
              ),
              Positioned(
                top: 20,
                left: 160,
                child: Image.asset(
                  'assets/animation/nabibg.png',
                  width: 950,
                  height: 950,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
