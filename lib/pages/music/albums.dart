import 'package:bmusic/pages/loading.dart';
import 'package:bmusic/notifier/albums.dart';
import 'package:bmusic/notifier/playing.dart';
import 'package:bmusic/notifier/theme.dart';
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

    return ChangeNotifierProvider<AlbumsNotifier>(
        create: (BuildContext context) => AlbumsNotifier(songNotifier: playingStateNotifier),
        builder: (context, widget){
          AlbumsNotifier albumsNotifier = context.watch<AlbumsNotifier>();
          CustomTheme theme = context.watch<ThemeNotifier>().current;

          if(albumsNotifier.albums.isEmpty && playingStateNotifier.songs.isNotEmpty){
              return const Loading(message: "sorting songs according to Albums",);
          }else{
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.count(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.9,
                    children: List.generate(albumsNotifier.albums.length,(index){
                        return Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min,
                              children: [
                                  Icon(Icons.album, size: 140, color: theme.primaryDark),
                                  Text(albumsNotifier.albumsTitles[index], maxLines: 1, style: TextStyle(color: theme.primaryDark, fontSize: 14, fontWeight: FontWeight.w500),),
                                  Text("${albumsNotifier.songs(albumsNotifier.albumsTitles[index]).length} songs", maxLines: 1, style: TextStyle(color: theme.dark, fontSize: 12),),
                              ],
                            );                 
                    }),
                ),
              );
          }
        },
    );
  }
}

//return Text("${albumsNotifier.albumsTitles[index]} - ${ albumsNotifier.songs(albumsNotifier.albumsTitles[index]).length }");