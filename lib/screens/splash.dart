import 'package:bmusic/notifier/playing.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget{
    final String message;

    const Splash({super.key, this.message = "getting song list, Please wait"});

    @override
    State<StatefulWidget> createState() => __SplashState();
}

class __SplashState extends State<Splash>{
    @override
    Widget build(BuildContext context) {
        PlayingStateNotifier playingNotifier = context.watch<PlayingStateNotifier>();
        playingNotifier.onLoadingfinished = (){
          Navigator.pushReplacementNamed(context, "/search");
        };
        
        return Scaffold(
          body: Container(color: Colors.white,
              child: Center(child: Image.asset("files/ic_splash.png")),
          ),
          bottomNavigationBar: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinKitChasingDots(
                        itemBuilder: (BuildContext buildContext, int index){
                            return DecoratedBox(
                                decoration: BoxDecoration(
                                    color: index.isEven ? Colors.blue : Colors.redAccent,
                                    shape: BoxShape.circle,
                                    boxShadow: const [BoxShadow(blurRadius: 3)])); },
                    ),
                    const SizedBox(height: 20,),
                    Text(widget.message, style: const TextStyle(color: Colors.black54, fontSize: 15.0, fontWeight: FontWeight.bold),)],
                ),
        );
    }
}