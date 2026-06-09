import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:bmusic/blocs/playing_bloc.dart';
import 'package:bmusic/blocs/settings_bloc.dart';
import 'package:bmusic/blocs/states/settings_state.dart';
import 'package:bmusic/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import "package:lottie/lottie.dart";

import '../blocs/library_bloc.dart';

class Splash extends StatefulWidget{
    static const String routeName = "splash";

    const Splash({super.key});

    @override
    State<StatefulWidget> createState() => __SplashState();
}

class __SplashState extends State<Splash> with AfterLayoutMixin{

    @override
    FutureOr<void> afterFirstLayout(BuildContext context) {
        final SettingsCubit settingsCubit = context.read<SettingsCubit>();
        settingsCubit.initialize((){
            context.read<LibraryBloc>().init(settingsCubit.state.songs);
            context.read<PlayingBloc>().init(settingsCubit.state.songs);

            Navigator.popAndPushNamed(context, Home.routeName);
        });
    }
  
    @override
    Widget build(BuildContext context) {
        ColorScheme theme = Theme.of(context).colorScheme;

        return Scaffold(
            body: SafeArea(
              child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,children: [
                  //Expanded(child: Lottie.asset("files/animations/splash.lottie")),
                  Expanded(child: Container()),
                  SpinKitChasingDots(
                      itemBuilder: (BuildContext buildContext, int index){
                          return DecoratedBox(
                              decoration: BoxDecoration(
                                  color: index.isEven ? theme.primary : theme.secondary,
                                  shape: BoxShape.circle,
                                  boxShadow: const [BoxShadow(blurRadius: 3)])); },
                  ),
                  const SizedBox(height: 20,),
                  BlocBuilder<SettingsCubit, SettingsState>(
                      builder: (context, state) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Text(state.message, textAlign: TextAlign.center, style: TextStyle(color: theme.onSurface, fontSize: 15.0, fontWeight: FontWeight.bold),),
                          );
                      }
                  )
              ],
                            ),
            ),
        );
    }
}