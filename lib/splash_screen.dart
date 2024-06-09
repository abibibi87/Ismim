import 'package:flutter/material.dart';
import 'package:ismim/homepage.dart';
import 'package:just_audio/just_audio.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  Animation<double>? _animation;
  late AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    _animationController.forward();

    audioPlayer = AudioPlayer();
    audioPlayer
        .setAsset('assets/sound/paperplay.mp3')
        .then((_) => audioPlayer.play())
        .then((result) {
      Future.delayed(const Duration(seconds: 3), () {
        audioPlayer.stop();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      });
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
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: FadeTransition(
        opacity: _animation!,
        child: Center(
          child: Container(
            width: width * 0.3,
            height: height * 0.3,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Logo_color.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
