import 'package:bmusic/blocs/auth/auth_bloc.dart';
import 'package:bmusic/blocs/library_bloc.dart';
import 'package:bmusic/blocs/playing_bloc.dart';
import 'package:bmusic/blocs/settings_bloc.dart';
import 'package:bmusic/blocs/states/settings_state.dart';
import 'package:bmusic/pages/test.dart';
import 'package:bmusic/screens/home.dart';
import 'package:bmusic/screens/playlist.dart';
import 'package:bmusic/screens/search.dart';
import 'package:bmusic/screens/splash.dart';
import 'package:bmusic/screens/selection.dart';
import 'package:bmusic/test.dart';
import 'package:bmusic/utils/bloc_observer.dart';
import 'package:bmusic/utils/theme.dart';
import 'package:bmusic/utils/util.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
    await dotenv.load(fileName: ".env");
    await Supabase.initialize(
        url: dotenv.env['SUPABASE_URL'] ?? "",
        anonKey: dotenv.env['SUPABASE_KEY'] ?? ""
    );
    WidgetsFlutterBinding.ensureInitialized();
    HydratedBloc.storage = await HydratedStorage.build(storageDirectory: HydratedStorageDirectory((await getTemporaryDirectory()).path));
    Bloc.observer = const SimpleBlocObserver();
    
    runApp(BlocProvider(create: (context) => SettingsCubit(), child: const BMusic()));
}

class BMusic extends StatelessWidget{
    const BMusic({super.key});

    @override
    Widget build(BuildContext context) {
        TextTheme textTheme = createTextTheme(context, "Noto Sans Mono", "Acme");
        MaterialTheme theme = MaterialTheme(textTheme);

        return BlocBuilder<SettingsCubit, SettingsState>(builder: (context, state){
            return MultiBlocProvider(
                providers: [
                    BlocProvider(create: (context) => LibraryBloc()),
                    BlocProvider(create: (context) => PlayingBloc()),
                    BlocProvider(create: (context)=> AuthBloc()),
                ],
                child: MaterialApp(debugShowCheckedModeBanner: false,
                    theme: theme.light(), darkTheme: theme.dark(),
                    themeMode: state.themeMode,
                    initialRoute: Splash.routeName,
                    routes: {
                        Home.routeName: (context) => Home(),
                        Search.routeName: (context) => Search(),
                        Playlist.routeName: (context) => Playlist(),
                        Splash.routeName: (context)=> Splash(),
                        Selection.routeName: (context) => Selection(),
                        "test": (context) => const CompleteReorderableList(),
                        "bobby": (context) => SmoothTabBarAppBar()
                    })
            );
        });
    }
}