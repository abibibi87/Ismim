import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ismim/page11.dart';
import 'package:ismim/homepage.dart';
import 'dart:async';

class PageTen extends StatefulWidget {
  const PageTen({super.key});

  @override
  _PageTenState createState() => _PageTenState();
}

class _PageTenState extends State<PageTen>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  late AudioPlayer audioPlayer;
  bool isPlaying = false;
  late AnimationController _controller;
  late Animation<double> _cahayaAnimation;
  late Animation<double> _buroqAnimation;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    _initAnimations();
    _initAudioPlayer();
    Timer(const Duration(milliseconds: 2500), playAudio);

    // Set the application to fullscreen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    // Add observer to reset fullscreen mode when app comes back from background
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Re-set fullscreen mode when the app comes back from the background
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    }
  }

  void _initAudioPlayer() async {
    await audioPlayer.setAsset('assets/sound/page10.mp3');
  }

  void _initAnimations() {
    _cahayaAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(_controller);

    _buroqAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(_controller);
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
    audioPlayer.dispose();
    _controller.dispose();
    // Remove the observer
    WidgetsBinding.instance.removeObserver(this);
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
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}
