import 'package:bmusic/blocs/library_bloc.dart';
import 'package:bmusic/blocs/states/library_state.dart';
import 'package:bmusic/components/artists_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Artists extends StatelessWidget{
    const Artists({super.key});

    @override
    Widget build(BuildContext context) {
        return BlocBuilder<LibraryBloc, LibraryState>(
            builder: (buildContext, state){
                if(state.artists.isEmpty){
                    return Center(child: Text("No Artists found", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)));
                }

                return ListView.separated(itemCount: state.artistNames.length, padding: const EdgeInsets.only(bottom: 140),
                    itemBuilder: (BuildContext context, int index) => ArtistView(index:index),
                    separatorBuilder: (BuildContext context, int index) => const Divider()
                );
        }); 
    }
}