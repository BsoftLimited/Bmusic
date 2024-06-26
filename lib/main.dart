import 'package:bmusic/notifier/playing.dart';
import 'package:bmusic/notifier/settings.dart';
import 'package:bmusic/notifier/user.dart';
import 'package:bmusic/screens/home.dart';
import 'package:bmusic/screens/login.dart';
import 'package:bmusic/screens/music.dart';
import 'package:bmusic/screens/search.dart';
import 'package:bmusic/screens/splash.dart';
import 'package:bmusic/utils/theme.dart';
import 'package:bmusic/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp( const App());

class App extends StatelessWidget{
    const App({ super.key });

    @override
    Widget build(BuildContext context) {
        return MultiProvider(
            providers: [
                ChangeNotifierProvider(create: (context) => PlayingStateNotifier()),
                ChangeNotifierProvider(create: (context) => SettingsNotifier()),
                ChangeNotifierProvider(create: (context) => UserNoitifier())
            ], child: const BMusic());
    }
}

class BMusic extends StatefulWidget {
    const BMusic({super.key});

    @override
    State<BMusic> createState() => __BMusicState();
}

class __BMusicState extends State<BMusic> {
    late SettingsNotifier settingsNotifier;

    @override
    Widget build(BuildContext context) {
        TextTheme textTheme = createTextTheme(context, "Noto Sans Mono", "Acme");
        
        MaterialTheme theme = MaterialTheme(textTheme);

        settingsNotifier = Provider.of<SettingsNotifier>(context, listen: true);
        return MaterialApp(
            debugShowCheckedModeBanner: true,
            theme: theme.light(),
            darkTheme: theme.dark(),
            themeMode: settingsNotifier.themeModeValue,
            initialRoute: "/",
            routes: {
                "/": (_) => const Splash(),
                "/music": (_) =>  const Music(),
                "/home": (_) => const Home(),
                "/login": (_) => const Login(),
                "/search": (_) => const Search(),       
        });   
    }
}