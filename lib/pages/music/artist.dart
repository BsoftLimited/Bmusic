import 'package:bmusic/components/artists_view.dart';
import 'package:bmusic/components/loading.dart';
import 'package:bmusic/notifier/artists.dart';
import 'package:bmusic/notifier/playing.dart';
import 'package:bmusic/notifier/widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Artists extends StatefulWidget{
    const Artists({super.key});

    @override
    State<Artists> createState() => _ArtistsState();
}

class _ArtistsState extends State<Artists> {
  late PlayingStateNotifier playingStateNotifier ;

  @override
  Widget build(BuildContext context) {
      playingStateNotifier = context.watch<PlayingStateNotifier>();

      return NotifierWidget<ArtistNotifier>(
          notifier: ArtistNotifier(songNotifier: playingStateNotifier),
          builder: (buildContext, artistNotifier, widget){
              if(artistNotifier.loading){
                  return const Loading(message: "sorting songs according to Artists",);
              }else{
                  return ListView.separated(itemCount: artistNotifier.artistNames.length, padding: const EdgeInsets.only(bottom: 140),
                      itemBuilder: (BuildContext context, int index) => ArtistView(index:index),
                      separatorBuilder: (BuildContext context, int index) => const Divider()
                  );
              }
        }); 
    }
}