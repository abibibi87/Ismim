import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ismim/page13.dart';
import 'package:ismim/homepage.dart';

class PageTwelve extends StatefulWidget {
  const PageTwelve({super.key});

  @override
  _PageTwelveState createState() => _PageTwelveState();
}

class _PageTwelveState extends State<PageTwelve>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late AudioPlayer audioPlayer;
  bool isPlaying = false;
  late AnimationController _awan1Controller;
  late Animation<Offset> _awan1Animation;
  late AnimationController _awan4Controller;
  late Animation<Offset> _awan4Animation;

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

    _awan1Controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat(reverse: true);

    _awan1Animation = Tween<Offset>(
      begin: const Offset(-0.5, 0.0),
      end: const Offset(0.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _awan1Controller,
      curve: Curves.easeInOut,
    ));

    _awan4Controller = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat(reverse: true);

    _awan4Animation = Tween<Offset>(
      begin: const Offset(0.5, 0.0),
      end: const Offset(-0.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _awan4Controller,
      curve: Curves.easeInOut,
    ));
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

  void playAudio() async {
    await audioPlayer.setAsset('assets/sound/page12.mp3');
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
    _awan1Controller.dispose();
    _awan4Controller.dispose();
    audioPlayer.dispose();
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
                'assets/hlm_12.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                icon: Image.asset('assets/tombol/button_volume.png',
                    width: width * 0.1),
                onPressed: () {
                  if (isPlaying) {
                    stopAudio();
                  } else {
                    playAudio();
                  }
                },
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: Image.asset('assets/tombol/button_home.png',
                    width: width * 0.1),
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
              ),
            ),
            Positioned(
              top: -85,
              left: 100,
              child: SlideTransition(
                position: _awan1Animation,
                child: Image.asset(
                  'assets/animation/awan1.png',
                  width: 300,
                  height: 300,
                ),
              ),
            ),
            Positioned(
              top: -60,
              left: 1100,
              child: SlideTransition(
                position: _awan4Animation,
                child: Image.asset(
                  'assets/animation/awan4.png',
                  width: 300,
                  height: 300,
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
                          const PageThirTeen(),
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
                icon: Image.asset('assets/tombol/button_next.png',
                    width: width * 0.1),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Image.asset('assets/tombol/button_back.png',
                    width: width * 0.1),
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
