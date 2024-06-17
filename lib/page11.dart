import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ismim/page12.dart';
import 'package:ismim/homepage.dart';

class PageEleven extends StatefulWidget {
  const PageEleven({super.key});

  @override
  _PageElevenState createState() => _PageElevenState();
}

class _PageElevenState extends State<PageEleven>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  late AudioPlayer audioPlayer;
  bool isPlaying = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    _controller = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..forward();

    Future.delayed(const Duration(milliseconds: 2500), () {
      playAudio();
    });

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

  void playAudio() async {
    await audioPlayer.setAsset('assets/sound/page11.mp3');
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
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Image.asset(
                'assets/hlm_11.jpg',
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
              top: 120,
              left: -50,
              child: Image.asset(
                'assets/animation/Adam.png',
                width: 500,
                height: 500,
              ),
            ),
            Positioned(
              top: -20,
              left: 900,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset.zero,
                  end: const Offset(-1.0, -1.0),
                ).animate(_controller),
                child: Image.asset(
                  'assets/animation/buroq.png',
                  width: 400,
                  height: 400,
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
                          const PageTwelve(),
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
