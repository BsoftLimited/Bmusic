import 'package:bmusic/notifier/playing.dart';
import 'package:flutter/material.dart';
import 'package:mini_music_visualizer/mini_music_visualizer.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class SongView extends StatefulWidget{
    final SongModel? songModel;

    const SongView({super.key, required this.songModel});

    @override
    State<StatefulWidget> createState() => __SongVeiwState();
}

class __SongVeiwState extends State<SongView>{
    late PlayingStateNotifier playingStateNotifier;
    late ColorScheme theme;

    List<Widget> initDetails(){
        String title = widget.songModel != null ? (widget.songModel as SongModel).title : "----";
        String? artist = widget.songModel != null ? (widget.songModel as SongModel).artist : "--";
        String? album = widget.songModel != null ? (widget.songModel as SongModel).album : "--";

        List<Widget> init = [
            Text( title, maxLines: 1, textAlign: TextAlign.start, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 1.2, color: theme.primaryFixedDim,)),
            const SizedBox(height: 5,),
            Text("Artist : $artist", maxLines: 1, textAlign: TextAlign.start, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 1.2, color: Colors.white),),
            const SizedBox(height: 2,),
            Text("Album : $album", maxLines: 1, textAlign: TextAlign.start, style: const TextStyle(fontSize: 12, color: Colors.white),)
        ];
        
        return init;
    }

    List<Widget> initIcons(){
        List<Widget> init = [];

        if(widget.songModel != null && playingStateNotifier.current?.id == widget.songModel?.id){
            init.add(MiniMusicVisualizer( color: theme.primary, width: 4, height: 15, animate: playingStateNotifier.playing));
        }
        return init;
    }

    @override
    Widget build(BuildContext context) {
        playingStateNotifier = context.watch<PlayingStateNotifier>(); 
        theme = Theme.of(context).colorScheme;

        void select()=> playingStateNotifier.current = widget.songModel;
        
        return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            TextButton( onPressed: select,
                child: Row(crossAxisAlignment: CrossAxisAlignment.start,  mainAxisAlignment: MainAxisAlignment.start, children: [
                    Padding(padding: const EdgeInsets.only(right: 10, left: 10), child: Icon(Icons.music_note_sharp, size: 28, color: theme.primary,)),
                    Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: initDetails(),)),
                    Padding(padding: const EdgeInsets.only(right: 8, left: 4), child: Column(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.start, children: initIcons(),))
                ]),
            ),
        ]);
    }
}