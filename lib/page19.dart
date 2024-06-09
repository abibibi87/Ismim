import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ismim/page20.dart';
import 'package:ismim/homepage.dart';

class PageNineeTeen extends StatefulWidget {
  const PageNineeTeen({super.key});

  @override
  _PageNineeTeenState createState() => _PageNineeTeenState();
}

class _PageNineeTeenState extends State<PageNineeTeen>
    with TickerProviderStateMixin {
  AudioPlayer? audioPlayer;
  bool isPlaying = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();

    Future.delayed(const Duration(milliseconds: 2500), () {
      playAudio();
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animation = Tween<double>(
      begin: 1.0,
      end: 1.5,
    ).animate(_animationController);

    _animationController.forward();
    _animationController.repeat();
  }

  void playAudio() async {
    try {
      await audioPlayer!.setAsset('assets/sound/page19.mp3');
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
    _animationController.reset();
    _animationController.dispose();
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
                  'assets/hlm_19.jpg',
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
                            const PageTwenty(),
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
                top: -120,
                left: 200,
                child: Image.asset(
                  'assets/text/17.png',
                  width: 500,
                  height: 500,
                ),
              ),
              Positioned(
                top: 150,
                left: 800,
                child: Image.asset(
                  'assets/text/18.png',
                  width: 500,
                  height: 500,
                ),
              ),
              Positioned(
                top: 80,
                left: 80,
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animation.value,
                      child: Image.asset(
                        'assets/animation/cahaya.png',
                        width: 550,
                        height: 550,
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                top: 80,
                left: 80,
                child: Image.asset(
                  'assets/animation/nabibg.png',
                  width: 550,
                  height: 550,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
