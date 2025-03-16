import 'package:flutter/material.dart';
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
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeOutAnimation;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4800),
    )..forward();

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _fadeOutAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: const Interval(0.8, 1.0, curve: Curves.easeOut)),
    );

    // Delayed navigation
    Future.delayed(const Duration(milliseconds: 5500), () {
      _stopAudio();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _playAudio();
  }

  Future<void> _playAudio() async {
    await _audioPlayer.setSource(AssetSource('audio/intro.mp3'));
    await _audioPlayer.setReleaseMode(ReleaseMode.release);
    await _audioPlayer.setPlayerMode(PlayerMode.lowLatency);
    await _audioPlayer.setVolume(0.4);
    await _audioPlayer.resume();
  }

  Future<void> _stopAudio() async {
    await _audioPlayer.stop();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeOutAnimation,
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
              scale: _scaleAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black, offset: Offset(0, 8))],
                          borderRadius: BorderRadius.circular(100),
                          gradient: LinearGradient(
                            colors: [ConstAppColors.cardMainColor, ConstAppColors.cardBackColor],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                      Image.asset('assets/image/logo v2.png', width: 180, height: 180),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "اللغة العربية كما يجب أن تكون",
                    style: GoogleFonts.blaka(
                      color: ConstAppColors.mainTextColor,
                      fontSize: 40,
                      shadows: [Shadow(blurRadius: 10, color: Colors.black, offset: Offset(0, 8))],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  LoadingAnimationWidget.staggeredDotsWave(
                    color: ConstAppColors.mainTextColor,
                    size: 40,
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
