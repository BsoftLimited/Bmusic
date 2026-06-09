import 'package:bmusic/blocs/playing_bloc.dart';
import 'package:bmusic/blocs/settings_bloc.dart';
import 'package:bmusic/blocs/states/playing_state.dart';
import 'package:bmusic/blocs/states/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectSong extends StatefulWidget{
    final int songId;
    final bool selected;
    final void Function(int, bool) select;

    const SelectSong({super.key, required this.songId, required this.selected, required this.select });

    @override
    State<StatefulWidget> createState() => __SelectSongState();
}

class __SelectSongState extends State<SelectSong>{

    @override
    Widget build(BuildContext context) {
        final SettingsState settingsState = context.read<SettingsCubit>().state;

        String title = settingsState.songs[widget.songId]!.title;
        String artist = settingsState.songs[widget.songId]!.artist ?? "--";
        String album = settingsState.songs[widget.songId]!.album ?? "--";

        return BlocBuilder<PlayingBloc, PlayingState>(builder: (context, state){
            return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Row(crossAxisAlignment: CrossAxisAlignment.start,  mainAxisAlignment: MainAxisAlignment.start, children: [
                    Padding(padding: const EdgeInsets.only(right: 10, left: 10), child: Icon(Icons.music_note_sharp, size: 28, color: Colors.white)),
                    Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text( title, maxLines: 1, textAlign: TextAlign.start, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 1.2, color: Colors.white)),
                        const SizedBox(height: 5),
                        Text("Artist : $artist", maxLines: 1, textAlign: TextAlign.start, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 1.2, color: Colors.white),),
                        const SizedBox(height: 2),
                        Text("Album : $album", maxLines: 1, textAlign: TextAlign.start, style: const TextStyle(fontSize: 12, color: Colors.white))
                    ])),
                    Checkbox(value: widget.selected, onChanged: (value){ widget.select(widget.songId, value!); })
                ]),
            ]);
        });
    }
}