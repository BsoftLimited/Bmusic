import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:bmusic/blocs/library_bloc.dart';
import 'package:bmusic/blocs/playing_bloc.dart';
import 'package:bmusic/components/background.dart';
//import 'package:bmusic/pages/online.dart';
//import 'package:bmusic/pages/settings.dart';
import 'package:bmusic/pages/player.dart';
//import 'package:bubble_navigation_bar/bubble_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
    static const String routeName = "home";

    const Home({super.key});

    @override
    State<StatefulWidget> createState() => __HomeState();
}

class __HomeState extends State<Home> with AfterLayoutMixin{
    //final __pageController = PageController();
    //int __index = 0;
    
    /*@override
    void initState() {
        super.initState();
        __pageController.addListener(() {
            setState(() {
                __index = __pageController.page!.round();
            });
        });
    }*/

    @override
    FutureOr<void> afterFirstLayout(BuildContext context) {
        context.read<PlayingBloc>().finishedPlaying = (song){
            context.read<LibraryBloc>().played(song);
        };
    }

    @override
    Widget build(BuildContext context) {
        //final ColorScheme theme = Theme.of(context).colorScheme;

        /*return Scaffold(
            body: Background(child: PageView(controller: __pageController, children: const [ MusicPlayer(), Online(), Settings()])),
            bottomNavigationBar: BubbleNavigationBar(currentIndex: __index,
                iconSize: 26,
                backgroundColor: theme.surface, selectedItemColor: theme.primary,
                unselectedItemColor: theme.onSurface,
                onIndexChanged: (index) {
                    __pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                },
                items: const [
                    BubbleNavItem(icon: Icon(Icons.speaker), label: 'Player'),
                    BubbleNavItem(icon: Icon(Icons.cloud), label: 'Drive',),
                    BubbleNavItem(icon: Icon(Icons.settings), label: 'Settings'),
                ]
            ),
        );*/

        return Scaffold(body: Background(child: MusicPlayer()));
    }
}