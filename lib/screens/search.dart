import 'package:bmusic/components/search_input.dart';
import 'package:bmusic/components/song_model.dart';
import 'package:bmusic/notifier/playing.dart';
import 'package:bmusic/notifier/search.dart';
import 'package:bmusic/notifier/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget{
  const Search({super.key});

  @override
  State<StatefulWidget> createState() => __SearchState();
}

class __SearchState extends State<Search>{
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ThemeNotifier themeNotifier = context.watch<ThemeNotifier>();
    PlayingStateNotifier playingStateNotifier = context.watch<PlayingStateNotifier>();
    
    return ChangeNotifierProvider<SearchNotifier>(
        create: (BuildContext context) => SearchNotifier(all: playingStateNotifier.songs),
        builder: (context, widget){
          SearchNotifier notifier = context.watch<SearchNotifier>();
          return Scaffold(
            extendBody: true,
            appBar: AppBar(backgroundColor: themeNotifier.current.secondary, elevation: 0,
                title: Row(mainAxisSize: MainAxisSize.max, children: [
                  Text('Search', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: themeNotifier.current.primary)), 
                  SizedBox(width: 200, child: SearchInput( controller: searchController)) ]),
                leading: Icon(Icons.search_outlined, color: themeNotifier.current.primary, size: 24,)),
            body: ListView.builder(itemCount: notifier.results.length,
                itemBuilder:(context, index) =>  SongView(songModel: notifier.results[index],)),
          );
        }
    );
  }
}