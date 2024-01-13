import 'package:bmusic/notifier/playing.dart';
import 'package:bmusic/notifier/theme.dart';
import 'package:flutter/material.dart';
import 'package:mini_music_visualizer/mini_music_visualizer.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class SongView extends StatefulWidget{
    final SongModel songModel;

    const SongView({super.key, required this.songModel});

    @override
    State<StatefulWidget> createState() => __SongVeiwState();
}

class __SongVeiwState extends State<SongView>{
    late PlayingStateNotifier playingStateNotifier;
    late CustomTheme theme;

    List<Widget> initDetails(){
        List<Widget> init = [
            Text(widget.songModel.title, maxLines: 1, textAlign: TextAlign.start, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, letterSpacing: 1.2, color: theme.primaryDark,)),
            const SizedBox(height: 5,),
            Text("Artist : ${widget.songModel.artist}", maxLines: 1, textAlign: TextAlign.start, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 1.2, color: theme.dark),),
            const SizedBox(height: 2,),
            Text("Album : ${widget.songModel.album}", maxLines: 1, textAlign: TextAlign.start, style: TextStyle(fontSize: 12, color: theme.dark),) 
        ];
        
        return init;
    }

    List<Widget> initIcons(){
        List<Widget> init = [];

        if(playingStateNotifier.current.id == widget.songModel.id){
            if(playingStateNotifier.playing){
              init.add(MiniMusicVisualizer( color: theme.primary, width: 4, height: 15,)); 
            }else{
              init.add(Icon(Icons.play_arrow_rounded,size: 24, color: theme.secondary,),);
            }
        }
        return init;
    }

    @override
    Widget build(BuildContext context) {
        playingStateNotifier = context.watch<PlayingStateNotifier>(); 
        ThemeNotifier themeNotifier = context.watch<ThemeNotifier>();
        theme = themeNotifier.current;
        
        return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            TextButton( onPressed: (){},
                child: Row(crossAxisAlignment: CrossAxisAlignment.start,  mainAxisAlignment: MainAxisAlignment.start, children: [
                    Padding(padding: const EdgeInsets.only(right: 10, left: 10), child: Icon(Icons.music_note_sharp, size: 28, color: theme.primary,)),
                    Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: initDetails(),)),
                    Padding(padding: const EdgeInsets.only(right: 8, left: 4), child: Column(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.start, children: initIcons(),))
                ]),
            ),
                const Divider()  
        ]);
    }
}