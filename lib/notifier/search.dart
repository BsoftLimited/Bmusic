import 'package:bmusic/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchNotifier extends ChangeNotifier{
  List<SongModel> all;
  List<Category> results = [];

  SearchNotifier({ required this.all });

  find(String query){
    if(query.isNotEmpty){
      results = all.where((element){ 
          return element.album!.contains(query) || element.displayName.contains(query) || element.artist!.contains(query) || element.uri!.contains(query); 
      }).indexed.map((song)=> Category(index: song.$1, songModel: song.$2)).toList();
    }else{
      results = [];
    }
    notifyListeners();
  } 
}