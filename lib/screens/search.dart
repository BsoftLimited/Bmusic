import 'package:bmusic/blocs/settings_bloc.dart';
import 'package:bmusic/blocs/states/settings_state.dart';
import 'package:bmusic/components/search_input.dart';
import 'package:bmusic/components/song_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget{
    static const String routeName = "/search";

    const Search({super.key});

    @override
    State<StatefulWidget> createState() => __SearchState();
}

class __SearchState extends State<Search>{
    final TextEditingController __searchController = TextEditingController();
    late SettingsState settingsState;

    List<int> results = [];

    find(String query){
      Future<List<int>>((){
          query = query.toLowerCase();
          if(query.isNotEmpty){
            return settingsState.songs.values.where((element){ 
                return element.album!.toLowerCase().contains(query) || element.title.toLowerCase().contains(query) || element.artist!.toLowerCase().contains(query); 
            }).map((song)=> song.id).toList();
          }else{
            return [];
          }
      }).then((results){
          setState(() {
              this.results = results;
          });
      });
  }

    @override
    void initState() {
        super.initState();
        __searchController.addListener((){
            find(__searchController.text);
        });
    }

    @override
    Widget build(BuildContext context) {
      final ColorScheme theme = Theme.of(context).colorScheme;
      settingsState = context.read<SettingsCubit>().state;
      
      return Scaffold(
          extendBody: true,
          appBar: AppBar(backgroundColor: theme.surface, elevation: 0,
              title: Row(mainAxisSize: MainAxisSize.max, children: [
                Expanded(child: SearchInput( controller: __searchController)) ])),
          body: ListView.separated(itemCount: results.length,
            itemBuilder:(context, index) =>  SongView(songId: results[index],),
            separatorBuilder: (context, index) =>  const Divider()),
      );
    }
}