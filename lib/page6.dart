import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ismim/page7.dart';
import 'package:ismim/homepage.dart';

class PageSix extends StatefulWidget {
  const PageSix({super.key});

  @override
  _PageSixState createState() => _PageSixState();
}

class _PageSixState extends State<PageSix>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  AudioPlayer? audioPlayer;
  bool isPlaying = false;
  late AnimationController _buroqController;
  late AnimationController _awanController;
  late Animation<Offset> _buroqAnimation;
  late Animation<Offset> _awanAnimation;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    Future.delayed(const Duration(milliseconds: 2500), () {
      playAudio();
    });

    _buroqController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..forward();

    _awanController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _buroqAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1.0, -1.0),
    ).animate(CurvedAnimation(
      parent: _buroqController,
      curve: Curves.easeInOut,
    ));

    _awanAnimation = Tween<Offset>(
      begin: const Offset(-0.1, 0.0),
      end: const Offset(0.1, 0.0),
    ).animate(CurvedAnimation(
      parent: _awanController,
      curve: Curves.easeInOut,
    ));

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
    await audioPlayer!.setAsset('assets/sound/page6.mp3');
    audioPlayer!.play();
    setState(() {
      isPlaying = true;
    });
  }

  void stopAudio() async {
    await audioPlayer!.stop();
    setState(() {
      isPlaying = false;
    });
  }

  @override
  void dispose() {
    _buroqController.dispose();
    _awanController.dispose();
    audioPlayer?.dispose();
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
                'assets/hlm_6.jpg',
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
              top: 65,
              left: 750,
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
              top: -80,
              left: 250,
              child: Image.asset(
                'assets/text/12.png',
                width: 600,
                height: 600,
              ),
            ),
            Positioned(
              top: 150,
              left: 500,
              child: SlideTransition(
                position: _awanAnimation,
                child: Image.asset(
                  'assets/animation/awan1.png',
                  width: 1200,
                  height: 1200,
                ),
              ),
            ),
            Positioned(
              top: 150,
              left: 20,
              child: SlideTransition(
                position: _awanAnimation,
                child: Image.asset(
                  'assets/animation/awan4.png',
                  width: 1200,
                  height: 1200,
                ),
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
                          const PageSeven(),
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
