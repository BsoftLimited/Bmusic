import 'package:bmusic/components/song_model.dart';
import 'package:bmusic/notifier/playing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Playlist extends StatelessWidget{
    const Playlist({super.key});

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;
        PlayingStateNotifier playingStateNotifier = context.watch<PlayingStateNotifier>();

        return NestedScrollView(floatHeaderSlivers: true, physics: const NeverScrollableScrollPhysics(),
            headerSliverBuilder: (context, value) => [
                SliverAppBar(backgroundColor: theme.surface, elevation: 0,
                    title: Text("Playlist", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: theme.primary),),
                    leading: Icon(Icons.playlist_play, color: theme.primary, size: 34,),
                    actions: [ IconButton( icon: const Icon(Icons.search), onPressed: ()=>Navigator.pushNamed(context, "/search") ) ],
                    leadingWidth: 30,
                    floating: true, pinned: true,),
            ],
            body: ListView.separated(itemCount: playingStateNotifier.playList.length, padding: const EdgeInsets.all(0),
                itemBuilder: (BuildContext context, int index) => SongView(songModel: playingStateNotifier.playList[index],),
                separatorBuilder: (BuildContext context, int index) => const Divider()
            ),
        );
    }
}