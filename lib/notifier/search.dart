import 'package:bmusic/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchNotifier extends ChangeNotifier{
  List<SongModel> all;
  List<Category> __results = [];
  List<Category> get results => __results;

  SearchNotifier({ required this.all });

  find(String query){
      Future<List<Category>>((){
          query = query.toLowerCase();
          if(query.isNotEmpty){
            return all.where((element){ 
                return element.album!.toLowerCase().contains(query) || element.title.toLowerCase().contains(query) || element.artist!.toLowerCase().contains(query); 
            }).indexed.map((song)=> Category(index: song.$1, songModel: song.$2)).toList();
          }else{
            return [];
          }
      }).then((results){
          __results = results;
          notifyListeners();
      });
  }
  
}