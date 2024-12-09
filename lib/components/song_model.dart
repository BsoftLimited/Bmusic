import 'package:bmusic/blocs/playing_bloc.dart';
import 'package:bmusic/blocs/settings_bloc.dart';
import 'package:bmusic/blocs/states/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:mini_music_visualizer/mini_music_visualizer.dart';
import 'package:provider/provider.dart';

class SongView extends StatefulWidget{
    final int? songId;

    const SongView({super.key, required this.songId});

    @override
    State<StatefulWidget> createState() => __SongVeiwState();
}

class __SongVeiwState extends State<SongView>{
    late ColorScheme theme;
    late PlayingBloc playingBloc;

    List<Widget> initDetails(BuildContext context){
        final SettingsState settingsState = context.read<SettingsCubit>().state;

        String title = (settingsState.songs[widget.songId])?.title ?? "----";
        String artist = (settingsState.songs[widget.songId])?.artist ?? "--";
        String album = (settingsState.songs[widget.songId])?.album ?? "--";

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

        if(widget.songId != null && playingBloc.state.current == widget.songId){
            init.add(MiniMusicVisualizer( color: theme.primary, width: 4, height: 15, animate: playingBloc.state.playing));
        }
        return init;
    }

    @override
    Widget build(BuildContext context) {
        playingBloc = context.read<PlayingBloc>(); 
        theme = Theme.of(context).colorScheme;

        void select()=> playingBloc.current = widget.songId;
        
        return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            TextButton( onPressed: select,
                child: Row(crossAxisAlignment: CrossAxisAlignment.start,  mainAxisAlignment: MainAxisAlignment.start, children: [
                    Padding(padding: const EdgeInsets.only(right: 10, left: 10), child: Icon(Icons.music_note_sharp, size: 28, color: theme.primary,)),
                    Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: initDetails(context),)),
                    Padding(padding: const EdgeInsets.only(right: 8, left: 4), child: Column(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.start, children: initIcons(),))
                ]),
            ),
        ]);
    }
}