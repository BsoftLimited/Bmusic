import 'dart:ui';

import 'package:flutter/material.dart';

class Background extends StatelessWidget{
    final Widget child;

    const Background({super.key, required this.child });

    @override
    Widget build(BuildContext context) {
        DecorationImage image = DecorationImage(image: AssetImage("files/music-vertical.jpg"), fit: BoxFit.fitHeight);

        return DecoratedBox(decoration: BoxDecoration(image: image),
            child: Stack(fit: StackFit.expand,
              children: [
                  Container(decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.4))),
                  BackdropFilter( filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0), child: child),
              ]
        ));
    }
}