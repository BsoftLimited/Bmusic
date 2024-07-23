import 'package:bmusic/notifier/playing.dart';
import 'package:bmusic/notifier/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotifierWidget<T extends ChangeNotifier> extends StatefulWidget{
    final Widget Function(BuildContext, T, Widget?) builder;
    final T notifier;
    final Widget? child;
    final Function(T notifier)? onNotifierReady;
    final bool autoDispoise;

    const NotifierWidget({ super.key, required this.builder, required this.notifier, this.child, this.onNotifierReady, this.autoDispoise = true });
    
    @override
    State<StatefulWidget> createState() => __NotifierWidgetState<T>();
}

class __NotifierWidgetState<T extends ChangeNotifier> extends State<NotifierWidget<T>>{
    late T notifier;

    @override
    void initState() {
        notifier = widget.notifier;
        if(widget.onNotifierReady != null){
            widget.onNotifierReady!(notifier);
        }
        super.initState();
    }

    @override
    Widget build(BuildContext context) {
        return ChangeNotifierProvider<T>.value(value: notifier, child: Consumer<T>(builder: widget.builder, child: widget.child,));
    }

    @override
    void dispose() {
        if(widget.autoDispoise){
            notifier.dispose();
        }
        super.dispose();
    }
}

class AppNotifierWidget extends StatefulWidget{
    final Widget Function(BuildContext, PlayingStateNotifier, UserNoitifier, Widget?) builder;
    final PlayingStateNotifier playingStateNotifier;
    final UserNoitifier userNoitifier;
    final Widget? child;
    final Function(PlayingStateNotifier, UserNoitifier)? onNotifierReady;
    final bool autoDispoise;

    const AppNotifierWidget({ super.key, required this.playingStateNotifier, required this.userNoitifier, required this.builder, this.child, this.onNotifierReady, this.autoDispoise = true });
    
    @override
    State<StatefulWidget> createState() => __AppNotifierWidgetState();
}

class __AppNotifierWidgetState extends State<AppNotifierWidget>{
    late PlayingStateNotifier playingStateNotifier;
    late UserNoitifier userNoitifier;

    @override
    void initState() {
        playingStateNotifier = widget.playingStateNotifier;
        userNoitifier = widget.userNoitifier;
        if(widget.onNotifierReady != null){
            widget.onNotifierReady!(playingStateNotifier,  userNoitifier);
        }
        super.initState();
    }

    @override
    Widget build(BuildContext context) {
        return MultiProvider(
            providers: [
                ChangeNotifierProvider(create: (BuildContext context) => playingStateNotifier),
                ChangeNotifierProvider(create: (BuildContext context) => userNoitifier),
            ],
            child: Consumer2(builder: widget.builder, child: widget.child,));
    }

    @override
    void dispose() {
        if(widget.autoDispoise){
            playingStateNotifier.dispose();
            userNoitifier.dispose();
        }
        super.dispose();
    }
} 