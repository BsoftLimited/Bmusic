import 'package:bmusic/components/loading.dart';
import 'package:bmusic/notifier/albums.dart';
import 'package:bmusic/notifier/playing.dart';
import 'package:bmusic/notifier/widget.dart';
import 'package:bmusic/pages/music/common.dart';
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
              final ColorScheme theme = Theme.of(buildContext).colorScheme;

              if(albumsNotifier.loading){
                  return const Loading(message: "sorting songs according to Albums",);
              }else{
                  return CustomScrollView(
                      slivers: [
                          showSliverAppBar(context: context, screenTitle: "Albums"),


                          
                          GridView.count(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.9,
                              children: List.generate(albumsNotifier.albums.length,(index){
                                  return Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min,
                                        children: [
                                            Icon(Icons.album, size: 140, color: theme.primaryFixedDim),
                                            Text(albumsNotifier.albumsTitles[index], maxLines: 1, style: TextStyle(color: theme.primaryFixedDim, fontSize: 14, fontWeight: FontWeight.w500),),
                                            Text("${albumsNotifier.songs(albumsNotifier.albumsTitles[index]).length} songs", maxLines: 1, style: TextStyle(color: theme.onSurfaceVariant, fontSize: 12),),
                                        ],
                                      );                 
                              }),
                          ),

                          SliverList.separated(itemCount: playingStateNotifier.songs.length,
                              itemBuilder: (BuildContext context, int index) => SongView(songModel: playingStateNotifier.songs[index],),
                              separatorBuilder: (BuildContext context, int index) => const Divider()
                          )
                      ],
                  );
                  /*return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: 
                  );*/
              }
          },
      );
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