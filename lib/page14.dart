import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ismim/page15.dart';
import 'package:ismim/homepage.dart';

class PageFourTeen extends StatefulWidget {
  const PageFourTeen({super.key});

  @override
  _PageFourTeenState createState() => _PageFourTeenState();
}

class _PageFourTeenState extends State<PageFourTeen> {
  late AudioPlayer audioPlayer;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    audioPlayer.setLoopMode(LoopMode.off);
    Future.delayed(const Duration(milliseconds: 2500), () {
      playAudio();
    });
  }

  void playAudio() async {
    await audioPlayer.setAsset('assets/sound/page14.mp3');
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
                  'assets/hlm_14.jpg',
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
                            const PageFiveeTeen(),
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
            ],
          ),
        ),
      ),
    );
  }
}
