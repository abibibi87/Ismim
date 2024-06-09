import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ismim/page11.dart';
import 'package:ismim/homepage.dart';

class PageTen extends StatefulWidget {
  const PageTen({super.key});

  @override
  _PageTenState createState() => _PageTenState();
}

class _PageTenState extends State<PageTen> with SingleTickerProviderStateMixin {
  late AudioPlayer audioPlayer;
  bool isPlaying = false;
  late AnimationController _controller;
  late Animation<double> _cahayaAnimation;
  late Animation<double> _buroqAnimation;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();

    audioPlayer
        .setAudioSource(AudioSource.uri(Uri.parse("assets/sound/page10.mp3")));

    Future.delayed(const Duration(milliseconds: 2500), () {
      playAudio();
    });

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _cahayaAnimation = Tween(begin: 0.8, end: 1.2).animate(_controller);
    _buroqAnimation = Tween(begin: 0.8, end: 1.2).animate(_controller);
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
                  'assets/hlm_10.jpg',
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
                            const PageEleven(),
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
                top: -230,
                left: -185,
                child: ScaleTransition(
                  scale: _cahayaAnimation,
                  child: Image.asset(
                    'assets/animation/cahaya.png',
                    width: 900,
                    height: 900,
                  ),
                ),
              ),
              Positioned(
                top: 150,
                left: 950,
                child: ScaleTransition(
                  scale: _buroqAnimation,
                  child: Image.asset(
                    'assets/animation/buroq.png',
                    width: 300,
                    height: 300,
                  ),
                ),
              ),
              Positioned(
                top: 110,
                left: 165,
                child: Image.asset(
                  'assets/animation/Allah01.png',
                  width: 200,
                  height: 200,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
