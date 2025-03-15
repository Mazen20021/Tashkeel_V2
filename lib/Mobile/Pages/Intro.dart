import 'package:flutter/material.dart';
import 'dart:async';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tashkeelremake/Mobile/Constants/AppColors.dart';
import 'package:tashkeelremake/Mobile/Pages/Login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _scaleAnimation;
  Animation<double>? _fadeOutAnimation;
  final AudioPlayer _audioPlayer = AudioPlayer(); // Initialize AudioPlayer

  @override
  void initState() {
    super.initState();
    _playAudio(); // Start playing audio

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: Curves.elasticOut,
      ),
    )..addListener(() {
        setState(() {});
      });

    _fadeOutAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: const Interval(0.8, 1.0, curve: Curves.easeOut),
      ),
    )..addListener(() {
        setState(() {});
      });

    _animationController!.forward();

    Timer(const Duration(milliseconds: 5200), () {
      _stopAudio(); // Stop audio before navigating
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  void _playAudio() async {
    await _audioPlayer.setSource(AssetSource('audio/intro.mp3')); // Replace with your audio file path
    await _audioPlayer.setReleaseMode(ReleaseMode.release); // Loop the audio
    await _audioPlayer.setPlayerMode(PlayerMode.lowLatency);
    await _audioPlayer.setVolume(0.4);
    await _audioPlayer.resume(); // Start playing
  }

  void _stopAudio() async {
    await _audioPlayer.stop(); // Stop audio playback
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Dispose of the audio player
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeOutAnimation!,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 146, 65, 65), Color.fromARGB(255, 69, 30, 30)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: ScaleTransition(
              scale: _scaleAnimation!,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(blurRadius: 10, color: Colors.black, offset: Offset(0, 8))
                          ],
                          borderRadius: BorderRadius.circular(100),
                          gradient: LinearGradient(
                            colors: [ConstAppColors.cardMainColor, ConstAppColors.cardBackColor],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/image/logo v2.png',
                        width: 200,
                        height: 200,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "اللغة العربية كما يجب أن تكون",
                        style: GoogleFonts.blaka(
                          color: ConstAppColors.mainTextColor,
                          fontSize: 40,
                          shadows: [
                            Shadow(blurRadius: 10, color: Colors.black, offset: Offset(0, 8))
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          Positioned(
                            top: 5,
                            left: 2,
                            child: Opacity(
                              opacity: 0.6,
                              child: LoadingAnimationWidget.staggeredDotsWave(
                                color: Colors.black,
                                size: 40,
                              ),
                            ),
                          ),
                          LoadingAnimationWidget.staggeredDotsWave(
                            color: ConstAppColors.mainTextColor,
                            size: 40,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
