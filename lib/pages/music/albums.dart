import 'package:bmusic/blocs/playing_bloc.dart';
import 'package:bmusic/blocs/states/playing_state.dart';
import 'package:bmusic/components/album_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Albums extends StatelessWidget{

  const Albums({super.key});

    @override
    Widget build(BuildContext context) {
        return BlocBuilder<PlayingBloc, PlayingState>(
            builder: (buildContext, state){  
                return ListView.separated(itemCount: state.albumsTitles.length, padding: const EdgeInsets.only(bottom: 140),
                    itemBuilder: (BuildContext context, int index) => AlbumView(index:index),
                    separatorBuilder: (BuildContext context, int index) => const Divider()
                );
            });
    }
}

/*
SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 4.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.teal[100 * (index % 9)],
                  child: Text('Grid Item $index'),
                );
              },
              childCount: 20,
            ),
          ),
 */

//return Text("${albumsNotifier.albumsTitles[index]} - ${ albumsNotifier.songs(albumsNotifier.albumsTitles[index]).length }");