import 'package:bmusic/blocs/playing_bloc.dart';
import 'package:bmusic/blocs/states/playing_state.dart';
import 'package:bmusic/components/artists_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Artists extends StatelessWidget{
    const Artists({super.key});

    @override
    Widget build(BuildContext context) {
        return BlocBuilder<PlayingBloc, PlayingState>(
            builder: (buildContext, state){
                return ListView.separated(itemCount: state.artistNames.length, padding: const EdgeInsets.only(bottom: 140),
                    itemBuilder: (BuildContext context, int index) => ArtistView(index:index),
                    separatorBuilder: (BuildContext context, int index) => const Divider()
                );
        }); 
    }
}