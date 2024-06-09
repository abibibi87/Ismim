import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ismim/page14.dart';
import 'package:ismim/homepage.dart';

class PageThirTeen extends StatefulWidget {
  const PageThirTeen({super.key});

  @override
  _PageThirTeenState createState() => _PageThirTeenState();
}

class _PageThirTeenState extends State<PageThirTeen>
    with TickerProviderStateMixin {
  late AudioPlayer audioPlayer;
  bool isPlaying = false;
  late AnimationController _awan1Controller;
  late Animation<Offset> _awan1Animation;
  late AnimationController _awan2Controller;
  late Animation<Offset> _awan2Animation;
  late AnimationController _awan3Controller;
  late Animation<Offset> _awan3Animation;
  late AnimationController _awan4Controller;
  late Animation<Offset> _awan4Animation;
  late AnimationController _awan5Controller;
  late Animation<Offset> _awan5Animation;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    audioPlayer.setLoopMode(LoopMode.off);
    Future.delayed(const Duration(milliseconds: 2500), () {
      playAudio();
    });

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

    _awan2Controller = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat(reverse: true);

    _awan2Animation = Tween<Offset>(
      begin: const Offset(0.5, 0.0),
      end: const Offset(-0.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _awan2Controller,
      curve: Curves.easeInOut,
    ));

    _awan3Controller = AnimationController(
      duration: const Duration(seconds: 12),
      vsync: this,
    )..repeat(reverse: true);

    _awan3Animation = Tween<Offset>(
      begin: const Offset(-0.5, 0.0),
      end: const Offset(0.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _awan3Controller,
      curve: Curves.easeInOut,
    ));

    _awan4Controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat(reverse: true);

    _awan4Animation = Tween<Offset>(
      begin: const Offset(0.5, 0.0),
      end: const Offset(-0.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _awan4Controller,
      curve: Curves.easeInOut,
    ));

    _awan5Controller = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat(reverse: true);

    _awan5Animation = Tween<Offset>(
      begin: const Offset(-0.5, 0.0),
      end: const Offset(0.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _awan5Controller,
      curve: Curves.easeInOut,
    ));
  }

  void playAudio() async {
    await audioPlayer.setAsset('assets/sound/page13.mp3');
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
    _awan1Controller.dispose();
    _awan2Controller.dispose();
    _awan3Controller.dispose();
    _awan4Controller.dispose();
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
                  'assets/hlm_13.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: -195,
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
                top: -180,
                left: 1100,
                child: SlideTransition(
                  position: _awan2Animation,
                  child: Image.asset(
                    'assets/animation/awan3.png',
                    width: 400,
                    height: 400,
                  ),
                ),
              ),
              Positioned(
                top: -185,
                left: 300,
                child: SlideTransition(
                  position: _awan3Animation,
                  child: Image.asset(
                    'assets/animation/awan2.png',
                    width: 400,
                    height: 400,
                  ),
                ),
              ),
              Positioned(
                top: -190,
                left: 900,
                child: SlideTransition(
                  position: _awan4Animation,
                  child: Image.asset(
                    'assets/animation/awan4.png',
                    width: 400,
                    height: 400,
                  ),
                ),
              ),
              Positioned(
                top: -185,
                left: 600,
                child: SlideTransition(
                  position: _awan5Animation,
                  child: Image.asset(
                    'assets/animation/awan5.png',
                    width: 400,
                    height: 400,
                  ),
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
                bottom: 10,
                right: 10,
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const PageFourTeen(),
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
            ],
          ),
        ),
      ),
    );
  }
}
