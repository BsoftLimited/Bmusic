import 'package:bmusic/notifier/settings.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class Launcher extends StatelessWidget{
    const Launcher({super.key});

    @override
    Widget build(BuildContext context) {
        return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Splash(),       
        );
    }
}

class Splash extends StatefulWidget{
    const Splash({super.key});

    @override
    State<StatefulWidget> createState() => __SplashState();
}

class __SplashState extends State<Splash>{
    @override
    Widget build(BuildContext context) {
        SettingsNotifier settingsNotifier = context.watch<SettingsNotifier>();
        
        return Scaffold(
          body: Container(
            color: Colors.white,
            child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("files/ic_splash.png"),
                SpinKitChasingDots(
                      itemBuilder: (BuildContext buildContext, int index){
                          return DecoratedBox(
                              decoration: BoxDecoration(
                                  color: index.isEven ? Colors.blue : Colors.redAccent,
                                  shape: BoxShape.circle,
                                  boxShadow: const [BoxShadow(blurRadius: 3)])); },
                  ),
                  const SizedBox(height: 20,),
                  Text(settingsNotifier.message, style: const TextStyle(color: Colors.black54, fontSize: 15.0, fontWeight: FontWeight.bold),)
              ],
            ),
          ),
        );
    }
}