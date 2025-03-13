// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tashkeelremake/Mobile/Constants/AppColors.dart';
import 'package:tashkeelremake/Mobile/Pages/MainPage.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _scaleAnimation;
  Animation<double>? _fadeOutAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5), // Adjust total duration
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
        curve: const Interval(0.8, 1.0, curve: Curves.easeOut), // Fade out in the last 20% of the duration
      ),
    )..addListener(() {
      setState(() {});
    });

    _animationController!.forward();

    // Start the transition to the main page after the entire animation including fade out
    Timer(const Duration(milliseconds: 5000), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    });
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeOutAnimation!,
        child: Container(
          decoration:const BoxDecoration(
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
                  Image.asset(
                    'assets/image/logo.png', // Replace with your logo asset path
                    width: 200, // Adjust the width as needed
                    height: 200, // Adjust the height as needed
                  ),
                  const SizedBox(height: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("اللغة العربية كما يجب أن تكون" , style: GoogleFonts.blaka(color:ConstAppColors.mainTextColor, fontSize: 40),),
                      LoadingAnimationWidget.staggeredDotsWave(
                        color: ConstAppColors.mainTextColor,
                         size: 40,
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
