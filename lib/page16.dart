import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ismim/page17.dart';
import 'package:ismim/homepage.dart';

class PageSixxTeen extends StatefulWidget {
  const PageSixxTeen({super.key});

  @override
  _PageSixxTeenState createState() => _PageSixxTeenState();
}

class _PageSixxTeenState extends State<PageSixxTeen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

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

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(_animationController);

    _animationController.repeat(reverse: true);
  }

  void playAudio() async {
    await audioPlayer.setAsset('assets/sound/page16.mp3');
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
    _animationController.dispose();
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
                  'assets/hlm_16.jpg',
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
                            const PageSevennTeen(),
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
                top: 230,
                left: 180,
                child: Image.asset(
                  'assets/animation/duduk.png',
                  width: 400,
                  height: 400,
                ),
              ),
              Positioned(
                top: 200,
                left: 500,
                child: AnimatedBuilder(
                  animation: _animation,
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
                top: 200,
                left: 500,
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
