import 'package:bmusic/blocs/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SongOptions extends StatelessWidget{
    final int? songID;

    const SongOptions({ super.key, required this.songID });

    @override
    Widget build(BuildContext context) {
        final songs = context.read<SettingsCubit>().state.songs;
        if(songID == null){
            return Container(child: Text("No song has been selected"));
        }

        return Container(alignment: Alignment.center, child: Text(songs[songID]!.name));
    }
}