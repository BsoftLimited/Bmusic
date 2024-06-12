import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:bmusic/pages/home/downloads.dart';
import 'package:bmusic/pages/home/online.dart';
import 'package:bmusic/pages/home/user.dart';
import 'package:bmusic/pages/home/settings.dart';
import 'package:bmusic/notifier/google.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => __HomeState();
}

class __HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final __pageController = PageController(initialPage: 0);
  final __controller = NotchBottomBarController(index: 0);

  @override
  void dispose() {
    __pageController.dispose();
    super.dispose();
  }

  BottomBarItem barItem(BuildContext context, IconData icon){
      final ColorScheme theme = Theme.of(context).colorScheme;

      return BottomBarItem(
          inActiveItem: Icon(icon, color: theme.onSurfaceVariant),
          activeItem: Icon(icon, color: theme.primary),
          itemLabel: '',
      );
  }

  List<BottomBarItem> initBarItems(BuildContext context) =>[
      barItem(context, Icons.person_2_outlined),
      barItem(context, Icons.cloud_outlined),
      barItem(context, Icons.cloud_download_outlined),
      barItem(context, Icons.settings_outlined),
  ];

  List<Widget> pages = const [ User(), Online(), Downloads(), Settings() ];

  @override
  Widget build(BuildContext context) {
      final ColorScheme theme = Theme.of(context).colorScheme;
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => GoogleNotifier())
        ],
        child: Scaffold( extendBody: true,
            appBar: AppBar(backgroundColor: theme.surface, elevation: 0,
                title: Text('Home', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: theme.primary),),
                leading: Icon(Icons.home_outlined, color: theme.primary, size: 34,),
                actions: [ IconButton(icon: const Icon(Icons.queue_music_outlined), onPressed: () {  },) ],
                leadingWidth: 30,),
            body: PageView( controller: __pageController, physics: const NeverScrollableScrollPhysics(), children: pages),
            bottomNavigationBar: AnimatedNotchBottomBar(color: Colors.white, showLabel: false,
              notchBottomBarController: __controller,
              onTap: (index) => __pageController.jumpToPage(index),
              bottomBarItems: initBarItems(context), kIconSize: 22, kBottomRadius: 20,
            ),
        ),
      );
  }
}
