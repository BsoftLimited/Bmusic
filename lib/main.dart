import 'package:bmusic/notifier/playing.dart';
import 'package:bmusic/notifier/settings.dart';
import 'package:bmusic/notifier/user.dart';
import 'package:bmusic/notifier/widget.dart';
import 'package:bmusic/screens/home.dart';
import 'package:bmusic/screens/login.dart';
import 'package:bmusic/screens/music.dart';
import 'package:bmusic/screens/search.dart';
import 'package:bmusic/screens/splash.dart';
import 'package:bmusic/test.dart';
import 'package:bmusic/utils/theme.dart';
import 'package:bmusic/utils/util.dart';

import 'package:flutter/material.dart';

void main() => runApp(const BMusic());

class BMusic extends StatefulWidget {
    const BMusic({super.key});

    @override
    State<BMusic> createState() => __BMusicState();
}

class __BMusicState extends State<BMusic> {
    late SettingsNotifier settingsNotifier;

    @override
    Widget build(BuildContext context) {
        return AppNotifierWidget(playingStateNotifier: PlayingStateNotifier(), settingsNotifier: SettingsNotifier(), userNoitifier: UserNoitifier(),
            builder: (context, playingNotifier, settingsNotifier, userNotifier, child){
                TextTheme textTheme = createTextTheme(context, "Noto Sans Mono", "Acme");
                MaterialTheme theme = MaterialTheme(textTheme);
                
                return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    theme: theme.light(),
                    darkTheme: theme.dark(),
                    themeMode: settingsNotifier.themeModeValue,
                    initialRoute: "/splash",
                    routes: {
                        "/splash": (_) => const Splash(),
                        "/music": (_) =>  const Music(),
                        "/": (_) => const Home(),
                        "/login": (_) => const Login(),
                        "/search": (_) => const Search(),       
                });   
            });
    }
}