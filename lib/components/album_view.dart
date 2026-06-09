import 'package:bmusic/blocs/library_bloc.dart';
import 'package:bmusic/blocs/playing_bloc.dart';
import 'package:bmusic/blocs/states/library_state.dart';
import 'package:bmusic/blocs/states/playing_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumView extends StatelessWidget{
    final int index;

    const AlbumView({super.key, required this.index });

    void select(){} 

    @override
    Widget build(BuildContext context) {
        ColorScheme theme = Theme.of(context).colorScheme;
        
        return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            TextButton( onPressed: select,
                child: Row(crossAxisAlignment: CrossAxisAlignment.start,  mainAxisAlignment: MainAxisAlignment.start, children: [
                    Padding(padding: const EdgeInsets.only(right: 10, left: 10), child: Icon(Icons.album, size: 38, color: theme.onPrimary,)),
                    Expanded(
                        child: BlocBuilder<LibraryBloc, LibraryState>(builder: (context, state){
                            return Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  Text( state.albumsTitles[index], maxLines: 1, textAlign: TextAlign.start, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 1.2, color: theme.onPrimary)),
                                  const SizedBox(height: 5,),
                                  Text("${state.albums[state.albumsTitles[index]]!.length} songs", maxLines: 1, textAlign: TextAlign.start, style: const TextStyle(fontSize: 12, color: Colors.white),)
                            ]);
                        })
                    )
                ]),
            ),
        ]);
    }
}