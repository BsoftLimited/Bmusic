import 'package:bmusic/blocs/playing_bloc.dart';
import 'package:bmusic/blocs/settings_bloc.dart';
import 'package:bmusic/blocs/states/settings_state.dart';
import 'package:bmusic/blocs/states/status.dart';
import 'package:bmusic/blocs/user_bloc.dart';
import 'package:bmusic/screens/home.dart';
import 'package:bmusic/screens/not_found.dart';
import 'package:bmusic/screens/playlist.dart';
import 'package:bmusic/screens/search.dart';
import 'package:bmusic/screens/splash.dart';
import 'package:bmusic/utils/bloc_observer.dart';
import 'package:bmusic/utils/theme.dart';
import 'package:bmusic/utils/util.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
    HydratedBloc.storage = await HydratedStorage.build(storageDirectory: await getTemporaryDirectory());
    Bloc.observer = const SimpleBlocObserver();
    
    runApp(BlocProvider(create: (context) => SettingsCubit(), child:  const BMusic()));
}

class BMusic extends StatelessWidget{
    const BMusic({super.key});

    Widget initRoutes(String? path){
        switch (path) {
            case Home.routeName:
                return const Home();
            case Search.routeName:
                return const Search();
            case Playlist.routeName:
                return const Playlist();
            default:
                return const NotFound();
        }
    }

    @override
    Widget build(BuildContext context) {
        TextTheme textTheme = createTextTheme(context, "Noto Sans Mono", "Acme");
        MaterialTheme theme = MaterialTheme(textTheme);

        return BlocBuilder<SettingsCubit, SettingsState>(builder: (context, state){
            return MaterialApp(debugShowCheckedModeBanner: false,
                theme: theme.light(),
                darkTheme: theme.dark(),
                themeMode: state.themeMode,
                initialRoute: Home.routeName,
                onGenerateRoute: (settings) {
                    return MaterialPageRoute(builder: (context) {
                        if(state.status != StateStatus.success){
                            return const Splash();
                        }

                        return MultiBlocProvider(
                            providers: [
                                BlocProvider(create: (context) => PlayingBloc(state)),
                                BlocProvider(create: (context) => UserBloc()),
                            ], 
                            child: initRoutes(settings.name));

                    });
                });
        });
    }
}