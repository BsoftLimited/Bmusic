import 'dart:async';
import 'dart:math';

import 'package:bmusic/notifier/google.dart';
import 'package:bmusic/components/loading.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class Online extends StatefulWidget{
  const Online({super.key});

  @override
  State<StatefulWidget> createState() => __OnlineState();
}

class __OnlineState extends State<Online>{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey = GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10; // number that changes when refreshed
  Stream<int> counterStream = Stream<int>.periodic(const Duration(seconds: 3), (x) => refreshNum);

  Future<void> _handleRefresh() {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 3), () {
      completer.complete();
    });

    setState(() {
      refreshNum = Random().nextInt(100);
    });

    return completer.future.then<void>((_) {
      ScaffoldMessenger.of(_scaffoldKey.currentState!.context).showSnackBar(
        SnackBar( content: const Text('Refresh complete'),
          action: SnackBarAction(label: 'RETRY', onPressed: () => _refreshIndicatorKey.currentState!.show()),
        ),
      );
    });
  }
  
  @override
  Widget build(BuildContext context) {
    GoogleNotifier googleNotifier = context.watch<GoogleNotifier>();

    Widget init(){
      if(googleNotifier.isLoading){
        return const Loading(message: "Getting Files from account",);
      }else if(!googleNotifier.isAuthorized){
        return Container(alignment: Alignment.center, child: FilledButton(child: const Text("Signin"), onPressed: ()=> googleNotifier.signIn(),));
      }

      return Column(children: [
        FilledButton(child: const Text("Sign out"), onPressed: ()=> googleNotifier.signOut()),
        Expanded(
          child: ListView.builder(itemCount: googleNotifier.files.length, itemBuilder:(context, index) => Text(googleNotifier.files[index].name!)),
        )
      ],);
    }

    return LiquidPullToRefresh( key: _refreshIndicatorKey, onRefresh: _handleRefresh, showChildOpacityTransition: false,
      child: init());
  }
}