import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:bmusic/blocs/library_bloc.dart';
import 'package:bmusic/blocs/settings_bloc.dart';
import 'package:bmusic/components/background.dart';
import 'package:bmusic/components/select_song.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Selection extends StatefulWidget{
    static const String routeName = "selection";

    const Selection({ super.key });

    @override
    State<StatefulWidget> createState() => __SelectionState();
}

class __SelectionState extends State<Selection> with AfterLayoutMixin<Selection>{
    late String args;
    bool allSelected = false;
    List<int> playlist = [];

    @override
    FutureOr<void> afterFirstLayout(BuildContext context) {
        setState(() {
            playlist = context.read<LibraryBloc>().state.playlists[args]!;
        });
    }

    void clicked(int song, bool selected){
        if(selected){
            setState(() { playlist.add(song); });
        }else{
            setState(() {
                playlist.remove(song);
                allSelected = false;
            });
        }
    }

    void save(){
        context.read<LibraryBloc>().addToPlaylist(playlist: args, songs: playlist).then((value){
           Navigator.pop(context);
        });
    }

    void all(bool? selected){
        if(selected!){
            setState(() {
                playlist = context.read<SettingsCubit>().state.songs.keys.toList();
                allSelected = true;
            });
        }else{
            setState(() {
                playlist = [];
                allSelected = false;
            });
        }
    }

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;
        final songs = context.read<SettingsCubit>().state.songs.keys;
        args = ModalRoute.of(context)!.settings.arguments as String;
        return Scaffold(
            body: Background(child: NestedScrollView(
                headerSliverBuilder:  (context, value) => [
                    SliverAppBar(backgroundColor: theme.surface, elevation: 0,
                        title: Row(children: [
                            Icon(Icons.playlist_add, color: theme.primary, size: 40,),
                            SizedBox(width: 8),
                            Text(args, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: theme.primary)),
                        ]),
                        actions: [
                            MaterialButton(padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), onPressed: save, color: theme.primary,
                                child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                    Icon(Icons.save, color: theme.onPrimary, size: 16),
                                    SizedBox(width: 4),
                                    Text("save", style: TextStyle(fontSize: 14, color: theme.onPrimary)),
                            ])),
                            SizedBox(width: 8)
                        ],
                        collapsedHeight: 120,
                        flexibleSpace: Column(mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                Padding(padding: const EdgeInsets.only(left: 20),
                                    child: Text("All", style: TextStyle(color: theme.onSurface, fontSize: 18, fontWeight: FontWeight.bold)),
                                ),
                                Checkbox(value: allSelected, onChanged: all)
                            ]),
                          ],
                        ),
                        leadingWidth: 30,
                        floating: true, pinned: true),
                ],
                body: ListView.separated(itemCount: songs.length, padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context, int index){
                        return SelectSong(songId: songs.elementAt(index), selected: playlist.contains(songs.elementAt(index)),
                            select: clicked);
                    },
                    separatorBuilder: (BuildContext context, int index) => const Divider()
                ),
            )),
        );
    }
}