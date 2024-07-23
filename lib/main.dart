import 'package:bmusic/notifier/playing.dart';
import 'package:bmusic/notifier/settings.dart';
import 'package:bmusic/notifier/user.dart';
import 'package:bmusic/notifier/widget.dart';
import 'package:bmusic/screens/home.dart';
import 'package:bmusic/screens/music.dart';
import 'package:bmusic/screens/search.dart';
import 'package:bmusic/screens/splash.dart';
import 'package:bmusic/utils/theme.dart';
import 'package:bmusic/utils/util.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const App());

class App extends StatelessWidget{
    const App({super.key});

    @override
    Widget build(BuildContext context) {
        return NotifierWidget<SettingsNotifier>(notifier: SettingsNotifier(),
            builder: (context, settingsNotifier, child){
                if(settingsNotifier.initialized){
                    return const BMusic();
                }
                return const Launcher();
            }
        );
    }
}

class BMusic extends StatelessWidget {
    const BMusic({super.key});

    @override
    Widget build(BuildContext context) {
        SettingsNotifier settingsNotifier = context.watch<SettingsNotifier>();

        return AppNotifierWidget(playingStateNotifier: PlayingStateNotifier(settingsNotifier: settingsNotifier), userNoitifier: UserNoitifier(),
            builder: (context, playingNotifier, userNotifier, child){
                TextTheme textTheme = createTextTheme(context, "Noto Sans Mono", "Acme");
                MaterialTheme theme = MaterialTheme(textTheme);
                
                return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    theme: theme.light(),
                    darkTheme: theme.dark(),
                    themeMode: settingsNotifier.themeModeValue,
                    initialRoute: "/",
                    routes: {
                        "/music": (_) =>  const Music(),
                        "/": (_) => const Home(),
                        "/search": (_) => const Search(),       
                });   
            });
    }
}