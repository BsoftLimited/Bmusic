import 'dart:ui';

import 'package:bmusic/notifier/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Background extends StatelessWidget{
  final Widget child;

  const Background({super.key, required this.child });

  @override
  Widget build(BuildContext context) {
      SettingsNotifier settingsNotifier = context.watch<SettingsNotifier>();

      DecorationImage? initBackground(){
          return DecorationImage(image: settingsNotifier.background.image, fit: BoxFit.fitHeight);
      }

      return DecoratedBox(decoration: BoxDecoration(image: initBackground()),
          child: Stack(fit: StackFit.expand,
            children: [
                Container(decoration: BoxDecoration(color: Colors.black.withOpacity(0.3))),
                BackdropFilter( filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0), child: child),
            ]
      )); 
  }
}