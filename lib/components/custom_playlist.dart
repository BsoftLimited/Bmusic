import 'package:bmusic/blocs/library_bloc.dart';
import 'package:bmusic/blocs/states/library_state.dart';
import 'package:bmusic/screens/playlist.dart';
import 'package:bmusic/screens/selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomPlaylist extends StatelessWidget{
    final String name;

    const CustomPlaylist({ super.key, required this.name });

    @override
    Widget build(BuildContext context) {
        final theme = Theme.of(context).colorScheme;

        void navigate() => Navigator.pushNamed(context, Playlist.routeName, arguments: name);

        return DecoratedBox(decoration: BoxDecoration(color: theme.surface, borderRadius: BorderRadius.circular(10)),
            child: TextButton(style: ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.all(10))), onPressed: navigate,
                child: Row(children: [
                    DecoratedBox(decoration: BoxDecoration(color: theme.surfaceContainerHighest, borderRadius: BorderRadius.circular(10)),
                        child: Padding(padding: const EdgeInsets.all(10.0), child: Icon(Icons.playlist_play, color: theme.primary, size: 30))),
                    SizedBox(width: 10),
                    Expanded(child: BlocBuilder<LibraryBloc, LibraryState>(
                      builder: (context, state) {
                          return Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text(name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300, letterSpacing: 1.4)),
                              SizedBox(height: 4),
                              Text("Songs: ${state.playlists[name]!.length}", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300))
                          ]);
                      }
                    )),
                    SizedBox(width: 30, height: 30,
                        child: IconButton( padding: EdgeInsets.zero, iconSize: 28, color: theme.secondary, onPressed: (){
                            Navigator.pushNamed(context, Selection.routeName, arguments: name);
                        }, icon: Icon(Icons.playlist_add_outlined)),
                    ),
                    SizedBox(width: 30, height: 30,
                        child: IconButton( padding: EdgeInsets.zero, iconSize: 28, color: theme.secondary, onPressed: (){}, icon: Icon(Icons.delete_forever))),
                ]),
            )
        );
    }
}

