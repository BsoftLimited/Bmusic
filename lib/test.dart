import 'dart:ui';

import 'package:flutter/material.dart';

class BlurContainerDemo extends StatelessWidget {
  const BlurContainerDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BlurryContainer Demo',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: SizedBox.expand(
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Positioned(
                top: 200,
                left: 10,
                child: GradientBall(colors: [Colors.deepOrange, Colors.amber]),
              ),
              const Positioned(
                top: 400,
                right: 10,
                child: GradientBall(
                  size: Size.square(200),
                  colors: [Colors.blue, Colors.purple],
                ),
              ),
              Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0), // Optional: adds rounded corners
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    width: 300.0,
                    height: 400.0,
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(
                      child:  Text(
                        'Glass Blur Effect',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
          ),
        ),
      ), ])
    )));
  }
}

class GradientBall extends StatelessWidget {
  final List<Color> colors;
  final Size size;
  const GradientBall({
    super.key,
    required this.colors,
    this.size = const Size.square(150),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: colors,
        ),
      ),
    );
  }
}