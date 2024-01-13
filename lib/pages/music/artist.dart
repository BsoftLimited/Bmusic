import 'package:bmusic/pages/loading.dart';
import 'package:bmusic/notifier/artists.dart';
import 'package:bmusic/notifier/playing.dart';
import 'package:bmusic/notifier/theme.dart';
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

    return ChangeNotifierProvider<ArtistNotifier>(
        create: (BuildContext context) => ArtistNotifier(songNotifier: playingStateNotifier),
        builder: (context, widget){
          ArtistNotifier artistNotifier  = context.watch<ArtistNotifier>();
          List<String> artists = artistNotifier.artistNames;

          CustomTheme theme = context.watch<ThemeNotifier>().current;

          if(artistNotifier.artistNames.isEmpty && playingStateNotifier.songs.isNotEmpty){
              return const Loading(message: "sorting songs according to Artists",);
          }else{
              return Padding(
                padding: const EdgeInsets.only(top: 10, right: 3, left: 3),
                child: GridView.count(
                  crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.9,
                  children: List.generate(artists.length,(index){
                          return Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.max,
                            children: [
                                const CircleAvatar( radius: 70, backgroundColor: Colors.white70, backgroundImage: AssetImage("files/artist.png"),),
                                Text(artists[index], maxLines: 1, style: TextStyle(color: theme.primaryDark, fontSize: 13, fontWeight: FontWeight.w500),),
                                Text("${artistNotifier.songs(artists[index]).length} songs", maxLines: 1, style: TextStyle(color: theme.dark, fontSize: 12),),
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