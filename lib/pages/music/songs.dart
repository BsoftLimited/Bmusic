import 'dart:developer';
import 'dart:ui';

import 'package:bmusic/components/song_model.dart';
import 'package:bmusic/notifier/playing.dart';
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

        return ListView.separated(itemCount: playingStateNotifier.songs.length,
            itemBuilder:(context, index) =>  SongView(songModel: playingStateNotifier.songs[index],),
            separatorBuilder: (context, index) =>  const Divider());
    }
}