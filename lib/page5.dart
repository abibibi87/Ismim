import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ismim/page6.dart';
import 'package:ismim/homepage.dart';

class PageFive extends StatefulWidget {
  const PageFive({super.key});

  @override
  _PageFiveState createState() => _PageFiveState();
}

class _PageFiveState extends State<PageFive> with TickerProviderStateMixin {
  late AudioPlayer audioPlayer;
  bool isPlaying = false;
  late AnimationController _buroqController;
  late AnimationController _awanController;
  late Animation<Offset> _buroqAnimation;
  late Animation<Offset> _awan1Animation;
  late Animation<Offset> _awan2Animation;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    _buroqController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..forward();

    _awanController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);

    _initAnimations();

    Future.delayed(const Duration(milliseconds: 2500), () {
      playAudio();
    });
  }

  void _initAnimations() {
    _buroqAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1.0, -1.0),
    ).animate(CurvedAnimation(
      parent: _buroqController,
      curve: Curves.easeInOut,
    ));

    _awan1Animation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _awanController,
      curve: Curves.easeInOut,
    ));

    _awan2Animation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _awanController,
      curve: Curves.easeInOut,
    ));
  }

  void playAudio() async {
    await audioPlayer.setAsset('assets/sound/page5.mp3');
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
    _buroqController.dispose();
    _awanController.dispose();
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
                  'assets/hlm_5.jpg',
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
                            const PageSix(),
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
                top: 60,
                left: 700,
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
                top: -20,
                left: 600,
                child: Image.asset(
                  'assets/text/11.png',
                  width: 600,
                  height: 600,
                ),
              ),
              Positioned(
                top: -75,
                left: 100,
                child: SlideTransition(
                  position: _awan1Animation,
                  child: Image.asset(
                    'assets/animation/awan3.png',
                    width: 400,
                    height: 400,
                  ),
                ),
              ),
              Positioned(
                top: -60,
                left: 1100,
                child: SlideTransition(
                  position: _awan2Animation,
                  child: Image.asset(
                    'assets/animation/awan4.png',
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
