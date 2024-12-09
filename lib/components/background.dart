import 'dart:ui';

import 'package:bmusic/blocs/settings_bloc.dart';
import 'package:bmusic/blocs/states/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Background extends StatelessWidget{
  final Widget child;

  const Background({super.key, required this.child });

  @override
  Widget build(BuildContext context) {

      return BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
              DecorationImage? image = state.background == null ? null : DecorationImage(image: MemoryImage(state.background!), fit: BoxFit.fitHeight);
              return DecoratedBox(decoration: BoxDecoration(image: image),
                  child: Stack(fit: StackFit.expand,
                    children: [
                        Container(decoration: BoxDecoration(color: Colors.black.withOpacity(0.3))),
                        BackdropFilter( filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0), child: child),
                    ]
              ));
          }
      ); 
  }
}