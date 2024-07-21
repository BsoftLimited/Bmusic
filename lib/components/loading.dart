import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget{
    final String message;

    const Loading({super.key, this.message = "Loading, Please wait"});

    @override
    State<StatefulWidget> createState() => LoadingState();
}

class LoadingState extends State<Loading> {
    @override
    Widget build(BuildContext context) {
        return Container(
            color: Colors.white,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SpinKitChasingDots(
                      itemBuilder: (BuildContext buildContext, int index){
                          return DecoratedBox(
                              decoration: BoxDecoration(
                                  color: index.isEven ? Colors.blue : Colors.redAccent,
                                  shape: BoxShape.circle,
                                  boxShadow: const [BoxShadow(blurRadius: 3)])); },
                      //controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))
                  ),
                  const SizedBox(height: 20,),
                  Text(widget.message, style: const TextStyle(color: Colors.black54, fontSize: 15.0, fontWeight: FontWeight.bold),)],
              ),),
        );
    }
}