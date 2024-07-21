import 'package:bmusic/components/search_input.dart';
import 'package:bmusic/components/song_model.dart';
import 'package:bmusic/notifier/playing.dart';
import 'package:bmusic/notifier/search.dart';
import 'package:bmusic/notifier/widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget{
  const Search({super.key});

  @override
  State<StatefulWidget> createState() => __SearchState();
}

class __SearchState extends State<Search>{
    final TextEditingController __searchController = TextEditingController();
    late SearchNotifier __searchNotifier;

    @override
    void initState() {
        super.initState();
        __searchController.addListener((){
            __searchNotifier.find(__searchController.text);
        });
    }

  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;
    
    PlayingStateNotifier playingStateNotifier = context.watch<PlayingStateNotifier>();
    
    return NotifierWidget<SearchNotifier>(
        notifier: SearchNotifier(all: playingStateNotifier.songs),
        builder: (context, searchNotifier, widget){
            __searchNotifier = searchNotifier;
            return Scaffold(
              extendBody: true,
              appBar: AppBar(backgroundColor: theme.surface, elevation: 0,
                  title: Row(mainAxisSize: MainAxisSize.max, children: [
                    Expanded(child: SearchInput( controller: __searchController)) ])),
              body: ListView.separated(itemCount: __searchNotifier.results.length,
                  itemBuilder:(context, index) =>  SongView(songModel: __searchNotifier.results[index].songModel,),
                  separatorBuilder: (context, index) =>  const Divider()),
            );
        }
    );
  }
}