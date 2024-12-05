import 'package:bmusic/components/album_view.dart';
import 'package:bmusic/components/loading.dart';
import 'package:bmusic/notifier/albums.dart';
import 'package:bmusic/notifier/playing.dart';
import 'package:bmusic/notifier/widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Albums extends StatefulWidget{

  const Albums({super.key});

  @override
  State<Albums> createState() => _AlbumsState();
}

class _AlbumsState extends State<Albums> {
  late PlayingStateNotifier playingStateNotifier;

  @override
  Widget build(BuildContext context) {
      playingStateNotifier = context.watch<PlayingStateNotifier>();

      return NotifierWidget<AlbumsNotifier>(
          notifier: AlbumsNotifier(songNotifier: playingStateNotifier),
          builder: (buildContext, albumsNotifier, widget){
              if(albumsNotifier.loading){
                  return const Loading(message: "sorting songs according to Albums",);
              }else{
                  return ListView.separated(itemCount: albumsNotifier.albumsTitles.length, padding: const EdgeInsets.only(bottom: 140),
                      itemBuilder: (BuildContext context, int index) => AlbumView(index:index),
                      separatorBuilder: (BuildContext context, int index) => const Divider()
                  );
          }});
      }
}

/*
SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 4.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.teal[100 * (index % 9)],
                  child: Text('Grid Item $index'),
                );
              },
              childCount: 20,
            ),
          ),
 */

//return Text("${albumsNotifier.albumsTitles[index]} - ${ albumsNotifier.songs(albumsNotifier.albumsTitles[index]).length }");