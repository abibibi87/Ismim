import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ismim/page16.dart';
import 'package:ismim/homepage.dart';

class PageFiveeTeen extends StatefulWidget {
  const PageFiveeTeen({super.key});

  @override
  _PageFiveeTeenState createState() => _PageFiveeTeenState();
}

class _PageFiveeTeenState extends State<PageFiveeTeen>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  late AudioPlayer audioPlayer;
  bool isPlaying = false;
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<Offset> _awan2Animation;
  late Animation<Offset> _awan3Animation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    audioPlayer = AudioPlayer();
    audioPlayer.setLoopMode(LoopMode.off);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _animation =
        Tween<double>(begin: 0.8, end: 1.2).animate(_animationController);
    _animationController.repeat(reverse: true);
    _awan2Animation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    ));
    _awan3Animation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    ));
    Future.delayed(const Duration(milliseconds: 2500), () {
      playAudio();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ModalRoute.of(context)?.isCurrent ?? false) {
      playAudio();
    } else {
      stopAudio();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (ModalRoute.of(context)?.isCurrent ?? false) {
        playAudio();
      }
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      stopAudio();
    }
  }

  void playAudio() async {
    await audioPlayer.setAsset('assets/sound/page15.mp3');
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
    WidgetsBinding.instance.removeObserver(this);
    _animationController.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              'assets/hlm_15.png',
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
          // Text
          Positioned(
            top: -50,
            left: 100,
            child: Image.asset(
              'assets/text/13.png',
              width: 550,
              height: 550,
            ),
          ),
          Positioned(
            top: 30,
            left: 550,
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
            top: 30,
            left: 550,
            child: Image.asset(
              'assets/animation/nabibg.png',
              width: 550,
              height: 550,
            ),
          ),

          Positioned(
            top: 100,
            left: 300,
            child: SlideTransition(
              position: _awan2Animation,
              child: Image.asset(
                'assets/animation/awan3.png',
                width: 1000,
                height: 1000,
              ),
            ),
          ),

          Positioned(
            top: 100,
            right: 300,
            child: SlideTransition(
              position: _awan3Animation,
              child: Image.asset(
                'assets/animation/awan4.png',
                width: 1000,
                height: 1000,
              ),
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
                        const PageSixxTeen(),
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
