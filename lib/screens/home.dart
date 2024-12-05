import 'package:bmusic/components/background.dart';
import 'package:bmusic/pages/home/online.dart';
import 'package:bmusic/notifier/google.dart';
import 'package:bmusic/pages/home/settings.dart';
import 'package:bmusic/pages/music.dart';
import 'package:bubble_navigation_bar/bubble_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => __HomeState();
}


class __HomeState extends State<Home> {
    final __pageController = PageController();
    int __index = 0;
    
    @override
    void initState() {
        super.initState();
        __pageController.addListener(() {
            setState(() {
                __index = __pageController.page!.round();
            });
        });
    }

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;

        return Scaffold(
            body: MultiProvider(
                providers: [
                  ChangeNotifierProvider(create: (context) => GoogleNotifier())
                ],
                child: Background(child: PageView(controller: __pageController, children: const [ Music(), Online(), Settings()]))),
            bottomNavigationBar: BubbleNavigationBar(currentIndex: __index,
                iconSize: 26,
                backgroundColor: theme.surface, selectedItemColor: theme.primary,
                unselectedItemColor: theme.onSurface,
                onIndexChanged: (index) {
                    __pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                },
                items: const [
                    BubbleNavItem(icon: Icon(Icons.speaker), label: 'Player'),
                    BubbleNavItem(icon: Icon(Icons.cloud), label: 'GDrive',),
                    BubbleNavItem(icon: Icon(Icons.settings), label: 'Settings'),
                ]
            ),
        );
    }
}