import 'package:bmusic/blocs/playing_bloc.dart';
import 'package:bmusic/blocs/states/playing_state.dart';
import 'package:bmusic/components/song_model.dart';
import 'package:bmusic/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Playlist extends StatelessWidget{
    static const String routeName = "/playlist";

    const Playlist({super.key});

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;

        return NestedScrollView(floatHeaderSlivers: true, physics: const NeverScrollableScrollPhysics(),
            headerSliverBuilder: (context, value) => [
                SliverAppBar(backgroundColor: theme.surface, elevation: 0,
                    title: Text("Playlist", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: theme.primary),),
                    leading: Icon(Icons.playlist_play, color: theme.primary, size: 34,),
                    actions: [ IconButton( icon: const Icon(Icons.search), onPressed: ()=>Navigator.pushNamed(context, Splash.routeName) ) ],
                    leadingWidth: 30,
                    floating: true, pinned: true,),
            ],
            body: BlocBuilder<PlayingBloc, PlayingState>(builder: (context, state) {
                return ListView.separated(itemCount: state.playList.length, padding: const EdgeInsets.all(0),
                    itemBuilder: (BuildContext context, int index) => SongView(songId: state.playList[index],),
                    separatorBuilder: (BuildContext context, int index) => const Divider()
                );
            },),
        );
    }
}