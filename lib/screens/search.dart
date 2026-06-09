import 'dart:async';
import 'dart:developer';

import 'package:after_layout/after_layout.dart';
import 'package:bmusic/blocs/playing_bloc.dart';
import 'package:bmusic/blocs/settings_bloc.dart';
import 'package:bmusic/components/background.dart';
import 'package:bmusic/components/search_input.dart';
import 'package:bmusic/components/song_view.dart';
import 'package:bmusic/repositories/models/music.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart' show ReadContext;

class Search extends StatefulWidget{
    static const String routeName = "search";

    const Search({super.key});

    @override
    State<StatefulWidget> createState() => __SearchState();
}

class __SearchState extends State<Search> with AfterLayoutMixin<Search>{
    final TextEditingController __searchController = TextEditingController();
    List<int> results = [];
    Map<int,Music> songs = {};

    find(String query){
        log(query);
        Future<List<int>>((){
            query = query.toLowerCase();
            if(query.isNotEmpty){
                return songs.values.where((element){
                    return element.album!.toLowerCase().contains(query) || element.title.toLowerCase().contains(query) || element.artist!.toLowerCase().contains(query);
                }).map((song)=> song.id).toList();
            }else{
                return [];
            }
        }).then((results){
            setState(()=> this.results = results );
        });
    }

    @override
    FutureOr<void> afterFirstLayout(BuildContext context) {
        songs = context.read<SettingsCubit>().state.songs;
        __searchController.addListener((){
            find(__searchController.text);
        });
    }

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;

        void onPick(int song) => context.read<PlayingBloc>().pick(song: song, playlist: results);

        return Scaffold(body: Background(
            child: NestedScrollView(
                headerSliverBuilder: (context, value) => [
                    SliverAppBar(backgroundColor: Colors.transparent, elevation: 0,
                        foregroundColor: theme.onPrimary,
                        leadingWidth: 30,
                        title: Row(children: [
                            Icon(Icons.manage_search, color: theme.onPrimary, size: 32,),
                            SizedBox(width: 8),
                            Text("Music Search", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: theme.onPrimary)),
                        ]),
                        collapsedHeight: 120,
                        flexibleSpace: Padding(padding: const EdgeInsets.all(10.0),
                            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                                Row(children: [
                                    Expanded(child: SearchInput( controller: __searchController))
                                ]),
                            ]),
                        ),
                        floating: true, pinned: true,
                    ),
                ],
                body: ListView.builder(padding: EdgeInsets.zero, itemCount: results.length,
                    itemBuilder:(context, index) =>  SongView(songId: results[index], picked: onPick),
                ),
        )));
    }
}