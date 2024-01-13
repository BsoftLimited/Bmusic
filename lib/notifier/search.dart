import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchNotifier extends ChangeNotifier{
  List<SongModel> all;
  List<SongModel> results = [];

  SearchNotifier({ required this.all });

  find(String query){
    if(query.isNotEmpty){
      results = all.where((element) => element.album!.contains(query) || element.displayName.contains(query) || element.artist!.contains(query) || element.uri!.contains(query)).toList();
    }else{
      results = [];
    }
    notifyListeners();
  } 
}