import 'package:bmusic/components/song_model.dart';
import 'package:bmusic/notifier/playing.dart';
import 'package:bmusic/pages/music/common.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Songs extends StatefulWidget{
    const Songs({super.key});

    @override
    State<StatefulWidget> createState() => __SongsState();
}

class __SongsState extends State<Songs>{
   
    @override
    Widget build(BuildContext context) {
        PlayingStateNotifier playingStateNotifier = context.watch<PlayingStateNotifier>();

        return CustomScrollView(
            slivers: [
                showSliverAppBar(context: context, screenTitle: "Songs"),

                SliverList.separated(itemCount: playingStateNotifier.songs.length,
                    itemBuilder: (BuildContext context, int index) => SongView(songModel: playingStateNotifier.songs[index],),
                    separatorBuilder: (BuildContext context, int index) => const Divider()
                )
            ],
        );
    }
}

/*
return ListView.separated(itemCount: playingStateNotifier.songs.length,
            itemBuilder:(context, index) =>  
            separatorBuilder: (context, index) =>  const Divider());
*/