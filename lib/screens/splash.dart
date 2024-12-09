import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:bmusic/blocs/settings_bloc.dart';
import 'package:bmusic/blocs/states/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Splash extends StatefulWidget{
    static const String routeName = "splash";

    const Splash({super.key});

    @override
    State<StatefulWidget> createState() => __SplashState();
}

class __SplashState extends State<Splash> with AfterLayoutMixin{
    late SettingsCubit settingsCubit;

    @override
    FutureOr<void> afterFirstLayout(BuildContext context) {

    }
  
    @override
    Widget build(BuildContext context) {
        settingsCubit = context.read<SettingsCubit>();

        return Scaffold(
            body: Container(color: Colors.white,
              child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,children: [
                  Expanded(child: Image.asset("files/ic_splash.png")),
                  SpinKitChasingDots(
                      itemBuilder: (BuildContext buildContext, int index){
                          return DecoratedBox(
                              decoration: BoxDecoration(
                                  color: index.isEven ? Colors.blue : Colors.redAccent,
                                  shape: BoxShape.circle,
                                  boxShadow: const [BoxShadow(blurRadius: 3)])); },
                  ),
                  const SizedBox(height: 20,),
                  BlocBuilder<SettingsCubit, SettingsState>(
                      builder: (context, state) {
                          return Text(state.message, style: const TextStyle(color: Colors.black54, fontSize: 15.0, fontWeight: FontWeight.bold),);
                      }
                  )
              ],
            ),
          ),
        );
    }
}