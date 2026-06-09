import 'package:bmusic/blocs/playing_bloc.dart';
import 'package:bmusic/blocs/settings_bloc.dart';
import 'package:bmusic/blocs/states/settings_state.dart';
import 'package:bmusic/components/song_view.dart';
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
                if(state.songs.isEmpty){
                    return Center(child: Text("No songs found", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)));
                }

                void onChoose(int songId) => context.read<PlayingBloc>().pick(song: songId, playlist: state.songs.keys.toList());

                return ListView.builder(itemCount: state.songs.length, padding: const EdgeInsets.only(bottom: 60),
                    itemBuilder: (BuildContext context, int index) => SongView(songId: state.songs.keys.elementAt(index), picked: onChoose),
                  physics: BouncingScrollPhysics(),
                );
            }
        );
    }
}