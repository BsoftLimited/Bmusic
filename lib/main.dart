import 'package:bmusic/notifier/playing.dart';
import 'package:bmusic/notifier/settings.dart';
import 'package:bmusic/notifier/theme.dart';
import 'package:bmusic/notifier/user.dart';
import 'package:bmusic/screens/home.dart';
import 'package:bmusic/screens/login.dart';
import 'package:bmusic/screens/music.dart';
import 'package:bmusic/screens/search.dart';
import 'package:bmusic/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp( const BMusic());

class BMusic extends StatelessWidget {
  const BMusic({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeNotifier()),
          ChangeNotifierProvider(create: (context) => PlayingStateNotifier()),
          ChangeNotifierProvider(create: (context) => SettingsNotifier()),
          ChangeNotifierProvider(create: (context) => UserNoitifier())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: true,
          initialRoute: "/",
          routes: {
            "/": (_) => const Splash(),
            "/music": (_) =>  const Music(),
            "/home": (_) => const Home(),
            "/login": (_) => const Login(),
            "/search": (_) => const Search(),
          }),
    );   
  }
}