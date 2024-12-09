import 'package:bmusic/blocs/settings_bloc.dart';
import 'package:bmusic/blocs/states/settings_state.dart';
import 'package:bmusic/components/song_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Songs extends StatefulWidget{
    const Songs({super.key});

    @override
    State<StatefulWidget> createState() => __SongsState();
}

class __SongsState extends State<Songs>{
   
    @override
    Widget build(BuildContext context) {

        return BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return ListView.separated(itemCount: state.songs.length, padding: const EdgeInsets.only(bottom: 140),
                itemBuilder: (BuildContext context, int index) => SongView(songId: state.songs.keys.toList()[index],),
                separatorBuilder: (BuildContext context, int index) => const Divider()
            );
          }
        );
    }
}