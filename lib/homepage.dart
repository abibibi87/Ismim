import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ismim/page1.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AudioPlayer audioPlayer;
  bool isPlaying = false;
  late AnimationController _controller1;
  late Animation<double> _animation1;
  late AnimationController _controller2;
  late Animation<double> _animation2;

  @override
  void initState() {
    super.initState();

    // Set the app to full screen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    audioPlayer = AudioPlayer();
    playAudio();

    _controller1 = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    _animation1 = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller1, curve: Curves.easeInOut),
    );

    _controller2 = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    _animation2 = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller2, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    audioPlayer.dispose();
    // Restore the system UI overlays
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void playAudio() async {
    await audioPlayer.setAsset('assets/sound/home.mp3');
    audioPlayer.play();
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
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    double scaleFactor = (width / 1340 + height / 800) / 2;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              'assets/Home1.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 10 * scaleFactor,
            left: 10 * scaleFactor,
            child: IconButton(
              icon: Image.asset('assets/tombol/button_exit.png'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      backgroundColor: Colors.transparent,
                      child: Stack(
                        children: <Widget>[
                          SizedBox(
                            width: width * 0.8,
                            height: height * 0.8,
                            child: Image.asset('assets/allertt.png'),
                          ),
                          Positioned(
                            bottom: height * 0.1,
                            left: width * 0.25,
                            child: IconButton(
                              icon: Image.asset('assets/tombol/button_iya.png'),
                              onPressed: () {
                                SystemNavigator.pop();
                              },
                              iconSize: width * 0.15,
                            ),
                          ),
                          Positioned(
                            bottom: height * 0.1,
                            right: width * 0.25,
                            child: IconButton(
                              icon:
                                  Image.asset('assets/tombol/button_tidak.png'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              iconSize: width * 0.15,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              iconSize: width * 0.075,
            ),
          ),
          Positioned(
            top: 10 * scaleFactor,
            left: 100 * scaleFactor,
            child: IconButton(
              icon: Image.asset(isPlaying
                  ? 'assets/tombol/button_volume.png'
                  : 'assets/tombol/button_mute.png'),
              onPressed: () {
                if (isPlaying) {
                  stopAudio();
                } else {
                  playAudio();
                }
              },
              iconSize: width * 0.075,
            ),
          ),
          Positioned(
            top: 10 * scaleFactor,
            right: 10 * scaleFactor,
            child: IconButton(
              icon: Image.asset('assets/tombol/button_about.png'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      backgroundColor: Colors.transparent,
                      child: Stack(
                        children: <Widget>[
                          SizedBox(
                            width: width * 0.8,
                            height: height * 0.8,
                            child: Image.asset('assets/about.png'),
                          ),
                          Positioned(
                            bottom: height * 0.1,
                            left: width * 0.25,
                            child: IconButton(
                              icon: Image.asset('assets/tombol/sip.png'),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      backgroundColor: Colors.transparent,
                                      child: Stack(
                                        children: <Widget>[
                                          SizedBox(
                                            width: width * 0.8,
                                            height: height * 0.8,
                                            child: Image.asset(
                                                'assets/sinopsis.png'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              iconSize: width * 0.15,
                            ),
                          ),
                          Positioned(
                            bottom: height * 0.1,
                            right: width * 0.25,
                            child: IconButton(
                              icon: Image.asset('assets/tombol/profil.png'),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      backgroundColor: Colors.transparent,
                                      child: Stack(
                                        children: <Widget>[
                                          SizedBox(
                                            width: width * 0.8,
                                            height: height * 0.8,
                                            child: Image.asset(
                                                'assets/ttgprofil.png'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              iconSize: width * 0.15,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              iconSize: width * 0.075,
            ),
          ),
          Stack(
            children: <Widget>[
              Positioned(
                top: -120 * scaleFactor,
                left: 550 * scaleFactor,
                child: ScaleTransition(
                  scale: _animation1,
                  child: Image.asset(
                    'assets/text/Isra.png',
                    width: 450 * scaleFactor,
                    height: 450 * scaleFactor,
                  ),
                ),
              ),
              Positioned(
                top: -150 * scaleFactor,
                left: 400 * scaleFactor,
                child: ScaleTransition(
                  scale: _animation2,
                  child: Image.asset(
                    'assets/text/TulisNabi.png',
                    width: 750 * scaleFactor,
                    height: 750 * scaleFactor,
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0, 0.5),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: FractionallySizedBox(
                    widthFactor: 0.2,
                    child: InkWell(
                      onTap: () {
                        stopAudio();
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const PageOne(),
                            transitionDuration: const Duration(seconds: 3),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
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
                        );
                      },
                      child: Image.asset(
                        'assets/tombol/button_play.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ],
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
