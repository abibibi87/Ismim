import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ismim/homepage.dart';
import 'package:ismim/page2.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/services.dart';

class PageOne extends StatefulWidget {
  const PageOne({super.key});

  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> with SingleTickerProviderStateMixin {
  late AudioPlayer audioPlayer;
  late AudioPlayer audioPlayerPage1;
  bool isPlaying = false;
  bool isPlayingPage1 = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Set the app to full screen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    audioPlayer = AudioPlayer();
    audioPlayerPage1 = AudioPlayer();
    playAudio();
    Future.delayed(const Duration(milliseconds: 2500), () {
      playAudioPage1();
    });

    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.8, end: 1.3).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  void playAudio() async {
    await audioPlayer.setAsset('assets/sound/cerita.mp3');
    audioPlayer.play();
    setState(() {
      isPlaying = true;
    });
  }

  void playAudioPage1() async {
    await audioPlayerPage1.setAsset('assets/sound/page1.mp3');
    audioPlayerPage1.play();
    setState(() {
      isPlayingPage1 = true;
    });
  }

  void stopAudio() async {
    await audioPlayer.stop();
    setState(() {
      isPlaying = false;
    });
  }

  void stopAudioPage1() async {
    await audioPlayerPage1.stop();
    setState(() {
      isPlayingPage1 = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    audioPlayer.dispose();
    audioPlayerPage1.dispose();
    // Restore the system UI overlays
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double referenceWidth = 1600;
    double referenceHeight = 720;

    double widthFactor = screenWidth / referenceWidth;
    double heightFactor = screenHeight / referenceHeight;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Image.asset(
                'assets/hlm_1.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 10 * heightFactor,
              left: 10 * widthFactor,
              child: IconButton(
                icon: Image.asset('assets/tombol/button_volume.png'),
                onPressed: () {
                  if (isPlaying) {
                    stopAudio();
                  } else {
                    playAudio();
                  }
                },
                iconSize: widthFactor * 0.1 * referenceWidth,
              ),
            ),
            Positioned(
              top: 10 * heightFactor,
              right: 10 * widthFactor,
              child: IconButton(
                icon: Image.asset('assets/tombol/button_home.png'),
                onPressed: () {
                  stopAudioPage1();
                  Navigator.push(
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
                  );
                },
                iconSize: widthFactor * 0.1 * referenceWidth,
              ),
            ),
            Positioned(
              bottom: 10 * heightFactor,
              right: 10 * widthFactor,
              child: IconButton(
                onPressed: () {
                  stopAudioPage1();
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const PageTwo(),
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
                iconSize: widthFactor * 0.1 * referenceWidth,
              ),
            ),
            Positioned(
              top: 100 * heightFactor,
              left: -45 * widthFactor,
              child: Lottie.asset('assets/animation/page1.json',
                  width: 800 * widthFactor, height: 800 * heightFactor),
            ),
            Positioned(
              top: -80 * heightFactor,
              left: 200 * widthFactor,
              child: Image.asset(
                'assets/text/1.png',
                width: 500 * widthFactor,
                height: 500 * heightFactor,
              ),
            ),
            Positioned(
              top: 150 * heightFactor,
              left: 800 * widthFactor,
              child: Image.asset(
                'assets/text/2.png',
                width: 500 * widthFactor,
                height: 500 * heightFactor,
              ),
            ),
            Positioned(
              top: 250 * heightFactor,
              left: 500 * widthFactor,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animation.value,
                    child: Image.asset(
                      'assets/animation/cahaya.png',
                      width: 550 * widthFactor,
                      height: 550 * heightFactor,
                    ),
                  );
                },
              ),
            ),
            Positioned(
              top: 250 * heightFactor,
              left: 500 * widthFactor,
              child: Image.asset(
                'assets/animation/nabibg.png',
                width: 550 * widthFactor,
                height: 550 * heightFactor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
