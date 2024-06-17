import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ismim/page18.dart';
import 'package:ismim/homepage.dart';

class PageSevennTeen extends StatefulWidget {
  const PageSevennTeen({super.key});

  @override
  _PageSevennTeenState createState() => _PageSevennTeenState();
}

class _PageSevennTeenState extends State<PageSevennTeen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late AudioPlayer audioPlayer;
  bool isPlaying = false;
  late AnimationController _controllerLeft;
  late AnimationController _controllerRight;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    WidgetsBinding.instance.addObserver(this);
    audioPlayer = AudioPlayer();
    audioPlayer.setLoopMode(LoopMode.off);
    Future.delayed(const Duration(milliseconds: 2500), () {
      playAudio();
    });

    _controllerLeft = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);

    _controllerRight = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);
  }

  void playAudio() async {
    await audioPlayer.setAsset('assets/sound/page17.mp3');
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
    _controllerLeft.dispose();
    _controllerRight.dispose();
    audioPlayer.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      if (ModalRoute.of(context)?.isCurrent ?? false) {
        playAudio();
      }
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      stopAudio();
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              'assets/hlm_17.jpg',
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
            top: -70,
            left: 60,
            child: Image.asset(
              'assets/text/9.png',
              width: 500,
              height: 500,
            ),
          ),
          Positioned(
            top: 90,
            left: 1050,
            child: RotationTransition(
              turns: Tween(begin: 0.0, end: 0.10).animate(_controllerRight),
              child: Image.asset(
                'assets/animation/tangankanan.png',
                width: 200,
                height: 200,
              ),
            ),
          ),
          Positioned(
            top: 155,
            left: 620,
            child: RotationTransition(
              turns: Tween(begin: 0.0, end: -0.10).animate(_controllerLeft),
              child: Image.asset(
                'assets/animation/tangankiri.png',
                width: 200,
                height: 200,
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 700,
            child: Image.asset(
              'assets/animation/Angkat.png',
              width: 500,
              height: 500,
            ),
          ),
          Positioned(
            top: 120,
            left: 200,
            child: Image.asset(
              'assets/animation/awan3.png',
              width: 800,
              height: 800,
            ),
          ),
          Positioned(
            top: 120,
            left: 500,
            child: Image.asset(
              'assets/animation/awan4.png',
              width: 800,
              height: 800,
            ),
          ),
          Positioned(
            top: 120,
            left: 800,
            child: Image.asset(
              'assets/animation/awan1.png',
              width: 800,
              height: 800,
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
                        const PageEighTeen(),
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
    );
  }
}
